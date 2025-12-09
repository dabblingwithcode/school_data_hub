import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/domain/models/enums.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/features/learning/presentation/widgets/pupil_learning_content_expansion_tile_nav_bar.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/learning_support_helper.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/learning_support_list_page/widgets/learning_support_list_filter_bottom_sheet.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/widgets/pupil_search_text_field.dart';
import 'package:watch_it/watch_it.dart';

class PupilCompetenceListSearchBar extends StatelessWidget {
  final List<PupilProxy> pupils;
  final bool filtersOn;
  const PupilCompetenceListSearchBar({
    required this.filtersOn,
    required this.pupils,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.canvasColor,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Gap(5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: SizedBox(
              height: 30,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                      (LearningSupportHelper.developmentPlan1Pupils(
                        pupils,
                      )).toString(),
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
                      (LearningSupportHelper.developmentPlan2Pupils(
                        pupils,
                      )).toString(),
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
                      (LearningSupportHelper.developmentPlan3Pupils(
                        pupils,
                      )).toString(),
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
                    refreshFunction: di<PupilsFilter>().refreshs,
                  ),
                ),
                InkWell(
                  onTap: () => showLearningSupportFilterBottomSheet(context),
                  onLongPress: () => di<PupilsFilter>().resetFilters(),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(
                      Icons.filter_list,
                      color: filtersOn ? Colors.deepOrange : Colors.grey,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const PupilLearningContentNavBar(),
        ],
      ),
    );
  }
}
