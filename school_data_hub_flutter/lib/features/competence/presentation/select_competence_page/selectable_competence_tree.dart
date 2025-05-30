import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/grades_widget.dart';
import 'package:school_data_hub_flutter/features/competence/domain/competence_helper.dart';
import 'package:school_data_hub_flutter/features/competence/presentation/select_competence_page/select_competence_view_model.dart';

List<Widget> selectableCompetenceTree({
  //required BuildContext context,
  int? parentCompetenceId,
  required double indentation,
  Color? backGroundColor,
  required SelectCompetenceViewModel viewModel,
  //required String elementType,
}) {
  List<Widget> competenceWidgets = [];

  List<Competence> competences = viewModel.competences;
  Color competenceBackgroundColor;

  for (Competence competence in competences) {
    if (backGroundColor == null) {
      competenceBackgroundColor =
          CompetenceHelper.getCompetenceColor(competence.publicId);
    } else {
      competenceBackgroundColor = backGroundColor;
    }

    if (competence.parentCompetence == parentCompetenceId) {
      final children = selectableCompetenceTree(
        //  context: context,
        parentCompetenceId: competence.publicId,
        indentation: indentation + 15,
        backGroundColor: competenceBackgroundColor,
        viewModel: viewModel,
        //elementType: elementType
      );

      competenceWidgets.add(
        Padding(
          padding: EdgeInsets.only(top: 10, left: indentation),
          child: children.isNotEmpty
              ? Wrap(
                  children: [
                    Card(
                      color: competenceBackgroundColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      clipBehavior: Clip.hardEdge,
                      margin: EdgeInsets.zero,
                      child: ExpansionTile(
                        iconColor: Colors.white,
                        collapsedTextColor: Colors.white,
                        collapsedIconColor: Colors.white,
                        textColor: Colors.white,
                        maintainState: false,
                        backgroundColor: competenceBackgroundColor,
                        title: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Radio(
                                      value: competence.publicId,
                                      groupValue:
                                          viewModel.selectedCompetenceId,
                                      onChanged: (value) {
                                        viewModel.selectCompetence(value!);
                                      },
                                    ),
                                    // : const Row(children: [
                                    //     Gap(7),
                                    //     Icon(
                                    //       Icons.support,
                                    //       color: Colors.white,
                                    //     )
                                    //   ]),
                                  ),
                                  const Gap(5),
                                  Flexible(
                                    child: InkWell(
                                      onTap: () => viewModel.selectCompetence(
                                          competence.publicId),
                                      child: Text(
                                        competence.name,
                                        maxLines: 4,
                                        textAlign: TextAlign.start,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              // competence.competenceLevel != null
                              //     ? Padding(
                              //         padding:
                              //             const EdgeInsets.only(left: 45.0),
                              //         child: Row(
                              //           mainAxisAlignment:
                              //               MainAxisAlignment.spaceBetween,
                              //           children: [
                              //             Flexible(
                              //                 child: CompetenceGradesWidget(
                              //                     competence: competence)),
                              //             const Gap(10),
                              //           ],
                              //         ),
                              //       )
                              //     : const SizedBox.shrink(),
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
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child:
                                // getCategoryStatus(
                                //             pupil, goalCategory.categoryId) ==
                                //         null
                                //     ?
                                Radio(
                              value: competence.publicId,
                              groupValue: viewModel.selectedCompetenceId,
                              onChanged: (value) {
                                viewModel.selectCompetence(value!);
                              },
                            ),
                            // : const Row(children: [
                            //     Gap(7),
                            //     Icon(
                            //       Icons.support,
                            //       color: Colors.white,
                            //     )
                            //   ]),
                          ),
                          const Gap(5),
                          Flexible(
                            child: InkWell(
                              onTap: () => viewModel
                                  .selectCompetence(competence.publicId),
                              child: Text(
                                competence.name,
                                maxLines: 4,
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
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
                                          stringWithGrades:
                                              competence.level!.toString())),
                                  const Gap(10),
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
