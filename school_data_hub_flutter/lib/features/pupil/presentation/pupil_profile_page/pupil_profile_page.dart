import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar_layouts.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/widgets/pupil_profile_bottom_navbar.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/widgets/pupil_profile_heading_card.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/widgets/pupil_profile_navigation.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/widgets/pupil_profile_page_content/pupil_profile_page_content.dart';
import 'package:watch_it/watch_it.dart';

class PupilProfilePage extends WatchingWidget {
  final PupilProxy pupil;

  const PupilProfilePage({required this.pupil, super.key});

  @override
  Widget build(BuildContext context) {
    final _pupilManager = di<PupilManager>();
    return Scaffold(
      backgroundColor: AppColors.pupilProfileBackgroundColor,
      body: RefreshIndicator(
        onRefresh: () async => _pupilManager.updatePupilData(pupil.pupilId),
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Column(
                children: [
                  Expanded(
                    child: CustomScrollView(
                      dragStartBehavior: DragStartBehavior.down,
                      slivers: [
                        SliverAppBar(
                          systemOverlayStyle: SystemUiOverlayStyle(
                            statusBarColor:
                                AppColors.pupilProfileBackgroundColor,
                          ),
                          pinned: false,
                          floating: true,
                          scrolledUnderElevation: null,
                          automaticallyImplyLeading: false,
                          leading: null,
                          backgroundColor:
                              AppColors.pupilProfileBackgroundColor,
                          collapsedHeight: 150,
                          expandedHeight: 150,
                          stretch: false,
                          elevation: 0,
                          flexibleSpace: FlexibleSpaceBar(
                            expandedTitleScale: 1,
                            collapseMode: CollapseMode.none,
                            titlePadding: const EdgeInsets.only(
                              left: 0,
                              top: 5,
                              right: 0,
                              bottom: 5,
                            ),
                            title: PupilProfileHeadingCard(passedPupil: pupil),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: PupilProfilePageContent(pupil: pupil),
                        ),
                        const SliverGap(60),
                      ],
                    ),
                  ),
                  PupilProfileNavigation(
                    boxWidth: MediaQuery.of(context).size.width,
                    //MediaQuery.of(context).size.width / 5,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBarProfileLayout(
        bottomNavBar: PupilProfileBottomNavBar(),
      ),
    );
  }
}
