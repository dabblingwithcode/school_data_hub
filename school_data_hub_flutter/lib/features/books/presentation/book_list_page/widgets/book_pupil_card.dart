import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/app_utils/extensions.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/long_textfield_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/growth_dropdown.dart';
import 'package:school_data_hub_flutter/features/app_main_navigation/domain/main_menu_bottom_nav_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/pupil_profile_page.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/widgets/avatar.dart';
import 'package:watch_it/watch_it.dart';

class BookPupilCard extends WatchingWidget {
  final PupilBookLending passedPupilBook;
  const BookPupilCard({required this.passedPupilBook, super.key});

  @override
  Widget build(BuildContext context) {
    final pupil = watch<PupilProxy>(
        di<PupilManager>().getPupilByPupilId(passedPupilBook.pupilId)!);
    final watchedPupilBook = pupil.pupilBooks?.firstWhere(
        (element) => element.lendingId == passedPupilBook.lendingId);
    updatepupilBookRating(int rating) {
      // TODO: Uncomment this when the API is ready
      // di<PupilManager>()
      //     .patchPupilBook(lendingId: passedPupilBook.lendingId, rating: rating);
    }

    return Card(
      color: AppColors.cardInCardColor,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 1.0,
      margin:
          const EdgeInsets.only(left: 4.0, right: 4.0, top: 4.0, bottom: 4.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                AvatarWithBadges(pupil: pupil, size: 80),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Gap(10),
                      Row(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: InkWell(
                                onTap: () {
                                  di<BottomNavManager>()
                                      .setPupilProfileNavPage(9);
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (ctx) => PupilProfilePage(
                                      pupil: pupil,
                                    ),
                                  ));
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
                      Row(
                        children: [
                          Text(
                            watchedPupilBook!.lentBy,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Gap(2),
                          const Icon(
                            Icons.arrow_circle_right_rounded,
                            color: Colors.orange,
                          ),
                          const Gap(2),
                          Text(
                            watchedPupilBook.lentAt.formatForUser(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      if (watchedPupilBook.returnedAt != null)
                        Row(
                          children: [
                            Text(
                              watchedPupilBook.receivedBy!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Gap(2),
                            const Icon(
                              Icons.arrow_circle_left_rounded,
                              color: Colors.green,
                            ),
                            const Gap(2),
                            Text(
                              watchedPupilBook.returnedAt!.formatForUser(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Gap(20),
                    GrowthDropdown(
                        dropdownValue: watchedPupilBook.score ?? 0,
                        onChangedFunction: updatepupilBookRating),
                  ],
                ),
                const Gap(5),
              ],
            ),
            const Text('Status:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const Gap(2),
            InkWell(
              onLongPress: () async {
                final status = await longTextFieldDialog(
                    title: 'Status',
                    labelText: 'Status',
                    initialValue: watchedPupilBook.status ?? '',
                    parentContext: context);
                if (status == null) return;
                // TODO: Uncomment this when the API is ready
                // await di<PupilManager>().patchPupilBook(
                //     lendingId: watchedPupilBook.lendingId, comment: status);
              },
              child: Text(
                watchedPupilBook.status ?? 'Keine Einträge',
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            const Gap(10),
          ],
        ),
      ),
    );
  }
}
