import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/long_textfield_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/card_box.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/enums.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_mutator.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/after_school_care/widgets/dialogs/after_school_care_edit_emergency_care_dialog.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/pupil_profile_screen/widgets/pupil_profile_content_widgets.dart';

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
      final style = Style.of(context);
      return Center(
        child: Padding(
          padding: EdgeInsets.all(Style.spacing.xl),
          child: CardBox(
            variant: CardBoxVariant.bordered,
            padding: EdgeInsets.all(Style.spacing.xl),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.info_outline,
                  size: 48,
                  color: style.colors.mutedForeground,
                ),
                Gap(Style.spacing.md),
                Text(
                  'Keine OGS Daten vorhanden',
                  style: context.typography.subtitle,
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _EmergencyCareCard(pupil: pupil, afterSchoolCare: afterSchoolCare),
        Gap(Style.spacing.md),
        _PickUpTimesCard(pupil: pupil, afterSchoolCare: afterSchoolCare),
        Gap(Style.spacing.md),
        _OgsInfoCard(pupil: pupil, afterSchoolCare: afterSchoolCare),
      ],
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

    return PupilProfileContentRow(
      icon: isEmergency
          ? Icons.warning_amber_rounded
          : (isNotSet ? Icons.help_outline : Icons.check_circle_outline),
      label: 'Notbetreuung',
      onTap: () => afterSchoolCareEditEmergencyCareDialog(context, pupil),
      value: isNotSet ? 'Nicht gesetzt' : (isEmergency ? 'Ja' : 'Nein'),
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
    final style = Style.of(context);
    final pickUpTimes = afterSchoolCare.pickUpTimes;

    return CardBox(
      variant: CardBoxVariant.filledSecondary,
      padding: EdgeInsets.all(Style.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(Style.spacing.sm),
                decoration: BoxDecoration(
                  color: style.colors.accent.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(Style.radii.small),
                ),
                child: Icon(
                  Icons.access_time,
                  size: 20,
                  color: style.colors.accent,
                ),
              ),
              Gap(Style.spacing.md),
              Text(
                'Abholzeiten',
                style: context.typography.title.withColor(
                  style.colors.foreground,
                ),
              ),
            ],
          ),
          Gap(Style.spacing.lg),
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
                style: context.typography.body.bold.withColor(
                  Style.of(context).colors.foreground,
                ),
              ),
            ),
            Gap(Style.spacing.md),
            Expanded(
              child: _TimeSelector(
                pickUpInfo: pickUpInfo,
                pupil: pupil,
                weekday: weekday,
              ),
            ),
          ],
        ),
        Gap(Style.spacing.sm),
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
    final style = Style.of(context);
    final hasTime = pickUpInfo?.time != null && pickUpInfo!.time.isNotEmpty;

    return GestureDetector(
      onTap: () => _selectTime(context),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Style.spacing.md,
          vertical: Style.spacing.sm,
        ),
        decoration: BoxDecoration(
          color: hasTime
              ? style.colors.accent.withValues(alpha: 0.1)
              : style.colors.mutedForeground.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(Style.radii.small),
          border: Border.all(
            color: hasTime
                ? style.colors.accent.withValues(alpha: 0.3)
                : style.colors.border,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.schedule,
              size: 18,
              color: hasTime
                  ? style.colors.accent
                  : style.colors.mutedForeground,
            ),
            Gap(Style.spacing.sm),
            Text(
              hasTime ? '${pickUpInfo!.time} Uhr' : 'Nicht gesetzt',
              style: TextStyle(
                fontSize: hasTime ? 16 : 14,
                fontWeight: hasTime ? FontWeight.w600 : FontWeight.normal,
                color: hasTime
                    ? style.colors.accent
                    : style.colors.mutedForeground,
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
    final style = Style.of(context);
    final currentModalityEnum = _modalityStringToEnum(pickUpInfo?.modality);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Style.spacing.md,
        vertical: Style.spacing.xs,
      ),
      decoration: BoxDecoration(
        color: style.colors.background,
        borderRadius: BorderRadius.circular(Style.radii.small),
        border: Border.all(color: style.colors.border),
      ),
      child: DropdownButton<AfterSchoolCarePickUpModality>(
        value: currentModalityEnum,
        isDense: true,
        isExpanded: true,
        underline: Container(),
        icon: Icon(Icons.arrow_drop_down, color: style.colors.mutedForeground),
        items: AfterSchoolCarePickUpModality.values.map((modality) {
          return DropdownMenuItem<AfterSchoolCarePickUpModality>(
            value: modality,
            child: Row(
              children: [
                Icon(
                  _getModalityIcon(modality),
                  size: 16,
                  color: modality == AfterSchoolCarePickUpModality.notSet
                      ? style.colors.mutedForeground
                      : style.colors.foreground,
                ),
                Gap(Style.spacing.sm),
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
                          ? style.colors.mutedForeground
                          : style.colors.foreground,
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
    final style = Style.of(context);
    final hasInfo =
        afterSchoolCare.afterSchoolCareInfo != null &&
        afterSchoolCare.afterSchoolCareInfo!.isNotEmpty;

    return CardBox(
      variant: CardBoxVariant.filledSecondary,
      onTap: () => _editInfo(context),
      padding: EdgeInsets.all(Style.spacing.lg),
      child: GestureDetector(
        onLongPress: () => _deleteInfo(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(Style.spacing.sm),
                  decoration: BoxDecoration(
                    color: hasInfo
                        ? style.colors.accent.withValues(alpha: 0.1)
                        : style.colors.mutedForeground.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(Style.radii.small),
                  ),
                  child: Icon(
                    Icons.info_outline,
                    size: 20,
                    color: hasInfo
                        ? style.colors.accent
                        : style.colors.mutedForeground,
                  ),
                ),
                Gap(Style.spacing.md),
                Expanded(
                  child: Text(
                    'OGS Informationen',
                    style: context.typography.title.withColor(
                      style.colors.foreground,
                    ),
                  ),
                ),
                Icon(Icons.edit, size: 20, color: style.colors.accent),
              ],
            ),
            Gap(Style.spacing.md),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(Style.spacing.md),
              decoration: BoxDecoration(
                color: style.colors.background,
                borderRadius: BorderRadius.circular(Style.radii.small),
                border: Border.all(color: style.colors.border),
              ),
              child: Text(
                hasInfo
                    ? afterSchoolCare.afterSchoolCareInfo!
                    : 'Keine Informationen vorhanden',
                style: TextStyle(
                  fontSize: hasInfo ? 15 : 14,
                  fontWeight: FontWeight.normal,
                  color: hasInfo
                      ? style.colors.foreground
                      : style.colors.mutedForeground,
                  fontStyle: hasInfo ? FontStyle.normal : FontStyle.italic,
                ),
              ),
            ),
            if (hasInfo)
              Padding(
                padding: EdgeInsets.only(top: Style.spacing.sm),
                child: Text(
                  'Lang drücken zum Löschen',
                  style: context.typography.bodySmall
                      .withColor(style.colors.mutedForeground)
                      .copyWith(fontStyle: FontStyle.italic),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
