import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/domain/models/enums.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/filter_button.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/show_generic_bottom_sheet.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/_credit/credit_helper_functions.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/_credit/credit_list_page/widgets/credit_filter_bottom_sheet.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/widgets/pupil_search_text_field.dart';
import 'package:watch_it/watch_it.dart';

class CreditListSearchBar extends WatchingWidget {
  final List<PupilProxy> pupils;

  const CreditListSearchBar({required this.pupils, super.key});

  @override
  Widget build(BuildContext context) {
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
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
                    const Gap(10),
                    const Text(
                      'BIP:',
                      style: TextStyle(
                          fontSize: 13,
                          color: AppColors.backgroundColor,
                          fontWeight: FontWeight.bold),
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
                    const Text(
                      'in Umlauf: ',
                      style: TextStyle(
                          fontSize: 13,
                          color: AppColors.backgroundColor,
                          fontWeight: FontWeight.bold),
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
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
            child: Row(
              children: [
                Expanded(
                  child: PupilSearchTextField(
                      searchType: SearchType.pupil,
                      hintText: 'Schüler/in suchen',
                      refreshFunction: di<PupilsFilter>().refreshs),
                ),
                const Gap(5),
                FilterButton(
                  isSearchBar: true,
                  showBottomSheetFunction: () => showGenericBottomSheet(
                      context, const CreditFilterBottomSheet()),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
