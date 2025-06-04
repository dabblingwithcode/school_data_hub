import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/features/_attendance/presentation/widgets/attendance_badges.dart';

void missedSchooldaysBadgesInformationDialog(
        {required BuildContext context, bool? isAttendancePage}) =>
    showDialog(
      context: context,
      builder: (newContext) => AlertDialog(
        title: const Text(
          'Legende',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: SizedBox(
          height: isAttendancePage == true ? 280 : 200,
          child: Column(children: [
            Row(
              children: [
                excusedBadge(false),
                const Gap(5),
                const Text(
                  'Fehltage',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Gap(5),
            Row(
              children: [
                excusedBadge(true),
                const Gap(5),
                const Text(
                  'unentschuldigte Fehltage',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Gap(5),
            Row(
              children: [
                missedTypeBadge('late'),
                const Text(
                  ' Verspätungen',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Gap(5),
            Row(
              children: [
                contactedBadge(1),
                const Gap(5),
                const Text(
                  'Kontaktiert',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Gap(5),
            Row(
              children: [
                returnedBadge(true),
                const Gap(5),
                const Text(
                  'Abgeholt',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            if (isAttendancePage == true) const Gap(5),
            if (isAttendancePage == true)
              Row(
                children: [
                  Container(
                    width: 25.0,
                    height: 25.0,
                    decoration: const BoxDecoration(
                      color:
                          AppColors.contactedSuccessColor, // Colors.green[100],
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(Icons.local_phone_rounded),
                    ),
                  ),
                  const Gap(5),
                  const Text(
                    'Familie erreicht',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            if (isAttendancePage == true) const Gap(5),
            if (isAttendancePage == true)
              Row(
                children: [
                  Container(
                    width: 25.0,
                    height: 25.0,
                    decoration: const BoxDecoration(
                      color: AppColors.contactedCalledBackColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.phone_callback_rounded,
                      ),
                    ),
                  ),
                  const Gap(5),
                  const Text(
                    'Familie hat sich zurückgemeldet',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            if (isAttendancePage == true) const Gap(5),
            if (isAttendancePage == true)
              Row(
                children: [
                  Container(
                    width: 25.0,
                    height: 25.0,
                    decoration: const BoxDecoration(
                      color: AppColors.contactedFailedColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(Icons.phone_disabled_rounded),
                    ),
                  ),
                  const Gap(5),
                  const Text(
                    'Familie nicht erreicht',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
          ]),
        ),
        actions: [
          TextButton(
            child: const Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Text(
                'OK',
                style: TextStyle(
                  color: Color.fromRGBO(74, 76, 161, 1),
                ),
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
