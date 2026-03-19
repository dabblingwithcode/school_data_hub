import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/card_box.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_proxy_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/select_pupils_list_page/select_pupils_list_page.dart';
import 'package:school_data_hub_flutter/features/timetable/domain/timetable_manager.dart';
import 'package:flutter_it/flutter_it.dart';

/// Widget for managing pupils in a lesson group
class PupilManagementSection extends WatchingWidget {
  final TimetableManager timetableManager;
  final int? lessonGroupId;
  final List<int> selectedPupilIds;
  final ValueChanged<List<int>> onPupilIdsChanged;

  const PupilManagementSection({
    super.key,
    required this.timetableManager,
    required this.lessonGroupId,
    required this.selectedPupilIds,
    required this.onPupilIdsChanged,
  });

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final pupils = di<PupilProxyManager>().allPupils;

    // Get selected pupils
    final selectedPupils = pupils
        .where((pupil) => selectedPupilIds.contains(pupil.pupilId))
        .toList();

    return CardBox(
      padding: EdgeInsets.all(Style.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Schüler in dieser Lerngruppe',
                style: context.typography.subtitle.bold,
              ),
              Row(
                children: [
                  if (selectedPupilIds.isNotEmpty)
                    Text(
                      '${selectedPupilIds.length} ausgewählt',
                      style: context.typography.body.withColor(style.colors.mutedForeground),
                    ),
                  Gap(Style.spacing.sm),
                  ElevatedButton.icon(
                    onPressed: () => _selectPupils(context),
                    icon: const Icon(Icons.people, size: 18),
                    label: const Text('Schüler auswählen'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: Style.spacing.md,
                        vertical: Style.spacing.sm,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Gap(Style.spacing.md),
          if (selectedPupils.isEmpty)
            Container(
              padding: EdgeInsets.all(Style.spacing.lg),
              decoration: BoxDecoration(
                color: style.colors.borderSubtle,
                borderRadius: BorderRadius.circular(Style.radii.small),
                border: Border.all(color: style.colors.border),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: style.colors.mutedForeground),
                  Gap(Style.spacing.sm),
                  Expanded(
                    child: Text(
                      'Keine Schüler ausgewählt. Klicken Sie auf "Schüler auswählen", um Schüler zu dieser Klasse hinzuzufügen.',
                      style: TextStyle(color: style.colors.mutedForeground),
                    ),
                  ),
                ],
              ),
            )
          else
            SizedBox(
              height: 300, // Fixed height for the pupil list
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ...selectedPupils.map(
                      (pupil) => _buildPupilCard(context, pupil),
                    ),
                    Gap(Style.spacing.sm),
                    TextButton.icon(
                      onPressed: () => _selectPupils(context),
                      icon: const Icon(Icons.edit, size: 16),
                      label: const Text('Schülerliste bearbeiten'),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPupilCard(BuildContext context, PupilProxy pupil) {
    final style = Style.of(context);
    final fullName = '${pupil.firstName} ${pupil.lastName}'.trim();
    final initial = fullName.isNotEmpty ? fullName[0].toUpperCase() : '?';

    return CardBox(
      padding: EdgeInsets.all(Style.spacing.sm),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: Text(
            initial,
            style: TextStyle(
              color: style.colors.background,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          fullName.isNotEmpty ? fullName : 'Unbekannter Schüler',
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        subtitle: Text(
          'ID: ${pupil.pupilId}',
          style: context.typography.bodySmall.withColor(style.colors.mutedForeground),
        ),
        trailing: IconButton(
          icon: Icon(Icons.remove_circle_outline, color: style.colors.error),
          onPressed: () => _removePupil(pupil.pupilId),
          tooltip: 'Schüler entfernen',
        ),
      ),
    );
  }

  void _selectPupils(BuildContext context) async {
    final result = await Navigator.of(context).push<List<int>>(
      MaterialPageRoute<List<int>>(
        builder: (context) => SelectPupilsListScreen(
          selectablePupils: di<PupilProxyManager>().allPupils,
        ),
      ),
    );

    if (result != null) {
      onPupilIdsChanged(result);
    }
  }

  void _removePupil(int pupilId) {
    final updatedPupilIds = List<int>.from(selectedPupilIds)..remove(pupilId);
    onPupilIdsChanged(updatedPupilIds);
  }
}
