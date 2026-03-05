import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';

class BirthdayDateRangeDialog extends WatchingWidget {
  const BirthdayDateRangeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final pastDate = createOnce(() => ValueNotifier<DateTime>(now));
    final futureDate = createOnce(() => ValueNotifier<DateTime>(now));

    final pastDateValue = watch(pastDate).value;
    final futureDateValue = watch(futureDate).value;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.cake_rounded,
                  size: 20,
                  color: Color.fromARGB(255, 228, 76, 99),
                ),
                Gap(10),
                Text(
                  'Geburtstage',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Gap(20),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('von ', style: TextStyle(fontSize: 16)),
                InkWell(
                  onTap: () async {
                    final selected = await showDatePicker(
                      context: context,
                      initialDate: pastDateValue,
                      firstDate: DateTime(now.year - 1, now.month, now.day),
                      lastDate: now,
                    );
                    if (selected != null) {
                      pastDate.value = selected;
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: SizedBox(
                      width: 100,
                      child: Center(
                        child: Text(
                          pastDateValue.isSameDate(now)
                              ? 'heute'
                              : pastDateValue.formatDateForUser(),
                          style: AppStyles.buttonTextStyle,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Gap(12),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('bis  ', style: TextStyle(fontSize: 16)),
                InkWell(
                  onTap: () async {
                    final selected = await showDatePicker(
                      context: context,
                      initialDate: futureDateValue,
                      firstDate: now,
                      lastDate: DateTime(now.year + 1, now.month, now.day),
                    );
                    if (selected != null) {
                      futureDate.value = selected;
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: SizedBox(
                      width: 100,
                      child: Center(
                        child: Text(
                          futureDateValue.isSameDate(now)
                              ? 'heute'
                              : futureDateValue.formatDateForUser(),
                          style: AppStyles.buttonTextStyle,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Gap(20),
            ElevatedButton(
              style: AppStyles.successButtonStyle,
              onPressed: () {
                Navigator.of(context).pop((
                  pastDayValue: pastDateValue,
                  futureDayValue: futureDateValue,
                ));
              },
              child: const Text('ANZEIGEN', style: AppStyles.buttonTextStyle),
            ),

            const Gap(10),
            ElevatedButton(
              style: AppStyles.cancelButtonStyle,
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('ABBRECHEN', style: AppStyles.buttonTextStyle),
            ),
          ],
        ),
      ),
    );
  }
}
