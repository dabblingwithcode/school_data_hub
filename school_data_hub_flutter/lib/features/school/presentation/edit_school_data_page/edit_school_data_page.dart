import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/features/school/domain/school_data_manager.dart';
import 'package:school_data_hub_flutter/features/school/presentation/edit_school_data_page/widgets/school_data_form.dart';
import 'package:watch_it/watch_it.dart';

class EditSchoolDataPage extends WatchingWidget {
  const EditSchoolDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    final schoolDataManager = di<SchoolDataMainManager>();

    // Watch form states
    final isFormValid = watchValue((SchoolDataMainManager x) => x.isFormValid);
    final isFormDirty = watchValue((SchoolDataMainManager x) => x.isFormDirty);
    final isSaving = watchValue((SchoolDataMainManager x) => x.isSaving);

    // Initialize form on first build
    callOnce((context) {
      schoolDataManager.initializeForm();
      // Debug the form validation
    });

    return Scaffold(
      backgroundColor: AppColors.canvasColor,
      appBar: const GenericAppBar(
        iconData: Icons.edit,
        title: 'Schulinformationen bearbeiten',
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Schulinformationen bearbeiten',
                        style: AppStyles.title,
                      ),
                    ),
                    if (isFormDirty)
                      TextButton(
                        onPressed: () {
                          schoolDataManager.resetForm();
                        },
                        child: Text(
                          'Zurücksetzen',
                          style: TextStyle(color: AppColors.backgroundColor),
                        ),
                      ),
                  ],
                ),
                const Gap(8),
                const Text(
                  'Bearbeiten Sie die Informationen Ihrer Schule. Alle Felder sind Pflichtfelder.',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const Gap(24),
                const SchoolDataForm(),
                const Gap(24),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: isFormValid && !isSaving
                            ? () async {
                                try {
                                  await schoolDataManager.saveSchoolData();
                                  if (context.mounted) {
                                    Navigator.of(context).pop();
                                  }
                                } catch (e) {
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Fehler beim Speichern: $e',
                                        ),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  }
                                }
                              }
                            : null,
                        style: AppStyles.actionButtonStyle,
                        child: isSaving
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              )
                            : const Text('Speichern'),
                      ),
                    ),
                    const Gap(16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: AppStyles.cancelButtonStyle,
                        child: const Text('Abbrechen'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
