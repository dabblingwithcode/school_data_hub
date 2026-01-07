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
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Card(
            color: Colors.grey[100],
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: Colors.grey[300]!),
            ),
            child: const Padding(
              padding: EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.info_outline, size: 48, color: Colors.grey),
                  Gap(12),
                  Text(
                    'Keine OGS Daten vorhanden',
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    final pickUpTimes = afterSchoolCare.pickUpTimes;

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _EmergencyCareCard(pupil: pupil, afterSchoolCare: afterSchoolCare),
          const Gap(16),
          _PickUpTimesCard(pupil: pupil, afterSchoolCare: afterSchoolCare),
          const Gap(16),
          _OgsInfoCard(pupil: pupil, afterSchoolCare: afterSchoolCare),
        ],
      ),
    );
  }
}

// Emergency Care Card Component
class _EmergencyCareCard extends StatelessWidget {
  final PupilProxy pupil;
  final AfterSchoolCare afterSchoolCare;

  const _EmergencyCareCard({
    required this.pupil,
    required this.afterSchoolCare,
  });

  @override
  Widget build(BuildContext context) {
    final emergencyCare = afterSchoolCare.emergencyCare;
    final isEmergency = emergencyCare == true;
    final isNotSet = emergencyCare == null;

    return Card(
      elevation: 2,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () => afterSchoolCareEditEmergencyCareDialog(context, pupil),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isEmergency
                      ? Colors.orange.withOpacity(0.1)
                      : (isNotSet
                            ? Colors.grey.withOpacity(0.1)
                            : Colors.green.withOpacity(0.1)),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  isEmergency
                      ? Icons.warning_amber_rounded
                      : (isNotSet
                            ? Icons.help_outline
                            : Icons.check_circle_outline),
                  size: 28,
                  color: isEmergency
                      ? Colors.orange
                      : (isNotSet ? Colors.grey : Colors.green),
                ),
              ),
              const Gap(16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Notbetreuung',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54,
                      ),
                    ),
                    const Gap(4),
                    Text(
                      isNotSet
                          ? 'Nicht gesetzt'
                          : (isEmergency ? 'Ja' : 'Nein'),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isEmergency
                            ? Colors.orange
                            : (isNotSet ? Colors.grey : Colors.black87),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.edit, size: 20, color: AppColors.backgroundColor),
            ],
          ),
        ),
      ),
    );
  }
}

// Pick Up Times Card Component
class _PickUpTimesCard extends StatelessWidget {
  final PupilProxy pupil;
  final AfterSchoolCare afterSchoolCare;

  const _PickUpTimesCard({required this.pupil, required this.afterSchoolCare});

  @override
  Widget build(BuildContext context) {
    final pickUpTimes = afterSchoolCare.pickUpTimes;

    return Card(
      elevation: 2,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.access_time,
                    size: 20,
                    color: AppColors.backgroundColor,
                  ),
                ),
                const Gap(12),
                const Text(
                  'Abholzeiten',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            const Gap(16),
            _PickUpTimeRow(
              day: 'Montag',
              pickUpInfo: pickUpTimes?.monday,
              pupil: pupil,
              weekday: AfterSchoolCareWeekday.monday,
            ),
            const Divider(height: 24),
            _PickUpTimeRow(
              day: 'Dienstag',
              pickUpInfo: pickUpTimes?.tuesday,
              pupil: pupil,
              weekday: AfterSchoolCareWeekday.tuesday,
            ),
            const Divider(height: 24),
            _PickUpTimeRow(
              day: 'Mittwoch',
              pickUpInfo: pickUpTimes?.wednesday,
              pupil: pupil,
              weekday: AfterSchoolCareWeekday.wednesday,
            ),
            const Divider(height: 24),
            _PickUpTimeRow(
              day: 'Donnerstag',
              pickUpInfo: pickUpTimes?.thursday,
              pupil: pupil,
              weekday: AfterSchoolCareWeekday.thursday,
            ),
            const Divider(height: 24),
            _PickUpTimeRow(
              day: 'Freitag',
              pickUpInfo: pickUpTimes?.friday,
              pupil: pupil,
              weekday: AfterSchoolCareWeekday.friday,
            ),
          ],
        ),
      ),
    );
  }
}

// Pick Up Time Row Component
class _PickUpTimeRow extends StatelessWidget {
  final String day;
  final PickUpInfo? pickUpInfo;
  final PupilProxy pupil;
  final AfterSchoolCareWeekday weekday;

  const _PickUpTimeRow({
    required this.day,
    required this.pickUpInfo,
    required this.pupil,
    required this.weekday,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(
              width: 90,
              child: Text(
                day,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
            const Gap(12),
            Expanded(
              child: _TimeSelector(
                pickUpInfo: pickUpInfo,
                pupil: pupil,
                weekday: weekday,
              ),
            ),
          ],
        ),
        const Gap(8),
        Padding(
          padding: const EdgeInsets.only(left: 102),
          child: _ModalitySelector(
            pickUpInfo: pickUpInfo,
            pupil: pupil,
            weekday: weekday,
          ),
        ),
      ],
    );
  }
}

// Time Selector Component
class _TimeSelector extends StatelessWidget {
  final PickUpInfo? pickUpInfo;
  final PupilProxy pupil;
  final AfterSchoolCareWeekday weekday;

  const _TimeSelector({
    required this.pickUpInfo,
    required this.pupil,
    required this.weekday,
  });

  Future<void> _selectTime(BuildContext context) async {
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
      final timeString =
          '${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}';
      await PupilMutator().updateAfterSchoolCare(
        pupilId: pupil.pupilId,
        weekday: (value: weekday),
        time: timeString,
        modality: pickUpInfo?.modality ?? '',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasTime = pickUpInfo?.time != null && pickUpInfo!.time.isNotEmpty;

    return InkWell(
      onTap: () => _selectTime(context),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: hasTime
              ? AppColors.backgroundColor.withOpacity(0.1)
              : Colors.grey.withOpacity(0.05),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: hasTime
                ? AppColors.backgroundColor.withOpacity(0.3)
                : Colors.grey[300]!,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.schedule,
              size: 18,
              color: hasTime ? AppColors.backgroundColor : Colors.grey[600],
            ),
            const Gap(8),
            Text(
              hasTime ? '${pickUpInfo!.time} Uhr' : 'Nicht gesetzt',
              style: TextStyle(
                fontSize: hasTime ? 16 : 14,
                fontWeight: hasTime ? FontWeight.w600 : FontWeight.normal,
                color: hasTime ? AppColors.backgroundColor : Colors.grey[600],
                fontStyle: hasTime ? FontStyle.normal : FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Modality Selector Component
class _ModalitySelector extends StatelessWidget {
  final PickUpInfo? pickUpInfo;
  final PupilProxy pupil;
  final AfterSchoolCareWeekday weekday;

  const _ModalitySelector({
    required this.pickUpInfo,
    required this.pupil,
    required this.weekday,
  });

  AfterSchoolCarePickUpModality _modalityStringToEnum(String? modality) {
    if (modality == null || modality.isEmpty) {
      return AfterSchoolCarePickUpModality.notSet;
    }
    for (final enumValue in AfterSchoolCarePickUpModality.values) {
      if (enumValue.value == modality) {
        return enumValue;
      }
    }
    return AfterSchoolCarePickUpModality.notSet;
  }

  @override
  Widget build(BuildContext context) {
    final currentModalityEnum = _modalityStringToEnum(pickUpInfo?.modality);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: DropdownButton<AfterSchoolCarePickUpModality>(
        value: currentModalityEnum,
        isDense: true,
        isExpanded: true,
        underline: Container(),
        icon: Icon(Icons.arrow_drop_down, color: Colors.grey[700]),
        items: AfterSchoolCarePickUpModality.values.map((modality) {
          return DropdownMenuItem<AfterSchoolCarePickUpModality>(
            value: modality,
            child: Row(
              children: [
                Icon(
                  _getModalityIcon(modality),
                  size: 16,
                  color: modality == AfterSchoolCarePickUpModality.notSet
                      ? Colors.grey
                      : Colors.black54,
                ),
                const Gap(8),
                Expanded(
                  child: Text(
                    modality.value,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      fontStyle:
                          modality == AfterSchoolCarePickUpModality.notSet
                          ? FontStyle.italic
                          : FontStyle.normal,
                      color: modality == AfterSchoolCarePickUpModality.notSet
                          ? Colors.grey
                          : Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
        onChanged: (AfterSchoolCarePickUpModality? newModality) async {
          if (newModality == null) return;

          final modalityString =
              newModality == AfterSchoolCarePickUpModality.notSet
              ? ''
              : newModality.value;

          await PupilMutator().updateAfterSchoolCare(
            pupilId: pupil.pupilId,
            weekday: (value: weekday),
            time: pickUpInfo?.time ?? '',
            modality: modalityString,
          );
        },
      ),
    );
  }

  IconData _getModalityIcon(AfterSchoolCarePickUpModality modality) {
    if (modality == AfterSchoolCarePickUpModality.notSet) {
      return Icons.help_outline;
    }
    // Add specific icons for different modalities if needed
    return Icons.directions_walk;
  }
}

// OGS Info Card Component
class _OgsInfoCard extends StatelessWidget {
  final PupilProxy pupil;
  final AfterSchoolCare afterSchoolCare;

  const _OgsInfoCard({required this.pupil, required this.afterSchoolCare});

  Future<void> _editInfo(BuildContext context) async {
    final result = await longTextFieldDialog(
      title: 'OGS Informationen',
      labelText: 'OGS Informationen',
      initialValue: afterSchoolCare.afterSchoolCareInfo ?? '',
      parentContext: context,
    );
    if (result == null || result.value == afterSchoolCare.afterSchoolCareInfo) {
      return;
    }
    await PupilMutator().updateAfterSchoolCare(
      pupilId: pupil.pupilId,
      afterSchoolCareInfo: (value: result.value),
    );
  }

  Future<void> _deleteInfo(BuildContext context) async {
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
  }

  @override
  Widget build(BuildContext context) {
    final hasInfo =
        afterSchoolCare.afterSchoolCareInfo != null &&
        afterSchoolCare.afterSchoolCareInfo!.isNotEmpty;

    return Card(
      elevation: 2,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () => _editInfo(context),
        onLongPress: () => _deleteInfo(context),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: hasInfo
                          ? AppColors.backgroundColor.withOpacity(0.1)
                          : Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.info_outline,
                      size: 20,
                      color: hasInfo ? AppColors.backgroundColor : Colors.grey,
                    ),
                  ),
                  const Gap(12),
                  const Expanded(
                    child: Text(
                      'OGS Informationen',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  Icon(Icons.edit, size: 20, color: AppColors.backgroundColor),
                ],
              ),
              const Gap(12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: hasInfo ? Colors.grey[50] : Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Text(
                  hasInfo
                      ? afterSchoolCare.afterSchoolCareInfo!
                      : 'Keine Informationen vorhanden',
                  style: TextStyle(
                    fontSize: hasInfo ? 15 : 14,
                    fontWeight: hasInfo ? FontWeight.normal : FontWeight.normal,
                    color: hasInfo ? Colors.black87 : Colors.grey[600],
                    fontStyle: hasInfo ? FontStyle.normal : FontStyle.italic,
                  ),
                ),
              ),
              if (hasInfo)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    'Lang drücken zum Löschen',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
