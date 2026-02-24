import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_flutter/common/domain/filters/filters_state_manager.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_sliver_list.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_sliver_search_app_bar.dart';
import 'package:school_data_hub_flutter/features/learning/competence/presentation/pupil_list_learning_page/widgets/learning_list_card/learning_list_card.dart';
import 'package:school_data_hub_flutter/features/learning/competence/presentation/pupil_list_learning_page/widgets/pupil_list_learning_bottom_navbar.dart';
import 'package:school_data_hub_flutter/features/learning/competence/presentation/pupil_list_learning_page/widgets/pupil_list_learning_search_bar/_pupil_list_learning_search_bar.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_proxy_manager.dart';

class PupilListLearningPage extends WatchingWidget {
  const PupilListLearningPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool filtersOn = watchValue((FiltersStateManager x) => x.filtersActive);
    // These come from the PupilFilterManager
    List<PupilProxy> pupils = watchValue((PupilsFilter x) => x.filteredPupils);

    return Scaffold(
      backgroundColor: AppColors.canvasColor,
      appBar: const GenericAppBar(
        iconData: Icons.lightbulb_rounded,
        title: 'Lernen',
      ),
      body: RefreshIndicator(
        onRefresh: () async => di<PupilProxyManager>().updatePupilList(pupils),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: CustomScrollView(
              slivers: [
                GenericSliverSearchAppBar(
                  height: 180,
                  title: PupilListLearningSearchBar(filtersOn: filtersOn),
                ),
                GenericSliverListWithEmptyListCheck(
                  items: pupils,
                  itemBuilder: (_, pupil) => LearningListCard(pupil),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: PupilListLearningBottomNavBar(filtersOn: filtersOn),
    );
  }
}
