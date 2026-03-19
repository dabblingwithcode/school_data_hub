import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/button.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';

class BirthdayDateRangeDialog extends WatchingWidget {
  const BirthdayDateRangeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final now = DateTime.now();
    final pastDate = createOnce(() => ValueNotifier<DateTime>(now));
    final futureDate = createOnce(() => ValueNotifier<DateTime>(now));

    final pastDateValue = watch(pastDate).value;
    final futureDateValue = watch(futureDate).value;

    return Dialog(
      constraints: const BoxConstraints(maxWidth: 400),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Style.radii.large),
      ),
      child: Padding(
        padding: EdgeInsets.all(Style.spacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.cake_rounded,
                  size: 20,
                  color: style.colors.error,
                ),
                const Gap(10),
                Text(
                  'Geburtstage',
                  style: context.typography.title,
                ),
              ],
            ),
            const Gap(20),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('von ', style: context.typography.subtitle),
                GestureDetector(
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
                    padding: EdgeInsets.symmetric(
                      horizontal: Style.spacing.md,
                      vertical: Style.spacing.sm,
                    ),
                    decoration: BoxDecoration(
                      color: style.colors.accent,
                      borderRadius: BorderRadius.circular(Style.radii.small),
                    ),
                    child: SizedBox(
                      width: 100,
                      child: Center(
                        child: Text(
                          pastDateValue.isSameDate(now)
                              ? 'heute'
                              : pastDateValue.formatDateForUser(),
                          style: context.typography.body.bold.withColor(
                            style.colors.background,
                          ),
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
                Text('bis  ', style: context.typography.subtitle),
                GestureDetector(
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
                    padding: EdgeInsets.symmetric(
                      horizontal: Style.spacing.md,
                      vertical: Style.spacing.sm,
                    ),
                    decoration: BoxDecoration(
                      color: style.colors.accent,
                      borderRadius: BorderRadius.circular(Style.radii.small),
                    ),
                    child: SizedBox(
                      width: 100,
                      child: Center(
                        child: Text(
                          futureDateValue.isSameDate(now)
                              ? 'heute'
                              : futureDateValue.formatDateForUser(),
                          style: context.typography.body.bold.withColor(
                            style.colors.background,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Gap(20),
            Button(
              variant: ButtonVariant.primary,
              onPressed: () {
                Navigator.of(context).pop((
                  pastDayValue: pastDateValue,
                  futureDayValue: futureDateValue,
                ));
              },
              label: 'ANZEIGEN',
            ),
            const Gap(10),
            Button(
              variant: ButtonVariant.destructive,
              onPressed: () {
                Navigator.of(context).pop();
              },
              label: 'ABBRECHEN',
            ),
          ],
        ),
      ),
    );
  }
}
