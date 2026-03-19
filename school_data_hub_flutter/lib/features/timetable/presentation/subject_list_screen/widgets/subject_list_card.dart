import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/card_box.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';

class SubjectListCard extends StatelessWidget {
  final Subject subject;
  final VoidCallback onTap;

  const SubjectListCard({
    super.key,
    required this.subject,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);

    return CardBox(
      onTap: onTap,
      padding: EdgeInsets.all(Style.spacing.lg),
      child: Row(
        children: [
          // Color indicator
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: _parseColor(subject.color ?? '#FF5722'),
              borderRadius: BorderRadius.circular(Style.radii.small),
            ),
          ),
          Gap(Style.spacing.lg),
          // Subject details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  subject.name,
                  style: context.typography.title,
                ),
                if (subject.description != null &&
                    subject.description!.isNotEmpty) ...[
                  Gap(Style.spacing.xs),
                  Text(
                    subject.description!,
                    style: context.typography.body
                        .withColor(style.colors.mutedForeground),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
                Gap(Style.spacing.xs),
                Text(
                  'ID: ${subject.publicId}',
                  style: context.typography.bodySmall
                      .withColor(style.colors.mutedForeground),
                ),
              ],
            ),
          ),
          // Arrow icon
          Icon(
            Icons.chevron_right,
            color: style.colors.mutedForeground,
          ),
        ],
      ),
    );
  }

  Color _parseColor(String hexColor) {
    try {
      return Color(int.parse(hexColor.replaceAll('#', '0xFF')));
    } catch (e) {
      return const Color(0xFF9E9E9E);
    }
  }
}
