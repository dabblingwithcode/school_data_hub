import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/features/books/domain/book_helper.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupils_filter.dart';

class PupilBookLendingsInfos extends WatchingWidget {
  const PupilBookLendingsInfos({super.key});

  @override
  Widget build(BuildContext context) {
    final pupils = watchValue((PupilsFilter m) => m.filteredPupils);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
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
        const Gap(15),
        const Text(
          'gelesen: ',
          style: TextStyle(color: Colors.black, fontSize: 13),
        ),
        const Gap(5),
        Text(
          (BookHelpers.totalPupilBookLendings()).toString(),
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        const Gap(15),
        const Text(
          'ausgeliehen: ',
          style: TextStyle(color: Colors.black, fontSize: 13),
        ),
        const Gap(5),
        Text(
          (BookHelpers.totalOpenPupilBookLendings()).toString(),
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}
