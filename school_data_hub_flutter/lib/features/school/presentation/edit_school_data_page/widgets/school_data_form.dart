import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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
              onChanged: (value) => schoolDataManager.updateFormField(name: value),
            ),
            const Gap(16),
            _buildTextField(
              label: 'Offizieller Name',
              value: formData?.officialName ?? '',
              onChanged: (value) => schoolDataManager.updateFormField(officialName: value),
            ),
            const Gap(16),
            _buildTextField(
              label: 'Adresse',
              value: formData?.address ?? '',
              onChanged: (value) => schoolDataManager.updateFormField(address: value),
              maxLines: 2,
            ),
            const Gap(16),
            _buildTextField(
              label: 'Schulnummer',
              value: formData?.schoolNumber ?? '',
              onChanged: (value) => schoolDataManager.updateFormField(schoolNumber: value),
            ),
            const Gap(24),
            const Text('Kontaktinformationen', style: AppStyles.subtitle),
            const Gap(16),
            _buildTextField(
              label: 'Telefon',
              value: formData?.telephoneNumber ?? '',
              onChanged: (value) => schoolDataManager.updateFormField(telephoneNumber: value),
              keyboardType: TextInputType.phone,
            ),
            const Gap(16),
            _buildTextField(
              label: 'E-Mail',
              value: formData?.email ?? '',
              onChanged: (value) => schoolDataManager.updateFormField(email: value),
              keyboardType: TextInputType.emailAddress,
            ),
            const Gap(16),
            _buildTextField(
              label: 'Website',
              value: formData?.website ?? '',
              onChanged: (value) => schoolDataManager.updateFormField(website: value),
              keyboardType: TextInputType.url,
            ),
          ],
        ),
      ),
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
