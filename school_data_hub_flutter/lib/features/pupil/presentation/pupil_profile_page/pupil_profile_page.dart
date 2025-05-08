import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar_layouts.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/pupil_manager.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/widgets/pupil_profile_bottom_navbar.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/widgets/pupil_profile_head_widget.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/widgets/pupil_profile_navigation.dart';
import 'package:school_data_hub_flutter/features/pupil/presentation/pupil_profile_page/widgets/pupil_profile_page_content/pupil_profile_page_content.dart';
import 'package:watch_it/watch_it.dart';

final _pupilManager = di<PupilManager>();

class PupilProfilePage extends WatchingWidget {
  final PupilProxy pupil;

  const PupilProfilePage({required this.pupil, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.canvasColor,
      body: RefreshIndicator(
        onRefresh: () async => _pupilManager.updatePupilData(pupil.pupilId),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 5.0, top: 5, right: 5),
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
                            systemOverlayStyle: const SystemUiOverlayStyle(
                                statusBarColor: AppColors.backgroundColor),
                            pinned: false,
                            floating: true,
                            scrolledUnderElevation: null,
                            automaticallyImplyLeading: false,
                            leading: null,
                            backgroundColor: AppColors.canvasColor,
                            collapsedHeight: 140,
                            expandedHeight: 140.0,
                            stretch: false,
                            elevation: 0,
                            flexibleSpace: FlexibleSpaceBar(
                              expandedTitleScale: 1,
                              collapseMode: CollapseMode.none,
                              titlePadding: const EdgeInsets.only(
                                  left: 5, top: 5, right: 5, bottom: 5),
                              title: PupilProfileHeadWidget(passedPupil: pupil),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: PupilProfilePageContent(
                              pupil: pupil,
                            ),
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
      ),
      bottomNavigationBar: const BottomNavBarProfileLayout(
          bottomNavBar: PupilProfileBottomNavBar()),
    );
  }
}
