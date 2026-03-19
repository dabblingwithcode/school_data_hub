import 'dart:io';

import 'package:flutter/material.dart' show Icons, TextFormField, TextInputType;
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/button.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/card_box.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/confirmation_popup.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/spinner.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/toast.dart';
import 'package:school_data_hub_flutter/features/school/domain/school_data_manager.dart';

class SchoolDataFormScreen extends WatchingWidget {
  const SchoolDataFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final schoolDataManager = di<SchoolDataMainManager>();

    // Watch form data
    final formData = watchValue((SchoolDataMainManager x) => x.formData);
    final logoImage = watchValue((SchoolDataMainManager x) => x.logoImage);
    final sealImage = watchValue(
      (SchoolDataMainManager x) => x.officialSealImage,
    );
    final isSaving = watchValue((SchoolDataMainManager x) => x.isSaving);

    return CardBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Grundinformationen', style: context.typography.subtitle),
          const Gap(16),
          _buildTextField(
            context: context,
            label: 'Name *',
            value: formData?.name ?? '',
            onChanged: (value) =>
                schoolDataManager.updateFormField(name: value),
          ),
          const Gap(16),
          _buildTextField(
            context: context,
            label: 'Offizieller Name *',
            value: formData?.officialName ?? '',
            onChanged: (value) =>
                schoolDataManager.updateFormField(officialName: value),
          ),
          const Gap(16),
          _buildTextField(
            context: context,
            label: 'Zusatzname',
            value: formData?.extraName ?? '',
            onChanged: (value) =>
                schoolDataManager.updateFormField(extraName: value),
          ),
          const Gap(16),
          _buildTextField(
            context: context,
            label: 'Adresse *',
            value: formData?.address ?? '',
            onChanged: (value) =>
                schoolDataManager.updateFormField(address: value),
            maxLines: 2,
          ),
          const Gap(16),
          _buildTextField(
            context: context,
            label: 'PLZ *',
            value: formData?.zipCode ?? '',
            onChanged: (value) =>
                schoolDataManager.updateFormField(zipCode: value),
          ),
          const Gap(16),
          _buildTextField(
            context: context,
            label: 'Stadt *',
            value: formData?.city ?? '',
            onChanged: (value) =>
                schoolDataManager.updateFormField(city: value),
          ),
          const Gap(16),
          _buildTextField(
            context: context,
            label: 'Schulnummer *',
            value: formData?.schoolNumber ?? '',
            onChanged: (value) =>
                schoolDataManager.updateFormField(schoolNumber: value),
          ),
          const Gap(16),
          _buildTextField(
            context: context,
            label: 'Schulleitung',
            value: formData?.principalName ?? '',
            onChanged: (value) =>
                schoolDataManager.updateFormField(principalName: value),
          ),
          Gap(Style.spacing.xl),
          Text('Kontaktinformationen', style: context.typography.subtitle),
          const Gap(16),
          _buildTextField(
            context: context,
            label: 'Telefon *',
            value: formData?.telephoneNumber ?? '',
            onChanged: (value) =>
                schoolDataManager.updateFormField(telephoneNumber: value),
            keyboardType: TextInputType.phone,
          ),
          const Gap(16),
          _buildTextField(
            context: context,
            label: 'E-Mail *',
            value: formData?.email ?? '',
            onChanged: (value) =>
                schoolDataManager.updateFormField(email: value),
            keyboardType: TextInputType.emailAddress,
          ),
          const Gap(16),
          _buildTextField(
            context: context,
            label: 'Website *',
            value: formData?.website ?? '',
            onChanged: (value) =>
                schoolDataManager.updateFormField(website: value),
            keyboardType: TextInputType.url,
          ),
          Gap(Style.spacing.xl),
          Text('Logos und Siegel', style: context.typography.subtitle),
          const Gap(16),
          _buildImageUploadSection(
            context: context,
            label: 'Schullogo',
            imageData: logoImage,
            onUpload: (file) => schoolDataManager.uploadLogo(file),
            onDelete: () => schoolDataManager.deleteLogo(),
            isSaving: isSaving,
          ),
          Gap(Style.spacing.xl),
          _buildImageUploadSection(
            context: context,
            label: 'Offizielles Dienstsiegel',
            imageData: sealImage,
            onUpload: (file) => schoolDataManager.uploadOfficialSeal(file),
            onDelete: () => schoolDataManager.deleteOfficialSeal(),
            isSaving: isSaving,
          ),
        ],
      ),
    );
  }

  Widget _buildImageUploadSection({
    required BuildContext context,
    required String label,
    required ByteData? imageData,
    required Future<void> Function(File) onUpload,
    required Future<void> Function() onDelete,
    required bool isSaving,
  }) {
    final style = Style.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: context.typography.body.bold),
        const Gap(8),
        Row(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                border: Border.all(color: style.colors.border),
                borderRadius: BorderRadius.circular(Style.radii.small),
                color: style.colors.surfaceContainer,
              ),
              child: imageData != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(Style.radii.small),
                      child: Image.memory(
                        imageData.buffer.asUint8List(),
                        fit: BoxFit.contain,
                      ),
                    )
                  : Icon(
                      Icons.image,
                      color: style.colors.mutedForeground,
                      size: 40,
                    ),
            ),
            const Gap(16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Button.small(
                  onPressed: isSaving
                      ? null
                      : () async {
                          final picker = ImagePicker();
                          final XFile? image = await picker.pickImage(
                            source: ImageSource.gallery,
                          );

                          if (image != null) {
                            try {
                              await onUpload(File(image.path));
                              if (context.mounted) {
                                Toast.show(
                                  context: context,
                                  message: 'Bildupload erfolgreich',
                                  type: ToastType.success,
                                );
                              }
                            } catch (e) {
                              if (context.mounted) {
                                Toast.show(
                                  context: context,
                                  message: 'Fehler beim Upload: $e',
                                  type: ToastType.error,
                                );
                              }
                            }
                          }
                        },
                  icon: isSaving
                      ? SizedBox(
                          width: 18,
                          height: 18,
                          child: Spinner(color: style.colors.foreground),
                        )
                      : const Icon(Icons.upload),
                  label: isSaving ? 'Lädt...' : 'Bild hochladen',
                ),
                if (imageData != null) ...[
                  const Gap(8),
                  Button.small(
                    onPressed: isSaving
                        ? null
                        : () async {
                            ConfirmationPopup.show(
                              context: context,
                              title: 'Bild löschen?',
                              description:
                                  'Möchten Sie dieses Bild wirklich löschen?',
                              confirmLabel: 'Löschen',
                              cancelLabel: 'Abbrechen',
                              destructive: true,
                              onConfirm: () async {
                                try {
                                  await onDelete();
                                  if (context.mounted) {
                                    Toast.show(
                                      context: context,
                                      message: 'Bild erfolgreich gelöscht',
                                      type: ToastType.success,
                                    );
                                  }
                                } catch (e) {
                                  if (context.mounted) {
                                    Toast.show(
                                      context: context,
                                      message: 'Fehler beim Löschen: $e',
                                      type: ToastType.error,
                                    );
                                  }
                                }
                              },
                            );
                          },
                    icon: const Icon(Icons.delete),
                    label: 'Bild löschen',
                    variant: ButtonVariant.destructive,
                  ),
                ],
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTextField({
    required BuildContext context,
    required String label,
    required String value,
    required ValueChanged<String> onChanged,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: context.typography.body.bold),
        const Gap(4),
        TextFormField(
          initialValue: value,
          onChanged: onChanged,
          keyboardType: keyboardType,
          maxLines: maxLines,
          decoration: AppStyles.textFieldDecoration(labelText: label),
        ),
      ],
    );
  }
}
