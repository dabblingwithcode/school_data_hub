import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/learning_support_helper.dart';

class LearningSupportSearchBarStats extends WatchingWidget {
  final ValueListenable<List<PupilProxy>> filteredPupils;

  const LearningSupportSearchBarStats({
    required this.filteredPupils,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final pupils = watch(filteredPupils).value;
    return Container(
      decoration: BoxDecoration(
        color: style.colors.canvas,
        borderRadius: BorderRadius.circular(Style.radii.small),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Gap(Style.spacing.xs),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Style.spacing.md),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                  children: [
                    Icon(
                      Icons.people_alt_rounded,
                      color: style.colors.accent,
                    ),
                    Gap(Style.spacing.md),
                    Text(
                      pupils.length.toString(),
                      style: context.typography.title,
                    ),
                    Gap(Style.spacing.lg),
                    Text(
                      'Ebene 1: ',
                      style: context.typography.bodySmall.withColor(style.colors.foreground),
                    ),
                    Gap(Style.spacing.xs),
                    Text(
                      (LearningSupportHelper.developmentPlan1Pupils(pupils))
                          .toString(),
                      style: context.typography.title,
                    ),
                    Gap(Style.spacing.lg),
                    Text(
                      '2: ',
                      style: context.typography.bodySmall.withColor(style.colors.foreground),
                    ),
                    Gap(Style.spacing.xs),
                    Text(
                      (LearningSupportHelper.developmentPlan2Pupils(pupils))
                          .toString(),
                      style: context.typography.title,
                    ),
                    Gap(Style.spacing.lg),
                    Text(
                      '3: ',
                      style: context.typography.bodySmall.withColor(style.colors.foreground),
                    ),
                    Gap(Style.spacing.xs),
                    Text(
                      (LearningSupportHelper.developmentPlan3Pupils(pupils))
                          .toString(),
                      style: context.typography.title,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
