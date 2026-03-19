import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/button.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/popup.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/_attendance/presentation/widgets/attendance_badges.dart';

void missedSchooldaysBadgesInformationDialog({
  required BuildContext context,
  bool? isAttendancePage,
}) => Popup.show(
  context: context,
  title: 'Legende',
  child: _LegendContent(isAttendancePage: isAttendancePage),
);

class _LegendContent extends StatelessWidget {
  final bool? isAttendancePage;

  const _LegendContent({this.isAttendancePage});

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            excusedBadge(false),
            const Gap(5),
            Text(
              'Fehltage',
              style: context.typography.subtitle.bold,
            ),
          ],
        ),
        const Gap(5),
        Row(
          children: [
            excusedBadge(true),
            const Gap(5),
            Text(
              'unentschuldigte Fehltage',
              style: context.typography.subtitle.bold,
            ),
          ],
        ),
        const Gap(5),
        Row(
          children: [
            missedTypeBadge(MissedType.late),
            Text(
              ' Verspätungen',
              style: context.typography.subtitle.bold,
            ),
          ],
        ),
        const Gap(5),
        Row(
          children: [
            contactedBadge(1),
            const Gap(5),
            Text(
              'Kontaktiert',
              style: context.typography.subtitle.bold,
            ),
          ],
        ),
        const Gap(5),
        Row(
          children: [
            returnedBadge(true),
            const Gap(5),
            Text(
              'Abgeholt',
              style: context.typography.subtitle.bold,
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
                decoration: BoxDecoration(
                  color: style.colors.attendanceContactedSuccess,
                  shape: BoxShape.circle,
                ),
                child: const Center(child: Icon(Icons.local_phone_rounded)),
              ),
              const Gap(5),
              Text(
                'Familie erreicht',
                style: context.typography.subtitle.bold,
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
                decoration: BoxDecoration(
                  color: style.colors.attendanceContactedCalledBack,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(Icons.phone_callback_rounded),
                ),
              ),
              const Gap(5),
              Flexible(
                child: Text(
                  'Familie hat sich zurückgemeldet',
                  style: context.typography.subtitle.bold,
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
                decoration: BoxDecoration(
                  color: style.colors.attendanceContactedFailed,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(Icons.phone_disabled_rounded),
                ),
              ),
              const Gap(5),
              Text(
                'Familie nicht erreicht',
                style: context.typography.subtitle.bold,
              ),
            ],
          ),
        SizedBox(height: Style.spacing.xl),
        Button(
          label: 'OK',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
