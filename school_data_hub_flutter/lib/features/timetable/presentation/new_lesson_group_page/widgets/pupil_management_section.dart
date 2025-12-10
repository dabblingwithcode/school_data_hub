import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_proxy_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/select_pupils_list_page/select_pupils_list_page.dart';
import 'package:school_data_hub_flutter/features/timetable/domain/timetable_manager.dart';
import 'package:watch_it/watch_it.dart';

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
    final pupils = di<PupilProxyManager>().allPupils;

    // Get selected pupils
    final selectedPupils = pupils
        .where((pupil) => selectedPupilIds.contains(pupil.pupilId))
        .toList();

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Schüler in dieser Klasse',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Row(
                  children: [
                    if (selectedPupilIds.isNotEmpty)
                      Text(
                        '${selectedPupilIds.length} ausgewählt',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    const Gap(8),
                    ElevatedButton.icon(
                      onPressed: () => _selectPupils(context),
                      icon: const Icon(Icons.people, size: 18),
                      label: const Text('Schüler auswählen'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Gap(12),
            if (selectedPupils.isEmpty)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.grey[600]),
                    const Gap(8),
                    Expanded(
                      child: Text(
                        'Keine Schüler ausgewählt. Klicken Sie auf "Schüler auswählen", um Schüler zu dieser Klasse hinzuzufügen.',
                        style: TextStyle(color: Colors.grey[600]),
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
                      const Gap(8),
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
      ),
    );
  }

  Widget _buildPupilCard(BuildContext context, PupilProxy pupil) {
    final fullName = '${pupil.firstName} ${pupil.lastName}'.trim();
    final initial = fullName.isNotEmpty ? fullName[0].toUpperCase() : '?';

    return Card(
      margin: const EdgeInsets.only(bottom: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: Text(
            initial,
            style: const TextStyle(
              color: Colors.white,
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
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
          onPressed: () => _removePupil(pupil.pupilId),
          tooltip: 'Schüler entfernen',
        ),
      ),
    );
  }

  void _selectPupils(BuildContext context) async {
    final result = await Navigator.of(context).push<List<int>>(
      MaterialPageRoute(
        builder: (context) => SelectPupilsListPage(
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
