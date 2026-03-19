import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters_state_manager.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/common/widgets/buttons_switches/icon_toggle.dart';

class FilterHeading extends StatelessWidget {
  const FilterHeading({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('Filter', style: AppStyles.title),
        const Spacer(),
        RoundButton(
          tooltip: 'Alle Filter zurücksetzen',
          iconSize: 16,
          iconColor: const Color.fromARGB(255, 244, 92, 81),
          backgroundColor: AppColors.backgroundColor,
          onTap: () {
            di<FiltersStateManager>().resetFilters();
          },
          icon: Icons.delete_forever_rounded,
        ),
        const Gap(5),
        RoundButton(
          tooltip: 'schließen',
          iconSize: 16,
          iconColor: Colors.white,
          backgroundColor: AppColors.backgroundColor,
          onTap: () => Navigator.pop(context),
          icon: Icons.close_rounded,
        ),
      ],
    );
  }
}
