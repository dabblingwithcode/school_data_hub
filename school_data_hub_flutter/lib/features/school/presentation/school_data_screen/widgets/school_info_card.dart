import 'package:flutter/material.dart' show Icons;
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/card_box.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';

class SchoolInfoCard extends StatelessWidget {
  final SchoolData schoolData;

  const SchoolInfoCard({super.key, required this.schoolData});

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);

    return CardBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.school, color: style.colors.accent),
              const Gap(8),
              Text('Schulinformationen', style: context.typography.title),
            ],
          ),
          const Gap(16),
          _buildInfoRow(context, 'Name', schoolData.name),
          const Gap(8),
          _buildInfoRow(context, 'Offizieller Name', schoolData.officialName),
          const Gap(8),
          _buildInfoRow(context, 'Adresse', schoolData.address),
          const Gap(8),
          _buildInfoRow(context, 'Schulnummer', schoolData.schoolNumber),
        ],
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text('$label:', style: context.typography.body.bold),
        ),
        const Gap(8),
        Expanded(child: Text(value, style: context.typography.body)),
      ],
    );
  }
}
