import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/_credit/credit_helper_functions.dart';

/// Stats row for credit list search bar. Watches [filteredPupils] for list
/// changes and merges all individual [PupilProxy] listenables so the stats
/// rebuild when any pupil's credit changes.
class CreditListSearchBarStats extends WatchingWidget {
  final ValueListenable<List<PupilProxy>> filteredPupils;

  const CreditListSearchBarStats({super.key, required this.filteredPupils});

  @override
  Widget build(BuildContext context) {
    final pupils = watch(filteredPupils).value;
    watch(Listenable.merge(pupils));

    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.people_alt_rounded, color: AppColors.backgroundColor),
            const Gap(10),
            Text(
              pupils.length.toString(),
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const Gap(10),
            Text(
              'BIP:',
              style: TextStyle(
                fontSize: 13,
                color: AppColors.backgroundColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Gap(10),
            Text(
              CreditHelper.totalGeneratedCredit(pupils).toString(),
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const Gap(10),
            Text(
              'in Umlauf: ',
              style: TextStyle(
                fontSize: 13,
                color: AppColors.backgroundColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Gap(10),
            Text(
              CreditHelper.totalFluidCredit(pupils).toString(),
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
