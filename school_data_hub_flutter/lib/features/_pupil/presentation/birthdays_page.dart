import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar/generic_bottom_nav_bar.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_proxy_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/pupil_profile_page/pupil_profile_page.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/widgets/avatar.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/domain/main_menu_bottom_nav_manager.dart';

class BirthdaysView extends StatelessWidget {
  final DateTime selectedDate;
  final DateTime? endDate;
  final bool futureBirthdays;
  const BirthdaysView({
    required this.selectedDate,
    this.endDate,
    this.futureBirthdays = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Set<DateTime> seenBirthdays = {};
    final pupilManager = di<PupilProxyManager>();
    final List<PupilProxy> pupils = pupilManager.getPupilsWithBirthdaySinceDate(
      selectedDate,
      untilDate: endDate,
    );

    return Scaffold(
      backgroundColor: AppColors.canvasColor,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.backgroundColor,
        title: const Text('Geburtstage', style: AppStyles.appBarTextStyle),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            endDate != null
                                ? 'Geburtstage vom ${selectedDate.formatDateForUser()} bis ${endDate!.formatDateForUser()}'
                                : 'Geburtstage seit dem ${selectedDate.formatDateForUser()}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          if (pupils.isEmpty)
                            const Padding(
                              padding: EdgeInsets.only(top: 100),
                              child: Center(
                                child: Text(
                                  'Keine Geburtstage gefunden!',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          if (pupils.isNotEmpty)
                            ListView.builder(
                              padding: const EdgeInsets.only(
                                top: 10,
                                bottom: 10,
                              ),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: pupils.length,
                              itemBuilder: (context, int index) {
                                PupilProxy listedPupil = pupils[index];

                                // Get the display birthday from the manager
                                final DateTime relevantBirthday = pupilManager
                                    .getBirthdayDisplayDate(
                                      listedPupil,
                                      selectedDate,
                                      untilDate: endDate,
                                    );

                                final bool isBirthdayPrinted = seenBirthdays
                                    .contains(relevantBirthday);
                                if (!isBirthdayPrinted) {
                                  seenBirthdays.add(relevantBirthday);
                                }
                                return Column(
                                  children: [
                                    !isBirthdayPrinted
                                        ? Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 5.0,
                                            ),
                                            child: Row(
                                              children: [
                                                const Gap(5),
                                                Text(
                                                  '${relevantBirthday.asWeekdayName(context)}, ${relevantBirthday.formatDateForUser()}',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors
                                                        .backgroundColor,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        : const SizedBox.shrink(),
                                    InkWell(
                                      onTap: () {
                                        di<BottomNavManager>()
                                            .setPupilProfileNavPage(0);
                                        Navigator.of(context).push(
                                          MaterialPageRoute<void>(
                                            builder: (ctx) => PupilProfilePage(
                                              pupil: listedPupil,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Card(
                                        color: AppColors.cardInCardColor,
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Row(
                                            children: [
                                              AvatarWithBadges(
                                                pupil: listedPupil,
                                                size: 80,
                                              ),
                                              const Gap(10),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    listedPupil.firstName,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                  Text(
                                                    listedPupil.lastName,
                                                    style: const TextStyle(
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const Spacer(),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    listedPupil.age.toString(),
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                      fontSize: 24,
                                                    ),
                                                  ),
                                                  const Gap(5),
                                                  const Text(
                                                    'Jahre alt',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const Gap(20),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Gap(5),
                                  ],
                                );
                              },
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: const GenericBottomNavBar(),
    );
  }
}
