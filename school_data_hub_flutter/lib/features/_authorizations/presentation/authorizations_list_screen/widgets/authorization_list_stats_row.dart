import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/_authorizations/domain/authorization_helper_functions.dart';

Widget authorizationStatsRow(Authorization authorization) {
  final Map<String, int> stats = AuthorizationHelper.authorizationStats(
    authorization,
  );
  final int pupilsInList =
      (stats['yes'] ?? 0) + (stats['no'] ?? 0) + (stats['null'] ?? 0);
  return Builder(
    builder: (context) {
      final style = Style.of(context);
      final boldStat = context.typography.title.withColor(
        style.colors.foreground,
      );
      return Row(
        children: [
          Icon(Icons.people_alt_rounded, color: style.colors.accent),
          const Gap(10),
          Text(pupilsInList.toString(), style: boldStat),
          const Gap(10),
          const Icon(Icons.close, color: Color(0xFFF44336)),
          const Gap(5),
          Text(stats['no'].toString(), style: boldStat),
          const Gap(10),
          const Icon(Icons.done, color: Color(0xFF4CAF50)),
          const Gap(5),
          Text(stats['yes'].toString(), style: boldStat),
          const Gap(10),
          Icon(Icons.question_mark_rounded, color: style.colors.accent),
          const Gap(5),
          Text(stats['null'].toString(), style: boldStat),
          const Gap(10),
          Icon(Icons.create, color: style.colors.accent),
          const Gap(5),
          Text(stats['comment'].toString(), style: boldStat),
        ],
      );
    },
  );
}
