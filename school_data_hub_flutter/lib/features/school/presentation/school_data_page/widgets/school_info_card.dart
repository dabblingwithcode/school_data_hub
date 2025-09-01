import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';

class SchoolInfoCard extends StatelessWidget {
  final SchoolData schoolData;

  const SchoolInfoCard({super.key, required this.schoolData});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.school, color: AppColors.backgroundColor),
                const Gap(8),
                const Text('Schulinformationen', style: AppStyles.title),
              ],
            ),
            const Gap(16),
            _buildInfoRow('Name', schoolData.name),
            const Gap(8),
            _buildInfoRow('Offizieller Name', schoolData.officialName),
            const Gap(8),
            _buildInfoRow('Adresse', schoolData.address),
            const Gap(8),
            _buildInfoRow('Schulnummer', schoolData.schoolNumber),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            '$label:',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ),
        const Gap(8),
        Expanded(child: Text(value, style: const TextStyle(fontSize: 14))),
      ],
    );
  }
}
