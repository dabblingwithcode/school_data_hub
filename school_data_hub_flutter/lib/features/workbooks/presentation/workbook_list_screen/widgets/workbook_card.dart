import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/extensions/isbn_extensions.dart';
import 'package:school_data_hub_flutter/common/widgets/avatar/avatar.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/information_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/expansion/expansion_body.dart';
import 'package:school_data_hub_flutter/common/widgets/expansion/expansion_controller.dart';
import 'package:school_data_hub_flutter/common/widgets/expansion/expansion_header.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/card_box.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_proxy_manager.dart';
import 'package:school_data_hub_flutter/features/learning/_competence/presentation/widgets/competence_grades_widget.dart';
import 'package:school_data_hub_flutter/features/workbooks/domain/pupil_workbook_manager.dart';
import 'package:school_data_hub_flutter/features/workbooks/domain/workbook_enums.dart';
import 'package:school_data_hub_flutter/features/workbooks/domain/workbook_manager.dart';
import 'package:school_data_hub_flutter/features/workbooks/presentation/common/workbook_image.dart';
import 'package:school_data_hub_flutter/features/workbooks/presentation/new_workbook_screen/new_workbook_screen.dart';

class WorkbookCard extends WatchingWidget {
  const WorkbookCard({required this.workbook, super.key});
  final Workbook workbook;

  @override
  Widget build(BuildContext context) {
    final expansionTileController = createOnce<ExpansionController>(
      () => ExpansionController(),
    );

    return CardBox(
      padding: EdgeInsets.zero,
      onTap: null,
      child: GestureDetector(
        onLongPress: () async {
          if (!di<HubSessionManager>().isAdmin) {
            informationDialog(
              context,
              'Keine Berechtigung',
              'Arbeitshefte können nur von Admins bearbeitet werden!',
            );
            return;
          }
          final bool? result = await confirmationDialog(
            context: context,
            title: 'Arbeitsheft löschen',
            message:
                'Arbeitsheft "${workbook.name}" wirklich löschen? ACHTUNG: Alle Arbeitshefte dieser Art werden ebenfalls gelöscht!',
          );
          if (result == true) {
            await di<WorkbookManager>().deleteWorkbook(workbook);
          }
        },
        child: _WorkbookCardContent(
          workbook: workbook,
          expansionTileController: expansionTileController,
        ),
      ),
    );
  }
}

/// Rebuilds only when [PupilWorkbookManager] (pupil workbooks list) changes.
class _WorkbookCardContent extends WatchingWidget {
  final Workbook workbook;
  final ExpansionController expansionTileController;

  const _WorkbookCardContent({
    required this.workbook,
    required this.expansionTileController,
  });

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final pupilWorkbookManager = watch(di<PupilWorkbookManager>());
    final pupilWorkbooks = pupilWorkbookManager
        .getAllPupilWorkbooks()
        .where((pw) => pw.isbn == workbook.isbn)
        .toList();

    return Padding(
      padding: EdgeInsets.only(top: Style.spacing.sm, bottom: Style.spacing.xs),
      child: Column(
        children: [
          Row(
            children: [
              Gap(Style.spacing.lg),
              Expanded(
                child: GestureDetector(
                  onLongPress: (di<HubSessionManager>().isAdmin)
                      ? () async {
                          Navigator.of(context).push<void>(
                            MaterialPageRoute<void>(
                              builder: (ctx) => NewWorkbookScreen(
                                workbook: workbook,
                                isbn: workbook.isbn,
                                isEdit: true,
                              ),
                            ),
                          );
                        }
                      : () {},
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      workbook.name,
                      style: context.typography.title.withColor(
                        style.colors.foreground,
                      ),
                    ),
                  ),
                ),
              ),
              Gap(Style.spacing.sm),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(Style.spacing.lg),
              WorkbookImage(workbook: workbook),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 2,
                    left: Style.spacing.lg,
                    bottom: Style.spacing.sm,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('ISBN:', style: context.typography.body),
                          Gap(Style.spacing.sm),
                          SelectableText(
                            workbook.isbn.displayAsIsbn(),
                            style: context.typography.subtitle.withColor(
                              style.colors.foreground,
                            ),
                          ),
                        ],
                      ),
                      Gap(Style.spacing.xs),
                      Wrap(
                        spacing: Style.spacing.sm,
                        runSpacing: Style.spacing.xs,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(
                            'Kompetenzbereich(e):',
                            style: context.typography.body,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                workbook.subject != null
                                    ? SubjectEnum.values
                                              .firstWhereOrNull(
                                                (element) =>
                                                    element.name ==
                                                    workbook.subject,
                                              )
                                              ?.imagePath ??
                                          'assets/images/learning_icons/unknown.png'
                                    : 'assets/images/learning_icons/unknown.png',
                                width: 30,
                                height: 30,
                              ),
                              Gap(Style.spacing.xs),
                              Text(
                                workbook.subject ?? 'nicht angegeben',
                                style: context.typography.subtitle.withColor(
                                  style.colors.foreground,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Gap(Style.spacing.xs),
                      Wrap(
                        runSpacing: Style.spacing.xs,
                        children: [
                          Text(
                            'Kompetenzstufe:',
                            style: context.typography.body,
                          ),
                          SizedBox(width: Style.spacing.xs),
                          workbook.level != null
                              ? GradesWidget(
                                  stringWithGrades: workbook.level!,
                                )
                              : Text(
                                  'nicht angegeben',
                                  overflow: TextOverflow.fade,
                                  style:
                                      context.typography.subtitle.withColor(
                                        style.colors.foreground,
                                      ),
                                ),
                        ],
                      ),
                      Gap(Style.spacing.xs),
                      Row(
                        children: [
                          Text(
                            'Bearbeitende SuS:',
                            style: context.typography.body,
                          ),
                          Gap(Style.spacing.sm),
                          Text(
                            pupilWorkbooks.length.toString(),
                            overflow: TextOverflow.fade,
                            style: context.typography.subtitle.withColor(
                              style.colors.foreground,
                            ),
                          ),
                          const Spacer(),
                          ExpansionHeader(
                            includeSwitch: true,
                            switchColor: style.colors.accent,
                            expansionController: expansionTileController,
                          ),
                          Gap(Style.spacing.lg),
                        ],
                      ),
                      Gap(Style.spacing.sm),
                    ],
                  ),
                ),
              ),
            ],
          ),
          ExpansionBody(
            tileController: expansionTileController,
            widgetList: [
              for (final pupilWorkbook in pupilWorkbooks)
                Builder(
                  builder: (context) {
                    final pupil = di<PupilProxyManager>().getPupilByPupilId(
                      pupilWorkbook.pupilId,
                    );
                    if (pupil == null) {
                      return const SizedBox.shrink();
                    }
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Style.spacing.sm + 2,
                      ),
                      child: CardBox(
                        variant: CardBoxVariant.bordered,
                        padding: EdgeInsets.all(Style.spacing.sm),
                        child: Row(
                          children: [
                            AvatarWithBadges(pupil: pupil, size: 50),
                            Gap(Style.spacing.sm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${pupil.firstName} ${pupil.lastName}',
                                    style: context.typography.subtitle,
                                  ),
                                  const Gap(4),
                                  Text(
                                    '${pupilWorkbook.createdBy} - ${pupilWorkbook.createdAt.formatDateForUser()}',
                                    style: context.typography.bodySmall
                                        .muted(context),
                                  ),
                                  if (pupilWorkbook.comment != null &&
                                      pupilWorkbook
                                          .comment!.isNotEmpty)
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: Style.spacing.xs,
                                      ),
                                      child: Text(
                                        pupilWorkbook.comment!,
                                        style: context
                                            .typography.bodySmall
                                            .copyWith(
                                              fontStyle:
                                                  FontStyle.italic,
                                            ),
                                        maxLines: 2,
                                        overflow:
                                            TextOverflow.ellipsis,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }
}
