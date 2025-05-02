import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/theme/app_colors.dart';
import 'package:schuldaten_hub/features/authorizations/domain/models/authorization.dart';
import 'package:schuldaten_hub/features/authorizations/domain/authorization_helper_functions.dart';

Widget authorizationStatsRow(Authorization authorization) {
  final Map<String, int> stats = AuthorizationHelper.authorizationStats(
    authorization,
  );
  final int pupilsInList =
      (stats['yes'] ?? 0) + (stats['no'] ?? 0) + (stats['null'] ?? 0);
  return Row(
    children: [
      const Icon(
        Icons.people_alt_rounded,
        color: AppColors.backgroundColor,
      ),
      const Gap(10),
      Text(
        pupilsInList.toString(),
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      const Gap(10),
      const Icon(
        Icons.close,
        color: Colors.red,
      ),
      const Gap(5),
      Text(
        stats['no'].toString(),
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      const Gap(10),
      const Icon(
        Icons.done,
        color: Colors.green,
      ),
      const Gap(5),
      Text(
        stats['yes'].toString(),
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      const Gap(10),
      const Icon(
        Icons.question_mark_rounded,
        color: AppColors.accentColor,
      ),
      const Gap(5),
      Text(
        stats['null'].toString(),
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      const Gap(10),
      const Icon(
        Icons.create,
        color: AppColors.backgroundColor,
      ),
      const Gap(5),
      Text(
        stats['comment'].toString(),
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    ],
  );
}
