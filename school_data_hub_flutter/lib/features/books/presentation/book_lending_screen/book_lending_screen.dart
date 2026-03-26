import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/scanner.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar/action_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/short_textfield_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/app_header.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/card_box.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/common/widgets/unencrypted_image_in_card.dart';
import 'package:school_data_hub_flutter/core/notification_manager.dart';
import 'package:school_data_hub_flutter/core/router/route_paths.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_proxy_manager.dart';
import 'package:school_data_hub_flutter/features/books/domain/book_manager.dart';
import 'package:school_data_hub_flutter/features/books/domain/models/library_book_proxy.dart';
import 'package:school_data_hub_flutter/features/books/domain/pupil_book_lending_manager.dart';
import 'package:school_data_hub_flutter/features/user/domain/user_manager.dart';

class BookLendingScreen extends StatefulWidget {
  const BookLendingScreen({super.key});

  @override
  State<BookLendingScreen> createState() => _BookLendingScreenState();
}

class _BookLendingScreenState extends State<BookLendingScreen> {
  LibraryBookProxy? _selectedBook;
  String? _borrowerType; // 'pupil' or 'user'
  PupilProxy? _selectedPupil;
  User? _selectedUser;

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

    if (!proxy.available) {
      if (mounted) {
        di<NotificationManager>().showSnackBar(
          NotificationType.error,
          'Dieses Buch ist bereits verliehen',
        );
      }
      return;
    }

    setState(() {
      _selectedBook = proxy;
      _borrowerType = null;
      _selectedPupil = null;
      _selectedUser = null;
    });
  }

  Future<void> _selectPupil() async {
    final allPupils = di<PupilProxyManager>().allPupils;
    final selectedIds = await context.push<List<int>>(
      RoutePaths.utilSelectPupils,
      extra: {'selectablePupils': allPupils, 'isMultiSelectMode': false},
    );
    if (selectedIds == null || selectedIds.isEmpty) return;

    final pupil = di<PupilProxyManager>().getPupilByPupilId(selectedIds.first);
    if (pupil == null) return;

    setState(() {
      _selectedPupil = pupil;
      _selectedUser = null;
    });
  }

  Future<void> _selectUser() async {
    final allUsers = di<UserManager>().users.value;
    final selectedUsers = await context.push<List<User>>(
      RoutePaths.utilSelectUsers,
      extra: {'selectableUsers': allUsers, 'isMultiSelectMode': false},
    );
    if (selectedUsers == null || selectedUsers.isEmpty) return;

    setState(() {
      _selectedUser = selectedUsers.first;
      _selectedPupil = null;
    });
  }

  Future<void> _confirmLending() async {
    if (_selectedBook == null) return;

    final libraryId = _selectedBook!.libraryId;

    if (_borrowerType == 'pupil' && _selectedPupil != null) {
      await _lendingManager.postPupilBookLending(
        pupilId: _selectedPupil!.pupilId,
        libraryId: libraryId,
      );
    } else if (_borrowerType == 'user' && _selectedUser != null) {
      await _lendingManager.postUserBookLending(
        userId: _selectedUser!.id!,
        libraryId: libraryId,
      );
    } else {
      return;
    }

    if (mounted) {
      setState(() {
        _selectedBook = null;
        _borrowerType = null;
        _selectedPupil = null;
        _selectedUser = null;
      });
    }
  }

  bool get _canConfirm =>
      _selectedBook != null &&
      ((_borrowerType == 'pupil' && _selectedPupil != null) ||
          (_borrowerType == 'user' && _selectedUser != null));

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);

    return Scaffold(
      backgroundColor: style.colors.canvas,
      appBar: const AppHeader(
        iconData: Icons.book_rounded,
        title: 'Buch ausleihen',
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
                _StepCard(
                  stepNumber: 1,
                  title: 'Buch scannen',
                  isComplete: _selectedBook != null,

                  onAction: _scanOrEnterLibraryId,
                  actionLabel: _selectedBook != null
                      ? 'Anderes Buch'
                      : 'Scannen',
                  actionIcon: _selectedBook != null
                      ? Icons.refresh
                      : Icons.qr_code_scanner,
                  child: _selectedBook != null
                      ? _BookInfoTile(proxy: _selectedBook!)
                      : null,
                ),

                const Gap(12),

                // Step 2: Pick borrower type
                if (_selectedBook != null) ...[
                  _StepCard(
                    stepNumber: 2,
                    title: 'Ausleiher-Typ',
                    isComplete: _borrowerType != null,
                    child: Row(
                      children: [
                        Expanded(
                          child: _TypeButton(
                            label: 'Kind',
                            icon: Icons.child_care,
                            isSelected: _borrowerType == 'pupil',
                            onTap: () => setState(() {
                              _borrowerType = 'pupil';
                              _selectedPupil = null;
                              _selectedUser = null;
                            }),
                          ),
                        ),
                        const Gap(8),
                        Expanded(
                          child: _TypeButton(
                            label: 'Benutzer',
                            icon: Icons.person,
                            isSelected: _borrowerType == 'user',
                            onTap: () => setState(() {
                              _borrowerType = 'user';
                              _selectedPupil = null;
                              _selectedUser = null;
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(12),
                ],

                // Step 3: Select borrower
                if (_borrowerType != null) ...[
                  _StepCard(
                    stepNumber: 3,
                    title: _borrowerType == 'pupil'
                        ? 'Kind auswählen'
                        : 'Benutzer auswählen',
                    isComplete: _selectedPupil != null || _selectedUser != null,
                    child: _selectedPupil != null
                        ? Text(
                            '${_selectedPupil!.firstName} ${_selectedPupil!.lastName}',
                            style: context.typography.body.bold,
                          )
                        : _selectedUser != null
                        ? Text(
                            _selectedUser!.userInfo?.userName ?? '',
                            style: context.typography.body.bold,
                          )
                        : null,
                    onAction: _borrowerType == 'pupil'
                        ? _selectPupil
                        : _selectUser,
                    actionLabel: 'Auswählen',
                    actionIcon: Icons.person_search,
                  ),
                  const Gap(12),
                ],

                // Step 4: Confirm
                if (_canConfirm) ...[
                  _StepCard(
                    stepNumber: 4,
                    title: 'Bestätigen',
                    isComplete: false,
                    onAction: _confirmLending,
                    actionLabel: 'Ausleihen',
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

class _StepCard extends StatelessWidget {
  final int stepNumber;
  final String title;
  final bool isComplete;
  final Widget? child;
  final VoidCallback? onAction;
  final String? actionLabel;
  final IconData? actionIcon;
  final Color? actionColor;

  const _StepCard({
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

class _TypeButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _TypeButton({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(Style.spacing.md),
        decoration: BoxDecoration(
          color: isSelected ? style.colors.accent : style.colors.background,
          borderRadius: BorderRadius.circular(Style.radii.small),
          border: Border.all(
            color: isSelected ? style.colors.accent : style.colors.border,
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 28,
              color: isSelected
                  ? style.colors.accentForeground
                  : style.colors.foreground,
            ),
            const Gap(4),
            Text(
              label,
              style: context.typography.body.bold.withColor(
                isSelected
                    ? style.colors.accentForeground
                    : style.colors.foreground,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BookInfoTile extends StatelessWidget {
  final LibraryBookProxy proxy;

  const _BookInfoTile({required this.proxy});

  @override
  Widget build(BuildContext context) {
    return Row(
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
              Text(
                'ID: ${proxy.libraryId}',
                style: context.typography.caption.muted(context),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
