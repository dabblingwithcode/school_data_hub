import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/features/school/domain/school_data_manager.dart';
import 'package:watch_it/watch_it.dart';

class SchoolDataForm extends WatchingWidget {
  const SchoolDataForm({super.key});

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

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Grundinformationen', style: AppStyles.subtitle),
            const Gap(16),
            _buildTextField(
              label: 'Name',
              value: formData?.name ?? '',
              onChanged: (value) =>
                  schoolDataManager.updateFormField(name: value),
            ),
            const Gap(16),
            _buildTextField(
              label: 'Offizieller Name',
              value: formData?.officialName ?? '',
              onChanged: (value) =>
                  schoolDataManager.updateFormField(officialName: value),
            ),
            const Gap(16),
            _buildTextField(
              label: 'Adresse',
              value: formData?.address ?? '',
              onChanged: (value) =>
                  schoolDataManager.updateFormField(address: value),
              maxLines: 2,
            ),
            const Gap(16),
            _buildTextField(
              label: 'Schulnummer',
              value: formData?.schoolNumber ?? '',
              onChanged: (value) =>
                  schoolDataManager.updateFormField(schoolNumber: value),
            ),
            const Gap(24),
            const Text('Kontaktinformationen', style: AppStyles.subtitle),
            const Gap(16),
            _buildTextField(
              label: 'Telefon',
              value: formData?.telephoneNumber ?? '',
              onChanged: (value) =>
                  schoolDataManager.updateFormField(telephoneNumber: value),
              keyboardType: TextInputType.phone,
            ),
            const Gap(16),
            _buildTextField(
              label: 'E-Mail',
              value: formData?.email ?? '',
              onChanged: (value) =>
                  schoolDataManager.updateFormField(email: value),
              keyboardType: TextInputType.emailAddress,
            ),
            const Gap(16),
            _buildTextField(
              label: 'Website',
              value: formData?.website ?? '',
              onChanged: (value) =>
                  schoolDataManager.updateFormField(website: value),
              keyboardType: TextInputType.url,
            ),
            const Gap(24),
            const Text('Logos und Siegel', style: AppStyles.subtitle),
            const Gap(16),
            _buildImageUploadSection(
              context: context,
              label: 'Schullogo',
              imageData: logoImage,
              onUpload: (file) => schoolDataManager.uploadLogo(file),
              isSaving: isSaving,
            ),
            const Gap(24),
            _buildImageUploadSection(
              context: context,
              label: 'Offizielles Dienstsiegel',
              imageData: sealImage,
              onUpload: (file) => schoolDataManager.uploadOfficialSeal(file),
              isSaving: isSaving,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageUploadSection({
    required BuildContext context,
    required String label,
    required ByteData? imageData,
    required Future<void> Function(File) onUpload,
    required bool isSaving,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        const Gap(8),
        Row(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey.shade50,
              ),
              child: imageData != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.memory(
                        imageData.buffer.asUint8List(),
                        fit: BoxFit.contain,
                      ),
                    )
                  : const Icon(Icons.image, color: Colors.grey, size: 40),
            ),
            const Gap(16),
            ElevatedButton.icon(
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
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Bildupload erfolgreich'),
                                backgroundColor: Colors.green,
                              ),
                            );
                          }
                        } catch (e) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Fehler beim Upload: $e'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        }
                      }
                    },
              icon: isSaving
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : const Icon(Icons.upload),
              label: Text(isSaving ? 'Lädt...' : 'Bild hochladen'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.interactiveColor,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required String value,
    required ValueChanged<String> onChanged,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
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
