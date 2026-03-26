import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/scanner.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar/action_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/short_textfield_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/app_header.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/card_box.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/common/widgets/unencrypted_image_in_card.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:school_data_hub_flutter/core/notification_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_proxy_manager.dart';
import 'package:school_data_hub_flutter/features/books/domain/book_manager.dart';
import 'package:school_data_hub_flutter/features/books/domain/models/library_book_proxy.dart';
import 'package:school_data_hub_flutter/features/books/domain/pupil_book_lending_manager.dart';

class BookReturnScreen extends StatefulWidget {
  const BookReturnScreen({super.key});

  @override
  State<BookReturnScreen> createState() => _BookReturnScreenState();
}

class _BookReturnScreenState extends State<BookReturnScreen> {
  LibraryBookProxy? _scannedBook;
  PupilBookLending? _activeLending;

  BookManager get _bookManager => di<BookManager>();
  PupilBookLendingManager get _lendingManager => di<PupilBookLendingManager>();

  Future<void> _scanOrEnterLibraryId() async {
    String? libraryId;

    if (Platform.isWindows) {
      libraryId = await shortTextfieldDialog(
        context: context,
        title: 'Buch-ID eingeben',
        labelText: 'Buch-ID',
        hintText: 'Bitte geben Sie die Buch-ID ein',
      );
    } else {
      final scanned = await qrScanner(
        context: context,
        overlayText: 'Buch-ID scannen',
      );
      if (scanned != null) {
        libraryId = scanned.replaceFirst('Buch ID: ', '').trim();
      }
    }

    if (libraryId == null || libraryId.isEmpty) return;

    final proxy = _bookManager.libraryBookProxies.value.firstWhereOrNull(
      (p) => p.libraryId == libraryId,
    );
    if (proxy == null) {
      if (mounted) {
        di<NotificationManager>().showSnackBar(
          NotificationType.error,
          'Buch mit ID "$libraryId" nicht gefunden',
        );
      }
      return;
    }

    if (proxy.available) {
      if (mounted) {
        di<NotificationManager>().showSnackBar(
          NotificationType.error,
          'Dieses Buch ist nicht verliehen',
        );
      }
      return;
    }

    final lending = _lendingManager.getActiveLendingByLibraryBookId(proxy.id);
    if (lending == null) {
      if (mounted) {
        di<NotificationManager>().showSnackBar(
          NotificationType.error,
          'Kein aktiver Leihvorgang gefunden',
        );
      }
      return;
    }

    setState(() {
      _scannedBook = proxy;
      _activeLending = lending;
    });
  }

  Future<void> _confirmReturn() async {
    if (_activeLending == null) return;

    await _lendingManager.returnLibraryBook(pupilBookLending: _activeLending!);

    if (mounted) {
      setState(() {
        _scannedBook = null;
        _activeLending = null;
      });
    }
  }

  String _borrowerName(PupilBookLending lending) {
    if (lending.borrowerType == 'user') {
      return lending.borrowerUser?.userInfo?.userName ?? 'Unbekannt';
    }
    if (lending.pupilId != null) {
      final pupil = di<PupilProxyManager>().getPupilByPupilId(lending.pupilId!);
      if (pupil != null) {
        return '${pupil.firstName} ${pupil.lastName}';
      }
    }
    return 'Unbekannt';
  }

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);

    return Scaffold(
      backgroundColor: style.colors.canvas,
      appBar: const AppHeader(
        iconData: Icons.book_rounded,
        title: 'Buch zurückgeben',
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(Style.spacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Step 1: Scan book
                _ReturnStepCard(
                  stepNumber: 1,
                  title: 'Buch scannen',
                  isComplete: _scannedBook != null,
                  child: _scannedBook != null
                      ? _ScannedBookInfo(
                          proxy: _scannedBook!,
                          lending: _activeLending!,
                          borrowerName: _borrowerName(_activeLending!),
                        )
                      : null,
                  onAction: _scanOrEnterLibraryId,
                  actionLabel: _scannedBook != null
                      ? 'Anderes Buch'
                      : 'Scannen',
                  actionIcon: _scannedBook != null
                      ? Icons.refresh
                      : Icons.qr_code_scanner,
                ),

                if (_activeLending != null) ...[
                  const Gap(12),

                  // Step 2: Confirm return
                  _ReturnStepCard(
                    stepNumber: 2,
                    title: 'Rückgabe bestätigen',
                    isComplete: false,
                    onAction: _confirmReturn,
                    actionLabel: 'Zurückgeben',
                    actionIcon: Icons.check_circle,
                    actionColor: style.colors.success,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const ActionBar(),
    );
  }
}

class _ScannedBookInfo extends StatelessWidget {
  final LibraryBookProxy proxy;
  final PupilBookLending lending;
  final String borrowerName;

  const _ScannedBookInfo({
    required this.proxy,
    required this.lending,
    required this.borrowerName,
  });

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final isUser = lending.borrowerType == 'user';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UnencryptedImageInCard(
              cacheKey: proxy.isbn.toString(),
              path: proxy.imagePath,
              type: UnencryptedImageType.book,
              size: 80,
            ),
            const Gap(10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    proxy.title,
                    style: context.typography.body.bold,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    proxy.author,
                    style: context.typography.bodySmall.muted(context),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
        const Gap(10),
        CardBox(
          padding: EdgeInsets.all(Style.spacing.md),
          child: Row(
            children: [
              Icon(
                isUser ? Icons.person : Icons.child_care,
                size: 28,
                color: style.colors.foreground,
              ),
              const Gap(10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isUser ? 'Benutzer' : 'Kind',
                      style: context.typography.caption.muted(context),
                    ),
                    Text(borrowerName, style: context.typography.body.bold),
                    const Gap(4),
                    Row(
                      children: [
                        Text(
                          'Ausgeliehen am: ',
                          style: context.typography.bodySmall.muted(context),
                        ),
                        Text(
                          lending.lentAt.formatDateForUser(),
                          style: context.typography.bodySmall.bold,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ReturnStepCard extends StatelessWidget {
  final int stepNumber;
  final String title;
  final bool isComplete;
  final Widget? child;
  final VoidCallback? onAction;
  final String? actionLabel;
  final IconData? actionIcon;
  final Color? actionColor;

  const _ReturnStepCard({
    required this.stepNumber,
    required this.title,
    required this.isComplete,
    this.child,
    this.onAction,
    this.actionLabel,
    this.actionIcon,
    this.actionColor,
  });

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);

    return CardBox(
      padding: EdgeInsets.all(Style.spacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: isComplete
                      ? style.colors.success
                      : style.colors.accent,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: isComplete
                      ? Icon(
                          Icons.check,
                          size: 16,
                          color: style.colors.accentForeground,
                        )
                      : Text(
                          '$stepNumber',
                          style: context.typography.body.bold.withColor(
                            style.colors.accentForeground,
                          ),
                        ),
                ),
              ),
              const Gap(10),
              Expanded(
                child: Text(title, style: context.typography.subtitle.bold),
              ),
              if (onAction != null)
                GestureDetector(
                  onTap: onAction,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: Style.spacing.md,
                      vertical: Style.spacing.sm,
                    ),
                    decoration: BoxDecoration(
                      color: actionColor ?? style.colors.accent,
                      borderRadius: BorderRadius.circular(Style.radii.small),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (actionIcon != null) ...[
                          Icon(
                            actionIcon,
                            size: 18,
                            color: style.colors.accentForeground,
                          ),
                          const Gap(4),
                        ],
                        Text(
                          actionLabel ?? '',
                          style: context.typography.bodySmall.bold.withColor(
                            style.colors.accentForeground,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          if (child != null) ...[const Gap(10), child!],
        ],
      ),
    );
  }
}
