import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/pupil_profile_page.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/select_pupils_list_page/select_pupils_list_page.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/widgets/avatar.dart';
import 'package:school_data_hub_flutter/features/school_lists/domain/school_list_manager.dart';
import 'package:watch_it/watch_it.dart';

final _schoolListManager = di<SchoolListManager>();
final _pupilManager = di<PupilManager>();
final _hubSessionManager = di<HubSessionManager>();

class NewSchoolListPage extends StatefulWidget {
  const NewSchoolListPage({super.key});

  @override
  NewSchoolListPageState createState() => NewSchoolListPageState();
}

class NewSchoolListPageState extends State<NewSchoolListPage> {
  final TextEditingController schoolListNameController =
      TextEditingController();
  final TextEditingController schoolListDescriptionController =
      TextEditingController();
  bool _isOn = false;
  Set<int> pupilIds = {};
  void postNewSchoolList() async {
    await _schoolListManager.postSchoolListWithGroup(
        name: schoolListNameController.text,
        description: schoolListDescriptionController.text,
        pupilIds: pupilIds.toList(),
        public: _isOn);
  }

  @override
  Widget build(BuildContext context) {
    List<PupilProxy> pupilsFromIds =
        _pupilManager.getPupilsFromPupilIds(pupilIds.toList());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.backgroundColor,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.rule_rounded, size: 25, color: Colors.white),
            Gap(10),
            Text(
              'Neue Liste',
              style: AppStyles.appBarTextStyle,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
                      labelText: 'Name der Liste'),
                ),
                const Gap(20),
                TextField(
                  minLines: 1,
                  maxLines: 3,
                  controller: schoolListDescriptionController,
                  decoration: AppStyles.textFieldDecoration(
                      labelText: 'Kurze Beschreibung der Liste'),
                ),
                const Gap(10),
                _hubSessionManager.isAdmin == true
                    ? Row(
                        children: [
                          const Text(
                            'Öffentliche Liste:',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const Gap(10),
                          Switch(
                            value:
                                _isOn, // Boolean value representing the switch state
                            onChanged: (newValue) {
                              setState(() {
                                _isOn = newValue;
                              });
                            },
                            activeColor: Colors.blue, // Change color if desired
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
                Row(
                  children: [
                    const Text(
                      'Ausgewählte Kinder:',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const Gap(10),
                    Text(
                      pupilsFromIds.length.toString(),
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {},
                      child: const Text('aus Liste',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.interactiveColor)),
                    ),
                  ],
                ),
                if (pupilIds.isEmpty) const Gap(30),
                pupilIds.isNotEmpty
                    ? Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: ListView.builder(
                                padding:
                                    const EdgeInsets.only(top: 5, bottom: 15),
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: pupilsFromIds.length,
                                itemBuilder: (context, int index) {
                                  PupilProxy listedPupil = pupilsFromIds[index];
                                  return Column(
                                    children: [
                                      // const Gap(5),
                                      InkWell(
                                        onLongPress: () {
                                          setState(() {
                                            pupilIds
                                                .remove(listedPupil.internalId);
                                          });
                                        },
                                        onTap: () {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (ctx) => PupilProfilePage(
                                              pupil: listedPupil,
                                            ),
                                          ));
                                        },
                                        child: Card(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                AvatarWithBadges(
                                                    pupil: listedPupil,
                                                    size: 50),
                                                const Gap(10),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      listedPupil.firstName,
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18),
                                                    ),
                                                    //const Gap(10),
                                                    Text(
                                                      listedPupil.lastName,
                                                      style: const TextStyle(),
                                                    ),
                                                  ],
                                                ),
                                                const Spacer(),
                                                Column(
                                                  children: [
                                                    Text(
                                                      listedPupil.group,
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: AppColors
                                                              .groupColor,
                                                          fontSize: 18),
                                                    ),
                                                    Text(
                                                      listedPupil
                                                          .schoolGrade.name,
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: AppColors
                                                              .schoolyearColor,
                                                          fontSize: 18),
                                                    ),
                                                  ],
                                                ),
                                                const Gap(15),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                          ),
                        ),
                      )
                    : const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Keine Kinder ausgewählt!',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 91, 91, 91),
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                if (pupilIds.isEmpty) const Spacer(),
                ElevatedButton(
                  style: AppStyles.actionButtonStyle,
                  onPressed: () async {
                    final List<int> selectedPupilIds =
                        await Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => SelectPupilsListPage(
                                  selectablePupils: _pupilManager
                                      .getPupilsNotListed(pupilIds.toList())),
                            )) ??
                            [];
                    if (selectedPupilIds.isNotEmpty) {
                      setState(() {
                        pupilIds.addAll(selectedPupilIds.toSet());
                      });
                    }
                  },
                  child: const Text(
                    'KINDER AUSWÄHLEN',
                    style: AppStyles.buttonTextStyle,
                  ),
                ),
                const Gap(15),
                ElevatedButton(
                  style: AppStyles.successButtonStyle,
                  onPressed: () {
                    postNewSchoolList();
                    Navigator.pop(context);
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
    schoolListNameController.dispose();
    schoolListDescriptionController.dispose();
    super.dispose();
  }
}
