import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_sliver_list.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_sliver_search_app_bar.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/filters/pupils_filter.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/credit/credit_list_page/widgets/credit_list_card.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/credit/credit_list_page/widgets/credit_list_page_bottom_navbar.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/credit/credit_list_page/widgets/credit_list_searchbar.dart';
import 'package:watch_it/watch_it.dart';

class CreditListPage extends WatchingWidget {
  const CreditListPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<PupilProxy> pupils = watchValue((PupilsFilter x) => x.filteredPupils);
    int userCredit =
        watchPropertyValue((HubSessionManager x) => x.user)!.credit;

    return Scaffold(
      backgroundColor: AppColors.canvasColor,
      appBar: GenericAppBar(
          iconData: Icons.credit_card, title: 'Guthaben: $userCredit'),
      body: RefreshIndicator(
        onRefresh: () async => di<PupilManager>().fetchAllPupils(),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: CustomScrollView(
              slivers: [
                const SliverGap(5),
                GenericSliverSearchAppBar(
                  height: 110,
                  title: CreditListSearchBar(pupils: pupils),
                ),
                GenericSliverListWithEmptyListCheck(
                    items: pupils,
                    itemBuilder: (_, pupil) => CreditListCard(pupil)),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const CreditListPageBottomNavBar(),
    );
  }
}
