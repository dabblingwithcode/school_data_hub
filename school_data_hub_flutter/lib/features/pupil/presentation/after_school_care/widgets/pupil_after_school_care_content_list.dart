import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/long_textfield_dialog.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/enums.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_mutator.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/after_school_care/widgets/dialogs/after_school_care_pickup_time_dialog.dart';
import 'package:school_data_hub_flutter/features/school_calendar/domain/school_calendar_manager.dart';
import 'package:watch_it/watch_it.dart';

List<Widget> pupilAfterSchoolCareContentList(
  PupilProxy pupil,
  BuildContext context,
) {
  final schoolCalendarManager = di<SchoolCalendarManager>();
  final thisDate = schoolCalendarManager.thisDate.value;
  final weekday = dateTimeToAfterSchoolCareWeekday(thisDate);
  final pickUpTime = weekday != null ? pupil.pickUpTime(weekday) : null;

  return [
    Row(
      children: [
        const Text('Abholzeit:', style: TextStyle(fontSize: 18.0)),
        const Gap(10),
        InkWell(
          onTap: () => pickUpTimeDialog(context, pupil, pickUpTime),
          child: Text(
            pickUpTime ?? 'keine',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.backgroundColor,
            ),
          ),
        ),
        const Gap(5),
        const Text('Uhr', style: TextStyle(fontSize: 18.0)),
      ],
    ),
    const Gap(10),
    const Row(
      children: [
        Text('OGS Infos:', style: TextStyle(fontSize: 18.0)),
        Gap(5),
      ],
    ),
    const Gap(5),
    InkWell(
      onTap: () async {
        final String? ogsInfo = await longTextFieldDialog(
          title: 'OGS Informationen',
          labelText: 'OGS Informationen',
          initialValue: pupil.afterSchoolCareInfo,
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
        if (pupil.afterSchoolCareInfo == null) return;
        final bool? confirm = await confirmationDialog(
          context: context,
          title: 'OGS Infos löschen',
          message: 'OGS Informationen für dieses Kind löschen?',
        );
        if (confirm == false || confirm == null) return;
        await PupilMutator().updateStringProperty(
          pupilId: pupil.internalId,
          property: 'afterSchoolCareInfo',
          value: null,
        );
      },
      child: Row(
        children: [
          Flexible(
            child: pupil.afterSchoolCareInfo != null
                ? Text(
                    pupil.afterSchoolCareInfo!,
                    softWrap: true,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.backgroundColor,
                    ),
                  )
                : const Text(
                    'keine Informationen',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ],
      ),
    ),
    const Gap(10),
  ];
}
