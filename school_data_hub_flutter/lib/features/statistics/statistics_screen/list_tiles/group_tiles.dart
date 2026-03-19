import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/statistics/statistics_screen/controller/statistics.dart';
import 'package:school_data_hub_flutter/features/statistics/statistics_screen/list_tiles/group_card.dart';

RenderObjectWidget groupTiles(
  BuildContext context,
  StatisticsController controller,
  List<PupilProxy> group,
) {
  if (group.isEmpty) {
    return const SizedBox.shrink();
  }
  final groupString = group.first.group;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Text(groupString, style: context.typography.subtitle.bold),
          const Gap(10),
          Text('insgesamt:', style: context.typography.subtitle),
          const Gap(10),
          Text(
            group.length.toString(),
            style: context.typography.subtitle.bold,
          ),
          const Gap(20),
          Text('davon OGS:', style: context.typography.subtitle),
          const Gap(10),
          Text(
            controller.pupilsInOGS(group).length.toString(),
            style: context.typography.subtitle.bold,
          ),
        ],
      ),
      const Gap(10),
      statisticsGroupCard(context, controller, group),
    ],
  );
}
