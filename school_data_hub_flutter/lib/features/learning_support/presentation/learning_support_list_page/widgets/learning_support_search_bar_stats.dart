import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
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
    final pupils = watch(filteredPupils).value;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.canvasColor,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Column(
        children: [
          const Gap(5),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Icon(
                      Icons.people_alt_rounded,
                      color: AppColors.backgroundColor,
                    ),
                    const Gap(10),
                    Text(
                      pupils.length.toString(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const Gap(15),
                    const Text(
                      'Ebene 1: ',
                      style: TextStyle(color: Colors.black, fontSize: 13),
                    ),
                    const Gap(5),
                    Text(
                      (LearningSupportHelper.developmentPlan1Pupils(pupils))
                          .toString(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const Gap(15),
                    const Text(
                      '2: ',
                      style: TextStyle(color: Colors.black, fontSize: 13),
                    ),
                    const Gap(5),
                    Text(
                      (LearningSupportHelper.developmentPlan2Pupils(pupils))
                          .toString(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const Gap(15),
                    const Text(
                      '3: ',
                      style: TextStyle(color: Colors.black, fontSize: 13),
                    ),
                    const Gap(5),
                    Text(
                      (LearningSupportHelper.developmentPlan3Pupils(pupils))
                          .toString(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
