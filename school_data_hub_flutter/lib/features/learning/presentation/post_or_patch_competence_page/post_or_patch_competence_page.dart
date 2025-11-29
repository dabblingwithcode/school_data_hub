import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/information_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/themed_filter_chip.dart';
import 'package:school_data_hub_flutter/features/learning/domain/competence_manager.dart';
import 'package:watch_it/watch_it.dart';

class PostOrPatchCompetencePage extends StatefulWidget {
  final int? parentCompetence;
  final Competence? competence;

  const PostOrPatchCompetencePage(
      {super.key, this.competence, this.parentCompetence});

  @override
  PostOrPatchCompetencePageState createState() =>
      PostOrPatchCompetencePageState();
}

class PostOrPatchCompetencePageState extends State<PostOrPatchCompetencePage> {
  late String competenceLevel;
  final TextEditingController nameFieldController = TextEditingController();

  final TextEditingController indicatorsFieldController =
      TextEditingController();

  CompetenceManager get _competenceManager => di<CompetenceManager>();

  void postNewCompetence() async {
    if (competenceLevel.isEmpty) {
      informationDialog(context, 'Kompetenzstufe auswählen',
          'Bitte mindestens eine Kompetenzstufe auswählen!');
      return;
    }
    Navigator.pop(context);

    await _competenceManager.postNewCompetence(
        parentCompetence: widget.parentCompetence,
        competenceLevel: [competenceLevel],
        competenceName: nameFieldController.text,
        indicators: [indicatorsFieldController.text]);
  }

  void patchCompetence() async {
    if (competenceLevel.isEmpty) {
      informationDialog(context, 'Kompetenzstufe auswählen',
          'Bitte mindestens eine Kompetenzstufe auswählen!');
      return;
    }
    String competenceName = nameFieldController.text;
    String newCompetenceLevel = competenceLevel;
    String text3 = indicatorsFieldController.text;
    await _competenceManager.updateCompetenceProperty(
        publicId: widget.competence!.publicId,
        competenceName: competenceName,
        competenceLevel: (value: [newCompetenceLevel]),
        indicators: (value: [text3]));
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }

  bool competenceLevelContainsGrade(String grade) {
    return competenceLevel.contains(grade);
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      // TODO: implement lists for competence level and indicators
      competenceLevel =
          widget.competence != null ? widget.competence!.level!.join() : '';
      nameFieldController.text =
          widget.competence != null ? widget.competence!.name : '';
      indicatorsFieldController.text = widget.competence != null
          ? widget.competence!.indicators != null
              ? widget.competence!.indicators!.join()
              : ''
          : '';
    });
  }

  @override
  Widget build(BuildContext context) {
    bool gradeE1 = competenceLevelContainsGrade('E1');
    bool gradeE2 = competenceLevelContainsGrade('E2');
    bool gradeS3 = competenceLevelContainsGrade('K3');
    bool gradeS4 = competenceLevelContainsGrade('K4');

    return Scaffold(
      appBar: GenericAppBar(
          iconData: Icons.edit_document,
          title: widget.competence != null
              ? 'Kompetenz überarbeiten'
              : 'Neue Kompetenz'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                if (widget.parentCompetence != null)
                  Text(
                    'Übergeordnete Kompetenz: ${_competenceManager.findCompetenceById(widget.parentCompetence!).name}',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                const Text(
                  'Kompetenz',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Gap(10),
                TextField(
                  minLines: 1,
                  maxLines: 2,
                  controller: nameFieldController,
                  decoration: AppStyles.textFieldDecoration(
                      labelText: 'Name der Kompetenz'),
                ),
                const Gap(10),
                const Text(
                  'Kompetenzstufe',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Gap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ThemedFilterChip(
                        label: 'E1',
                        selected: gradeE1,
                        onSelected: (value) {
                          if (value) {
                            setState(() {
                              competenceLevel = '${competenceLevel}E1';
                              gradeE1 = true;
                            });
                          } else {
                            setState(() {
                              competenceLevel =
                                  competenceLevel.replaceAll('E1', '');
                              gradeE1 = false;
                            });
                          }
                        }),
                    ThemedFilterChip(
                        label: 'E2',
                        selected: gradeE2,
                        onSelected: (value) {
                          if (value) {
                            setState(() {
                              competenceLevel = '${competenceLevel}E2';
                              gradeE2 = true;
                            });
                          } else {
                            setState(() {
                              competenceLevel =
                                  competenceLevel.replaceAll('E2', '');
                              gradeE2 = false;
                            });
                          }
                        }),
                    ThemedFilterChip(
                        label: 'K3',
                        selected: gradeS3,
                        onSelected: (value) {
                          if (value) {
                            setState(() {
                              competenceLevel = '${competenceLevel}03';
                              gradeS3 = true;
                            });
                          } else {
                            setState(() {
                              competenceLevel =
                                  competenceLevel.replaceAll('K3', '');
                              gradeS3 = false;
                            });
                          }
                        }),
                    ThemedFilterChip(
                        label: 'K4',
                        selected: gradeS4,
                        onSelected: (value) {
                          if (value) {
                            setState(() {
                              competenceLevel = '${competenceLevel}04';
                              gradeS4 = true;
                            });
                          } else {
                            setState(() {
                              competenceLevel =
                                  competenceLevel.replaceAll('K4', '');
                              gradeS4 = false;
                            });
                          }
                        }),
                  ],
                ),
                const Gap(20),
                TextField(
                  minLines: 2,
                  maxLines: 3,
                  controller: indicatorsFieldController,
                  decoration: AppStyles.textFieldDecoration(
                    labelText: 'Indikatoren',
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  style: AppStyles.actionButtonStyle,
                  onPressed: () {
                    widget.competence == null
                        ? postNewCompetence()
                        : patchCompetence();
                  },
                  child: const Text(
                    'SENDEN',
                    style: AppStyles.buttonTextStyle,
                  ),
                ),
                const Gap(15),
                ElevatedButton(
                  style: AppStyles.cancelButtonStyle,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'ABBRECHEN',
                    style: AppStyles.buttonTextStyle,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the tree
    nameFieldController.dispose();

    super.dispose();
  }
}
