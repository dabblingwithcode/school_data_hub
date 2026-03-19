import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/button.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/card_box.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_proxy_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/pupil_profile_page/pupil_profile_page.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/select_pupils_list_page/select_pupils_list_page.dart';
import 'package:school_data_hub_flutter/common/widgets/avatar/avatar.dart';
import 'package:school_data_hub_flutter/features/_school_lists/domain/school_list_manager.dart';

class NewSchoolListScreen extends WatchingWidget {
  final SchoolList? initialSchoolList;
  const NewSchoolListScreen({this.initialSchoolList, super.key});
  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final schoolListManager = di<SchoolListManager>();
    final pupilManager = di<PupilProxyManager>();
    final hubSessionManager = di<HubSessionManager>();
    // Create text editing controllers using createOnce
    final schoolListNameController = createOnce<TextEditingController>(
      () => TextEditingController(),
    );
    final schoolListDescriptionController = createOnce<TextEditingController>(
      () => TextEditingController(),
    );

    // Create ValueListenable for state management
    final isOn = createOnce<ValueNotifier<bool>>(
      () => ValueNotifier<bool>(false),
    );
    final pupilIds = createOnce<ValueNotifier<Set<int>>>(() {
      final initialPupilIds = <int>{};
      if (initialSchoolList != null) {
        initialPupilIds.addAll(
          di<SchoolListManager>()
              .getPupilsinSchoolList(initialSchoolList!.id!)
              .map((e) => e.pupilId)
              .toSet(),
        );
      }
      return ValueNotifier<Set<int>>(initialPupilIds);
    });

    // Watch the state values
    final isOnValue = watch(isOn).value;
    final pupilIdsValue = watch(pupilIds).value;

    void postNewSchoolList() async {
      await schoolListManager.postSchoolListWithGroup(
        name: schoolListNameController.text,
        description: schoolListDescriptionController.text,
        pupilIds: pupilIdsValue.toList(),
        public: isOnValue,
      );
    }

    List<PupilProxy> pupilsFromIds = pupilManager.getPupilsFromPupilIds(
      pupilIdsValue.toList(),
    );
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: style.colors.accent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.rule_rounded, size: 25, color: style.colors.background),
            const Gap(10),
            Text(
              'Neue Liste',
              style: context.typography.heading.withColor(
                style.colors.background,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(Style.spacing.lg),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextField(
                  minLines: 1,
                  maxLines: 3,
                  controller: schoolListNameController,
                  decoration: AppStyles.textFieldDecoration(
                    labelText: 'Name der Liste',
                  ),
                ),
                const Gap(20),
                TextField(
                  minLines: 1,
                  maxLines: 3,
                  controller: schoolListDescriptionController,
                  decoration: AppStyles.textFieldDecoration(
                    labelText: 'Kurze Beschreibung der Liste',
                  ),
                ),
                const Gap(10),
                hubSessionManager.isAdmin == true
                    ? Row(
                        children: [
                          Text(
                            'Öffentliche Liste:',
                            style: context.typography.subtitle,
                          ),
                          const Gap(10),
                          Switch(
                            value: isOnValue,
                            onChanged: (newValue) {
                              isOn.value = newValue;
                            },
                            activeThumbColor: style.colors.accent,
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
                Row(
                  children: [
                    Text(
                      'Ausgewählte Kinder:',
                      style: context.typography.subtitle,
                    ),
                    const Gap(10),
                    Text(
                      pupilsFromIds.length.toString(),
                      style: context.typography.title.withColor(
                        style.colors.foreground,
                      ),
                    ),
                  ],
                ),
                if (pupilIdsValue.isEmpty) const Gap(30),
                pupilIdsValue.isNotEmpty
                    ? Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: ListView.builder(
                              padding: const EdgeInsets.only(
                                top: 5,
                                bottom: 15,
                              ),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: pupilsFromIds.length,
                              itemBuilder: (context, int index) {
                                PupilProxy listedPupil = pupilsFromIds[index];
                                return Column(
                                  children: [
                                    InkWell(
                                      onLongPress: () {
                                        final currentPupilIds = Set<int>.from(
                                          pupilIdsValue,
                                        );
                                        currentPupilIds.remove(
                                          listedPupil.internalId,
                                        );
                                        pupilIds.value = currentPupilIds;
                                      },
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute<void>(
                                            builder: (ctx) => PupilProfilePage(
                                              pupil: listedPupil,
                                            ),
                                          ),
                                        );
                                      },
                                      child: CardBox(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            AvatarWithBadges(
                                              pupil: listedPupil,
                                              size: 50,
                                            ),
                                            const Gap(10),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  listedPupil.firstName,
                                                  style: context
                                                      .typography.title
                                                      .withColor(
                                                        style
                                                            .colors.foreground,
                                                      ),
                                                ),
                                                Text(
                                                  listedPupil.lastName,
                                                  style:
                                                      context.typography.body,
                                                ),
                                              ],
                                            ),
                                            const Spacer(),
                                            Column(
                                              children: [
                                                Text(
                                                  listedPupil.group,
                                                  style: context
                                                      .typography.title
                                                      .withColor(
                                                        style
                                                            .colors.groupColor,
                                                      ),
                                                ),
                                                Text(
                                                  listedPupil
                                                      .schoolGrade
                                                      .name,
                                                  style: context
                                                      .typography.title
                                                      .withColor(
                                                        style.colors
                                                            .schoolGradeColor,
                                                      ),
                                                ),
                                              ],
                                            ),
                                            const Gap(15),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Keine Kinder ausgewählt!',
                            style: context.typography.title.withColor(
                              style.colors.mutedForeground,
                            ),
                          ),
                        ],
                      ),
                if (pupilIds.value.isEmpty) const Spacer(),
                Button(
                  variant: ButtonVariant.secondary,
                  onPressed: () async {
                    final List<int> selectedPupilIds =
                        await Navigator.of(context).push(
                          MaterialPageRoute<List<int>>(
                            builder: (ctx) => SelectPupilsListScreen(
                              selectablePupils: pupilManager.getPupilsNotListed(
                                pupilIdsValue.toList(),
                              ),
                            ),
                          ),
                        ) ??
                        [];
                    if (selectedPupilIds.isNotEmpty) {
                      final currentPupilIds = Set<int>.from(pupilIdsValue);
                      currentPupilIds.addAll(selectedPupilIds.toSet());
                      pupilIds.value = currentPupilIds;
                    }
                  },
                  label: 'KINDER AUSWÄHLEN',
                ),
                const Gap(15),
                Button(
                  onPressed: () {
                    postNewSchoolList();
                    Navigator.pop(context);
                  },
                  label: 'SENDEN',
                ),
                const Gap(15),
                Button(
                  variant: ButtonVariant.destructive,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  label: 'ABBRECHEN',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
