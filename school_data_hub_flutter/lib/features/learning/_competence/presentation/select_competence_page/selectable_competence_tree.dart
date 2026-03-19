import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/learning/_competence/domain/competence_helper.dart';
import 'package:school_data_hub_flutter/features/learning/_competence/presentation/select_competence_page/select_competence_view_model.dart';
import 'package:school_data_hub_flutter/features/learning/_competence/presentation/widgets/competence_grades_widget.dart';

List<Widget> selectableCompetenceTree({
  required BuildContext context,
  int? parentCompetenceId,
  required double indentation,
  Color? backGroundColor,
  required SelectCompetenceViewModel viewModel,
}) {
  List<Widget> competenceWidgets = [];
  final style = Style.of(context);

  List<Competence> competences = viewModel.competences;
  Color competenceBackgroundColor;

  for (Competence competence in competences) {
    if (backGroundColor == null) {
      competenceBackgroundColor = CompetenceHelper.getCompetenceColor(
        competence.publicId,
      );
    } else {
      competenceBackgroundColor = backGroundColor;
    }

    if (competence.parentCompetence == parentCompetenceId) {
      final children = selectableCompetenceTree(
        context: context,
        parentCompetenceId: competence.publicId,
        indentation: indentation + 15,
        backGroundColor: competenceBackgroundColor,
        viewModel: viewModel,
      );

      competenceWidgets.add(
        Padding(
          padding: EdgeInsets.only(top: Style.spacing.sm, left: indentation),
          child: children.isNotEmpty
              ? Wrap(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: competenceBackgroundColor,
                        borderRadius: BorderRadius.circular(Style.radii.medium),
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: ExpansionTile(
                        iconColor: style.colors.background,
                        collapsedTextColor: style.colors.background,
                        collapsedIconColor: style.colors.background,
                        textColor: style.colors.background,
                        maintainState: false,
                        backgroundColor: competenceBackgroundColor,
                        title: Padding(
                          padding: EdgeInsets.all(Style.spacing.sm),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(Style.spacing.xs),
                                    child: Radio<int>(
                                      value: competence.publicId,
                                    ),
                                  ),
                                  Gap(Style.spacing.xs),
                                  Flexible(
                                    child: GestureDetector(
                                      onTap: () => viewModel.selectCompetence(
                                        competence.publicId,
                                      ),
                                      child: Text(
                                        competence.name,
                                        maxLines: 4,
                                        textAlign: TextAlign.start,
                                        style: context.typography.subtitle.bold.withColor(
                                          style.colors.background,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        collapsedBackgroundColor: competenceBackgroundColor,
                        children: children,
                      ),
                    ),
                  ],
                )
              : Padding(
                  padding: EdgeInsets.all(Style.spacing.sm),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(Style.spacing.xs),
                            child: Radio<int>(value: competence.publicId),
                          ),
                          Gap(Style.spacing.xs),
                          Flexible(
                            child: GestureDetector(
                              onTap: () => viewModel.selectCompetence(
                                competence.publicId,
                              ),
                              child: Text(
                                competence.name,
                                maxLines: 4,
                                textAlign: TextAlign.start,
                                style: context.typography.subtitle.bold.withColor(
                                  style.colors.background,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      competence.level != null
                          ? Padding(
                              padding: const EdgeInsets.only(left: 45.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: GradesWidget(
                                      stringWithGrades: competence.level!
                                          .toString(),
                                    ),
                                  ),
                                  Gap(Style.spacing.sm),
                                ],
                              ),
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),
        ),
      );
    }
  }

  return competenceWidgets;
}
