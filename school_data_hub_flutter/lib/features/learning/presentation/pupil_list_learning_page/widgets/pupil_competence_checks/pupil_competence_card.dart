import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/custom_expansion_tile/custom_expansion_tile.dart';
import 'package:school_data_hub_flutter/common/widgets/custom_expansion_tile/custom_expansion_tile_content.dart';
import 'package:school_data_hub_flutter/common/widgets/custom_expansion_tile/custom_expansion_tile_switch.dart';
import 'package:school_data_hub_flutter/features/learning/domain/competence_helper.dart';
import 'package:school_data_hub_flutter/features/learning/domain/competence_manager.dart';
import 'package:school_data_hub_flutter/features/learning/presentation/widgets/competence_check_symbols.dart';
import 'package:school_data_hub_flutter/features/learning/presentation/widgets/dialogues/new_competence_check_dialog.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:watch_it/watch_it.dart';

class PupilCompetenceCard extends WatchingWidget {
  final Color backgroundColor;
  final bool isReport;
  final Competence competence;
  final PupilProxy pupil;

  final List<Widget> children;
  final List<Widget> competenceChecks;
  final double? checksAverageValue;

  const PupilCompetenceCard({
    super.key,
    required this.backgroundColor,
    required this.isReport,
    required this.competence,
    required this.pupil,
    required this.children,
    required this.competenceChecks,
    required this.checksAverageValue,
  });

  void disposeControllerValueNotifier(ValueNotifier<bool> notifier) {
    notifier.dispose();
  }

  void disposeControllerValueListener(ValueListenable<bool> notifier) {
    notifier.removeListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    final _competenceManager = di<CompetenceManager>();
    watch(pupil);
    final isExpandedValue = createOnce<ValueNotifier<bool>>(
      () => ValueNotifier(false),
      dispose: disposeControllerValueNotifier,
    );
    final isExpanded = createOnce<ValueListenable<bool>>(
      () => ValueNotifier(isExpandedValue.value),
      dispose: disposeControllerValueListener,
    );

    final competenceAreaController = createOnce<CustomExpansionTileController>(
      () => CustomExpansionTileController(),
    );
    final checksController = createOnce<CustomExpansionTileController>(
      () => CustomExpansionTileController(),
    );
    if (isExpanded.value) {
      checksController.expand();
    }
    final competenceColor = CompetenceHelper.getCompetenceColor(
      competence.publicId,
    );
    return Padding(
      padding:
          isReport
              ? const EdgeInsets.symmetric(vertical: 4, horizontal: 4)
              : EdgeInsets.symmetric(
                vertical: competence.parentCompetence == null ? 3 : 0,
              ),
      child: Card(
        color: isReport ? Colors.white : competenceColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side:
              isReport
                  ? const BorderSide(color: Colors.white, width: 2)
                  : BorderSide.none,
        ),
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.zero,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Gap(10),
                  Expanded(
                    child:
                        isReport
                            ? Text(
                              competence.name,
                              maxLines: 4,
                              softWrap: true,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: isReport ? Colors.black : Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            )
                            : Text(
                              competence.name,
                              maxLines: 3,
                              softWrap: true,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize:
                                    competence.parentCompetence == null
                                        ? 20
                                        : 16,
                                fontWeight: FontWeight.bold,
                                color:
                                    AppColors.bestContrastCompetenceFontColor(
                                      competenceColor,
                                    ),
                              ),
                            ),
                  ),
                  Row(
                    children: [
                      const Gap(20),
                      if (competenceChecks.isNotEmpty) ...[
                        CustomExpansionTileSwitch(
                          customExpansionTileController: checksController,
                          expansionSwitchWidget: Icon(
                            Icons.remove_red_eye,
                            color:
                                isReport
                                    ? AppColors.backgroundColor
                                    : AppColors.bestContrastCompetenceFontColor(
                                      competenceColor,
                                    ),
                          ),
                        ),
                        const Gap(10),
                      ],
                      if (competenceChecks.isEmpty && !isReport) const Gap(35),
                      if (di<CompetenceManager>().isCompetenceWithChildren(
                        competence,
                      ))
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: CustomExpansionTileSwitch(
                            customExpansionTileController:
                                competenceAreaController,
                          ),
                        ),
                      const Gap(10),
                      InkWell(
                        onTap: () async {
                          // TODO: Uncomment and implement the competence check posting
                          await _competenceManager.postCompetenceCheck(
                            pupilId: pupil.pupilId,
                            competenceId: competence.publicId,
                            score: 0,
                            competenceComment: null,
                            groupId: null,
                          );
                          isExpandedValue.value = true;
                          // if (!checksController.isExpanded) {
                          //   checksController.expand();
                          // }
                        },
                        child: Icon(
                          Icons.edit_note_rounded,
                          color:
                              isReport
                                  ? AppColors.backgroundColor
                                  : Colors.white,
                        ),
                      ),
                      const Gap(5),
                    ],
                  ),
                ],
              ),
            ),
            if (competenceChecks.isNotEmpty || isReport)
              Padding(
                padding: const EdgeInsets.only(left: 15.0, bottom: 5.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 23.0,
                      height: 23.0,
                      decoration: BoxDecoration(
                        color: isReport ? competenceColor : Colors.white,
                        shape: BoxShape.circle,
                        // border: Border.all(
                        //   color: Colors.white,
                        //   width: 2.0,
                        // ),
                      ),
                      child: Center(
                        child: Text(
                          competenceChecks.length.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isReport ? Colors.white : competenceColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const Gap(20),
                    Text(
                      'Ø',
                      style: TextStyle(
                        color: isReport ? Colors.black : Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    const Gap(5),
                    if (checksAverageValue != null)
                      Text(
                        checksAverageValue!.toStringAsFixed(1),
                        style: TextStyle(
                          color: isReport ? Colors.black : Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    if (isReport) ...<Widget>[
                      const Spacer(),
                      GestureDetector(
                        onLongPress: () {
                          newCompetenceCheckDialog(
                            pupil: pupil,
                            competenceId: competence.publicId,
                            isReport: true,
                            parentContext: context,
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: InkWell(
                            child: getCompetenceReportCheckSymbol(
                              pupil,
                              competence.publicId,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            CustomExpansionTileContent(
              tileController: checksController,
              widgetList: competenceChecks,
            ),
            CustomExpansionTileContent(
              tileController: competenceAreaController,
              widgetList: children,
            ),
          ],
        ),
      ),
    );
  }
}
