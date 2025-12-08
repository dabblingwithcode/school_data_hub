import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/long_textfield_dialog.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/enums.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_mutator.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/after_school_care/widgets/dialogs/after_school_care_edit_emergency_care_dialog.dart';
import 'package:watch_it/watch_it.dart';

class AfterSchoolCareDetails extends WatchingWidget {
  final PupilProxy pupil;
  const AfterSchoolCareDetails({required this.pupil, super.key});

  @override
  Widget build(BuildContext context) {
    final afterSchoolCare = watchPropertyValue(
      (m) => m.afterSchoolCare,
      target: pupil,
    );

    if (afterSchoolCare == null) {
      return const Padding(
        padding: EdgeInsets.all(10.0),
        child: Text(
          'Keine OGS Daten vorhanden',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      );
    }

    final pickUpTimes = afterSchoolCare.pickUpTimes;

    return Column(
      children: [
        // Emergency Care
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: InkWell(
            onTap: () => afterSchoolCareEditEmergencyCareDialog(context, pupil),
            child: Row(
              children: [
                const Text(
                  'Notbetreuung:',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                const Gap(10),
                Text(
                  afterSchoolCare.emergencyCare == null
                      ? 'Nicht gesetzt'
                      : (afterSchoolCare.emergencyCare == true ? 'Ja' : 'Nein'),
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: afterSchoolCare.emergencyCare == true
                        ? Colors.orange
                        : (afterSchoolCare.emergencyCare == null
                              ? Colors.grey
                              : Colors.black),
                  ),
                ),
                const Gap(10),
                Icon(Icons.edit, size: 18, color: AppColors.backgroundColor),
              ],
            ),
          ),
        ),
        const Gap(10),

        // Pick Up Times Header
        Padding(
          padding: const EdgeInsets.only(left: 10, top: 10),
          child: const Row(
            children: [
              Text(
                'Abholzeiten:',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        const Gap(5),
        // All weekdays with individual edit buttons
        _buildPickUpTimeRow(
          context,
          'Montag',
          pickUpTimes?.monday,
          pupil,
          AfterSchoolCareWeekday.monday,
        ),
        _buildPickUpTimeRow(
          context,
          'Dienstag',
          pickUpTimes?.tuesday,
          pupil,
          AfterSchoolCareWeekday.tuesday,
        ),
        _buildPickUpTimeRow(
          context,
          'Mittwoch',
          pickUpTimes?.wednesday,
          pupil,
          AfterSchoolCareWeekday.wednesday,
        ),
        _buildPickUpTimeRow(
          context,
          'Donnerstag',
          pickUpTimes?.thursday,
          pupil,
          AfterSchoolCareWeekday.thursday,
        ),
        _buildPickUpTimeRow(
          context,
          'Freitag',
          pickUpTimes?.friday,
          pupil,
          AfterSchoolCareWeekday.friday,
        ),
        const Gap(10),

        // OGS Info
        const Padding(
          padding: EdgeInsets.only(left: 10, top: 10),
          child: Row(
            children: [
              Text(
                'OGS Informationen:',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        const Gap(5),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
          child: InkWell(
            onTap: () async {
              final String? ogsInfo = await longTextFieldDialog(
                title: 'OGS Informationen',
                labelText: 'OGS Informationen',
                initialValue: afterSchoolCare.afterSchoolCareInfo ?? '',
                parentContext: context,
              );
              if (ogsInfo == null) return;
              await PupilMutator().updateAfterSchoolCare(
                pupilId: pupil.pupilId,
                afterSchoolCareInfo: (value: ogsInfo),
              );
            },
            onLongPress: () async {
              if (afterSchoolCare.afterSchoolCareInfo == null) return;
              final bool? confirm = await confirmationDialog(
                context: context,
                title: 'OGS Infos löschen',
                message: 'OGS Informationen für dieses Kind löschen?',
              );
              if (confirm == false || confirm == null) return;
              await PupilMutator().updateAfterSchoolCare(
                pupilId: pupil.pupilId,
                afterSchoolCareInfo: (value: null),
              );
            },
            child: Text(
              afterSchoolCare.afterSchoolCareInfo == null ||
                      (afterSchoolCare.afterSchoolCareInfo?.isEmpty ?? true)
                  ? 'keine Informationen'
                  : afterSchoolCare.afterSchoolCareInfo!,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color:
                    afterSchoolCare.afterSchoolCareInfo == null ||
                        (afterSchoolCare.afterSchoolCareInfo?.isEmpty ?? true)
                    ? Colors.grey
                    : AppColors.backgroundColor,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPickUpTimeRow(
    BuildContext context,
    String day,
    PickUpInfo? pickUpInfo,
    PupilProxy pupil,
    AfterSchoolCareWeekday weekday,
  ) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, bottom: 5, right: 10),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              day,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Gap(5),
          Expanded(
            child: Row(
              children: [
                InkWell(
                  onTap: () async {
                    // Parse current time or use current time as default
                    TimeOfDay initialTime = TimeOfDay.now();
                    final currentTime = pickUpInfo?.time;
                    if (currentTime != null && currentTime.isNotEmpty) {
                      final parts = currentTime.split(':');
                      if (parts.length == 2) {
                        final hour = int.tryParse(parts[0]);
                        final minute = int.tryParse(parts[1]);
                        if (hour != null && minute != null) {
                          initialTime = TimeOfDay(hour: hour, minute: minute);
                        }
                      }
                    }

                    final TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: initialTime,
                    );

                    if (pickedTime != null) {
                      // Convert TimeOfDay to HH:mm format
                      final timeString =
                          '${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}';
                      await PupilMutator().updateAfterSchoolCare(
                        pupilId: pupil.pupilId,
                        weekday: (value: weekday),
                        time: timeString,
                        modality: pickUpInfo?.modality ?? '',
                      );
                    }
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (pickUpInfo?.time == null ||
                          pickUpInfo!.time.isEmpty) ...[
                        Icon(
                          Icons.access_time,
                          size: 18,
                          color: AppColors.backgroundColor,
                        ),
                        const Gap(5),
                      ],
                      Text(
                        pickUpInfo?.time ?? 'Nicht gesetzt',
                        style: TextStyle(
                          fontSize:
                              pickUpInfo?.time != null &&
                                  pickUpInfo!.time.isNotEmpty
                              ? 18.0
                              : 16.0,
                          fontWeight: FontWeight.bold,
                          color:
                              pickUpInfo?.time != null &&
                                  pickUpInfo!.time.isNotEmpty
                              ? AppColors.backgroundColor
                              : Colors.grey[600],
                          fontStyle:
                              pickUpInfo?.time != null &&
                                  pickUpInfo!.time.isNotEmpty
                              ? FontStyle.normal
                              : FontStyle.italic,
                        ),
                      ),
                      if (pickUpInfo?.time != null &&
                          pickUpInfo!.time.isNotEmpty) ...[
                        const Gap(5),
                        const Text('Uhr', style: TextStyle(fontSize: 16.0)),
                      ],
                    ],
                  ),
                ),
                const Gap(5),
                Expanded(
                  child: _buildModalityDropdown(
                    context,
                    pickUpInfo?.modality,
                    pupil,
                    weekday,
                    pickUpInfo?.time ?? '',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Converts a modality string to the corresponding enum value
  AfterSchoolCarePickUpModality _modalityStringToEnum(String? modality) {
    if (modality == null || modality.isEmpty) {
      return AfterSchoolCarePickUpModality.notSet;
    }
    // Try to find matching enum by value
    for (final enumValue in AfterSchoolCarePickUpModality.values) {
      if (enumValue.value == modality) {
        return enumValue;
      }
    }
    // If no match found, return notSet
    return AfterSchoolCarePickUpModality.notSet;
  }

  Widget _buildModalityDropdown(
    BuildContext context,
    String? currentModality,
    PupilProxy pupil,
    AfterSchoolCareWeekday weekday,
    String time,
  ) {
    final currentModalityEnum = _modalityStringToEnum(currentModality);

    return DropdownButton<AfterSchoolCarePickUpModality>(
      value: currentModalityEnum,
      isDense: true,
      isExpanded: true,
      underline: Container(),
      items: AfterSchoolCarePickUpModality.values.map((modality) {
        return DropdownMenuItem<AfterSchoolCarePickUpModality>(
          value: modality,
          child: Text(
            modality.value,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 14.0,
              fontStyle: modality == AfterSchoolCarePickUpModality.notSet
                  ? FontStyle.italic
                  : FontStyle.normal,
              color: modality == AfterSchoolCarePickUpModality.notSet
                  ? Colors.grey
                  : Colors.black,
            ),
          ),
        );
      }).toList(),
      onChanged: (AfterSchoolCarePickUpModality? newModality) async {
        if (newModality == null) return;

        // If notSet is selected, we want to clear the modality (set to empty string)
        final modalityString =
            newModality == AfterSchoolCarePickUpModality.notSet
            ? ''
            : newModality.value;

        await PupilMutator().updateAfterSchoolCare(
          pupilId: pupil.pupilId,
          weekday: (value: weekday),
          time: time,
          modality: modalityString,
        );
      },
    );
  }
}
