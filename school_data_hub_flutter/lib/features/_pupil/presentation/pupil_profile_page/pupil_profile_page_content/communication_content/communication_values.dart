import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/core/models/datetime_extensions.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/pupil_proxy_helper.dart';

class CommunicationValues extends StatelessWidget {
  final CommunicationSkills? communicationSkills;
  const CommunicationValues({required this.communicationSkills, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.hearing),
              const Gap(10),
              Text(
                PupilProxyHelper.communicationPredicate(
                  communicationSkills?.understanding,
                ),
                style: context.typography.subtitle.withColor(
                  Style.of(context).colors.interactive,
                ),
              ),
            ],
          ),
          const Gap(10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.chat_bubble_outline_rounded),
              const Gap(10),
              Text(
                PupilProxyHelper.communicationPredicate(
                  communicationSkills?.speaking,
                ),
                style: context.typography.subtitle.withColor(
                  Style.of(context).colors.interactive,
                ),
              ),
            ],
          ),
          const Gap(5),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.book),
              const Gap(10),
              Text(
                PupilProxyHelper.communicationPredicate(
                  communicationSkills?.reading,
                ),
                style: context.typography.subtitle.withColor(
                  Style.of(context).colors.interactive,
                ),
              ),
            ],
          ),
          const Gap(5),
          if (communicationSkills != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Erstellt von ${communicationSkills!.createdBy} am ${communicationSkills!.createdAt.formatDateForUser()}',
                  style: context.typography.bodySmall.withColor(
                    Style.of(context).colors.mutedForeground,
                  ),
                ),
              ],
            ),
          const Gap(5),
        ],
      ),
    );
  }
}
