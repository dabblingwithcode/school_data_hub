import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/information_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/app_header.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/button.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/common/widgets/themed_filter_chip.dart';
import 'package:school_data_hub_flutter/features/learning/competence/domain/competence_manager.dart';

class PostOrPatchCompetenceScreen extends StatefulWidget {
  final int? parentCompetence;
  final Competence? competence;

  const PostOrPatchCompetenceScreen({
    super.key,
    this.competence,
    this.parentCompetence,
  });

  @override
  PostOrPatchCompetenceScreenState createState() =>
      PostOrPatchCompetenceScreenState();
}

class PostOrPatchCompetenceScreenState
    extends State<PostOrPatchCompetenceScreen> {
  late String competenceLevel;
  final TextEditingController nameFieldController = TextEditingController();

  final TextEditingController indicatorsFieldController =
      TextEditingController();

  CompetenceManager get _competenceManager => di<CompetenceManager>();

  void postNewCompetence() async {
    if (competenceLevel.isEmpty) {
      informationDialog(
        context,
        'Kompetenzstufe auswählen',
        'Bitte mindestens eine Kompetenzstufe auswählen!',
      );
      return;
    }
    Navigator.pop(context);

    await _competenceManager.postNewCompetence(
      parentCompetence: widget.parentCompetence,
      competenceLevel: [competenceLevel],
      competenceName: nameFieldController.text,
      indicators: [indicatorsFieldController.text],
    );
  }

  void patchCompetence() async {
    if (competenceLevel.isEmpty) {
      informationDialog(
        context,
        'Kompetenzstufe auswählen',
        'Bitte mindestens eine Kompetenzstufe auswählen!',
      );
      return;
    }
    String competenceName = nameFieldController.text;
    String newCompetenceLevel = competenceLevel;
    String text3 = indicatorsFieldController.text;
    await _competenceManager.updateCompetenceProperty(
      publicId: widget.competence!.publicId,
      competenceName: competenceName,
      competenceLevel: (value: [newCompetenceLevel]),
      indicators: (value: [text3]),
    );
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }

  Future<void> deleteCompetence() async {
    if (widget.competence == null) return;
    if (_competenceManager.isCompetenceWithChildren(widget.competence!)) {
      informationDialog(
        context,
        'Kompetenz kann nicht gelöscht werden',
        'Diese Kompetenz hat Unterkompetenzen. Bitte löschen Sie zuerst die Unterkompetenzen.',
      );
      return;
    }
    final confirm = await confirmationDialog(
      context: context,
      title: 'Kompetenz löschen',
      message: 'Sind Sie sicher?',
    );
    if (confirm != true) return;
    if (!mounted) return;
    Navigator.pop(context);
    await _competenceManager.deleteCompetence(widget.competence!.publicId);
  }

  bool competenceLevelContainsGrade(String grade) {
    return competenceLevel.contains(grade);
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      // TODO: implement lists for competence level and indicators
      competenceLevel = widget.competence != null
          ? widget.competence!.level!.join()
          : '';
      nameFieldController.text = widget.competence != null
          ? widget.competence!.name
          : '';
      indicatorsFieldController.text = widget.competence != null
          ? widget.competence!.indicators != null
                ? widget.competence!.indicators!.join()
                : ''
          : '';
    });
  }

  @override
  Widget build(BuildContext context) {
    bool gradeE1 = competenceLevelContainsGrade(SchoolGrade.E1.name);
    bool gradeE2 = competenceLevelContainsGrade(SchoolGrade.E2.name);
    bool gradeK3 = competenceLevelContainsGrade(SchoolGrade.K3.name);
    bool gradeK4 = competenceLevelContainsGrade(SchoolGrade.K4.name);

    return Scaffold(
      backgroundColor: Style.of(context).colors.canvas,
      appBar: AppHeader(
        iconData: Icons.edit_document,
        title: widget.competence != null
            ? 'Kompetenz überarbeiten'
            : 'Neue Kompetenz',
      ),
      body: Padding(
        padding: EdgeInsets.all(Style.spacing.lg),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                if (widget.parentCompetence != null)
                  Text(
                    'Übergeordnete Kompetenz: ${_competenceManager.findCompetenceById(widget.parentCompetence!).name}',
                    style: context.typography.title,
                  ),
                Text('Kompetenz', style: context.typography.title),
                Gap(Style.spacing.sm),
                TextField(
                  minLines: 1,
                  maxLines: 2,
                  controller: nameFieldController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(Style.spacing.sm),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Style.radii.small),
                    ),
                    labelText: 'Name der Kompetenz',
                  ),
                ),
                Gap(Style.spacing.sm),
                Text('Kompetenzstufe', style: context.typography.title),
                Gap(Style.spacing.sm),
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
                            competenceLevel = competenceLevel.replaceAll(
                              'E1',
                              '',
                            );
                            gradeE1 = false;
                          });
                        }
                      },
                    ),
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
                            competenceLevel = competenceLevel.replaceAll(
                              'E2',
                              '',
                            );
                            gradeE2 = false;
                          });
                        }
                      },
                    ),
                    ThemedFilterChip(
                      label: 'K3',
                      selected: gradeK3,
                      onSelected: (value) {
                        if (value) {
                          setState(() {
                            competenceLevel = '${competenceLevel}K3';
                            gradeK3 = true;
                          });
                        } else {
                          setState(() {
                            competenceLevel = competenceLevel.replaceAll(
                              'K3',
                              '',
                            );
                            gradeK3 = false;
                          });
                        }
                      },
                    ),
                    ThemedFilterChip(
                      label: 'K4',
                      selected: gradeK4,
                      onSelected: (value) {
                        if (value) {
                          setState(() {
                            competenceLevel = '${competenceLevel}K4';
                            gradeK4 = true;
                          });
                        } else {
                          setState(() {
                            competenceLevel = competenceLevel.replaceAll(
                              'K4',
                              '',
                            );
                            gradeK4 = false;
                          });
                        }
                      },
                    ),
                  ],
                ),
                Gap(Style.spacing.xl),
                TextField(
                  minLines: 2,
                  maxLines: 3,
                  controller: indicatorsFieldController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(Style.spacing.sm),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Style.radii.small),
                    ),
                    labelText: 'Indikatoren',
                  ),
                ),
                const Spacer(),
                Button(
                  label: 'SENDEN',
                  onPressed: () {
                    widget.competence == null
                        ? postNewCompetence()
                        : patchCompetence();
                  },
                ),
                Gap(Style.spacing.lg),
                Button(
                  label: 'ABBRECHEN',
                  variant: ButtonVariant.secondary,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                if (widget.competence != null) ...[
                  Gap(Style.spacing.lg),
                  Button(
                    label: 'KOMPETENZ LÖSCHEN',
                    variant: ButtonVariant.destructive,
                    onPressed: deleteCompetence,
                  ),
                ],
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
