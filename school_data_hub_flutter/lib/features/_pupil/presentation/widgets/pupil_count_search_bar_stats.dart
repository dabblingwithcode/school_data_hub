import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';

/// Shows icon + count for a listenable list of pupils. Use as [statsWidget] in [GenericListSearchBarWithStats].
class PupilCountSearchBarStats extends WatchingWidget {
  final ValueListenable<List<PupilProxy>> filteredPupils;

  const PupilCountSearchBarStats({
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
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.people_alt_rounded,
                  color: AppColors.backgroundColor,
                ),
                const Gap(5),
                Text(
                  pupils.length.toString(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
