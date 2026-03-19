import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar/action_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/card_box.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_proxy_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/pupil_profile_screen/pupil_profile_screen.dart';
import 'package:school_data_hub_flutter/common/widgets/avatar/avatar.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/domain/main_menu_bottom_nav_manager.dart';

class BirthdaysScreen extends StatelessWidget {
  final DateTime selectedDate;
  final DateTime? endDate;
  final bool futureBirthdays;
  const BirthdaysScreen({
    required this.selectedDate,
    this.endDate,
    this.futureBirthdays = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final Set<DateTime> seenBirthdays = {};
    final pupilManager = di<PupilProxyManager>();
    final List<PupilProxy> pupils = pupilManager.getPupilsWithBirthdaySinceDate(
      selectedDate,
      untilDate: endDate,
    );

    return Scaffold(
      backgroundColor: style.colors.canvas,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: style.colors.accent,
        title: Text(
          'Geburtstage',
          style: context.typography.title.withColor(style.colors.background),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: Style.spacing.sm),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Style.spacing.sm,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            endDate != null
                                ? 'Geburtstage vom ${selectedDate.formatDateForUser()} bis ${endDate!.formatDateForUser()}'
                                : 'Geburtstage seit dem ${selectedDate.formatDateForUser()}',
                            style: context.typography.title,
                          ),
                          if (pupils.isEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 100),
                              child: Center(
                                child: Text(
                                  'Keine Geburtstage gefunden!',
                                  style: context.typography.title.withColor(
                                    style.colors.mutedForeground,
                                  ),
                                ),
                              ),
                            ),
                          if (pupils.isNotEmpty)
                            ListView.builder(
                              padding: EdgeInsets.symmetric(
                                vertical: Style.spacing.md,
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
                                            padding: EdgeInsets.symmetric(
                                              vertical: Style.spacing.xs,
                                            ),
                                            child: Row(
                                              children: [
                                                Gap(Style.spacing.xs),
                                                Text(
                                                  '${relevantBirthday.asWeekdayName(context)}, ${relevantBirthday.formatDateForUser()}',
                                                  style: context
                                                      .typography
                                                      .title
                                                      .withColor(
                                                        style.colors.accent,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          )
                                        : const SizedBox.shrink(),
                                    GestureDetector(
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
                                      child: CardBox(
                                        padding: EdgeInsets.all(
                                          Style.spacing.md,
                                        ),
                                        child: Row(
                                          children: [
                                            AvatarWithBadges(
                                              pupil: listedPupil,
                                              size: 80,
                                            ),
                                            Gap(Style.spacing.md),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  listedPupil.firstName,
                                                  style: context
                                                      .typography
                                                      .title
                                                      .withColor(
                                                        style.colors.foreground,
                                                      )
                                                      .bold,
                                                ),
                                                Text(
                                                  listedPupil.lastName,
                                                  style: context
                                                      .typography
                                                      .title
                                                      .withColor(
                                                        style.colors.foreground,
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
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        style.colors.foreground,
                                                    fontSize: 24,
                                                  ),
                                                ),
                                                Gap(Style.spacing.xs),
                                                Text(
                                                  'Jahre alt',
                                                  style: context
                                                      .typography
                                                      .title
                                                      .withColor(
                                                        style.colors.foreground,
                                                      )
                                                      .bold,
                                                ),
                                              ],
                                            ),
                                            Gap(Style.spacing.xl),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Gap(Style.spacing.xs),
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

      bottomNavigationBar: const ActionBar(),
    );
  }
}
