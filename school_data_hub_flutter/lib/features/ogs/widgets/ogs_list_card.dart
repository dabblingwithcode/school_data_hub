import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/long_textfield_dialog.dart';
import 'package:school_data_hub_flutter/features/ogs/widgets/dialogs/ogs_pickup_time_dialog.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_mutator.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/pupil_profile_page.dart';
import 'package:watch_it/watch_it.dart';

class OgsCard extends WatchingWidget {
  final PupilProxy pupil;
  const OgsCard(this.pupil, {super.key});
  @override
  Widget build(BuildContext context) {
    final pupil = watch<PupilProxy>(this.pupil);
    return Card(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 1.0,
      margin: const EdgeInsets.only(
        left: 4.0,
        right: 4.0,
        top: 4.0,
        bottom: 4.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // TODO: Fix avatar component - AvatarWithBadges not available
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(40),
            ),
            child: const Icon(Icons.person, size: 40),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(15),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: InkWell(
                                    onTap: () {
                                      // TODO: Fix navigation - MainMenuBottomNavManager not available
                                      // di<MainMenuBottomNavManager>()
                                      //     .setPupilProfileNavPage(
                                      //       ProfileNavigation.ogs.value,
                                      //     );
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder:
                                              (ctx) => PupilProfilePage(
                                                pupil: pupil,
                                              ),
                                        ),
                                      );
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          pupil.firstName,
                                          overflow: TextOverflow.fade,
                                          softWrap: false,
                                          textAlign: TextAlign.left,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        const Gap(5),
                                        Text(
                                          pupil.lastName,
                                          overflow: TextOverflow.fade,
                                          softWrap: false,
                                          textAlign: TextAlign.left,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 18,
                                          ),
                                        ),
                                        const Gap(5),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Gap(25),
                          const Row(children: [Text('Ogs Infos:'), Gap(5)]),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //const Gap(20),
                          const Text('Abholzeit:'),
                          Center(
                            child: InkWell(
                              onTap:
                                  () => pickUpTimeDialog(
                                    context,
                                    pupil,
                                    pupil.pickUpTime,
                                  ),
                              child: Text(
                                pupil.pickUpTime ?? 'keine',
                                style: const TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.backgroundColor,
                                ),
                              ),
                            ),
                          ),
                          const Text('Uhr'),
                        ],
                      ),
                    ),
                  ],
                ),
                const Gap(5),
                Row(
                  children: [
                    Flexible(
                      child: InkWell(
                        onTap: () async {
                          final String? ogsInfo = await longTextFieldDialog(
                            title: 'OGS Informationen',
                            labelText: 'OGS Informationen',
                            initialValue: pupil.ogsInfo ?? '',
                            parentContext: context,
                          );
                          if (ogsInfo == null) return;
                          await PupilMutator().updateStringProperty(
                            pupilId: pupil.internalId,
                            property: 'afterSchoolCareInfo',
                            value: ogsInfo,
                          );
                        },
                        onLongPress: () async {
                          if (pupil.ogsInfo == null) return;
                          final bool? confirm = await confirmationDialog(
                            context: context,
                            title: 'OGS Infos löschen',
                            message:
                                'OGS Informationen für dieses Kind löschen?',
                          );
                          if (confirm == false || confirm == null) return;
                          await PupilMutator().updateStringProperty(
                            pupilId: pupil.internalId,
                            property: 'afterSchoolCareInfo',
                            value: null,
                          );
                        },
                        child: Text(
                          pupil.ogsInfo == null || pupil.ogsInfo!.isEmpty
                              ? 'keine Infos'
                              : pupil.ogsInfo!,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          maxLines: 3,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: AppColors.backgroundColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(15),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
