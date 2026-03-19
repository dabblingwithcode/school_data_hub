import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/app_header.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/button.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/toast.dart';
import 'package:school_data_hub_flutter/features/school/domain/school_data_manager.dart';
import 'package:school_data_hub_flutter/features/school/presentation/edit_school_data_screen/widgets/school_data_form_screen.dart';

class EditSchoolDataScreen extends WatchingWidget {
  const EditSchoolDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final schoolDataManager = di<SchoolDataMainManager>();

    // Watch form states
    final isFormValid = watchValue((SchoolDataMainManager x) => x.isFormValid);
    final isFormDirty = watchValue((SchoolDataMainManager x) => x.isFormDirty);
    final isSaving = watchValue((SchoolDataMainManager x) => x.isSaving);

    // Initialize form on first build
    callOnce((context) {
      schoolDataManager.initializeForm();
    });

    return Scaffold(
      backgroundColor: style.colors.canvas,
      appBar: const AppHeader(
        iconData: Icons.edit,
        title: 'Schulinformationen bearbeiten',
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(Style.spacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Schulinformationen bearbeiten',
                        style: context.typography.title,
                      ),
                    ),
                    if (isFormDirty)
                      Button.small(
                        onPressed: () {
                          schoolDataManager.resetForm();
                        },
                        label: 'Zurücksetzen',
                        variant: ButtonVariant.ghost,
                      ),
                  ],
                ),
                const Gap(8),
                Text(
                  'Bearbeiten Sie die Informationen Ihrer Schule. Felder mit * sind Pflichtfelder.',
                  style: context.typography.body.muted(context),
                ),

                const SchoolDataFormScreen(),
                Gap(Style.spacing.xl),
                Row(
                  children: [
                    Expanded(
                      child: Button(
                        onPressed: () => Navigator.of(context).pop(),
                        label: 'ABBRECHEN',
                        variant: ButtonVariant.secondary,
                      ),
                    ),
                    const Gap(16),
                    Expanded(
                      child: Button(
                        onPressed: isFormValid && !isSaving
                            ? () async {
                                try {
                                  await schoolDataManager.saveSchoolData();
                                  if (context.mounted) {
                                    Navigator.of(context).pop();
                                  }
                                } catch (e) {
                                  if (context.mounted) {
                                    Toast.show(
                                      context: context,
                                      message: 'Fehler beim Speichern: $e',
                                      type: ToastType.error,
                                    );
                                  }
                                }
                              }
                            : null,
                        loading: isSaving,
                        label: 'SPEICHERN',
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
