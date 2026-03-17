import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar/bottom_nav_bar_layouts.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/pupil_profile_page/pupil_profile_page_content/pupil_profile_page_content.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/pupil_profile_page/widgets/pupil_profile_bottom_navbar.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/pupil_profile_page/widgets/pupil_profile_heading_card.dart';
import 'package:school_data_hub_flutter/features/_pupil/presentation/pupil_profile_page/widgets/pupil_profile_navigation.dart';

class PupilProfilePage extends StatelessWidget {
  final PupilProxy pupil;

  const PupilProfilePage({required this.pupil, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pupilProfileBackgroundColor,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            children: [
              Expanded(
                child: NestedScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  headerSliverBuilder: (context, innerBoxIsScrolled) => [
                    SliverOverlapAbsorber(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                        context,
                      ),
                      sliver: SliverAppBar(
                        systemOverlayStyle: const SystemUiOverlayStyle(
                          statusBarColor: Color(0x00000000),
                        ),
                        pinned: true,
                        floating: false,
                        snap: false,
                        scrolledUnderElevation: null,
                        automaticallyImplyLeading: false,
                        leading: null,
                        backgroundColor: Colors.transparent,
                        toolbarHeight: 60,
                        expandedHeight: 105,
                        stretch: false,
                        elevation: 0,
                        flexibleSpace: PupilProfileHeadingCard(pupil: pupil),
                      ),
                    ),
                  ],
                  body: PupilProfilePageContent(pupil: pupil),
                ),
              ),
              PupilProfileNavigation(
                boxWidth: MediaQuery.sizeOf(context).width,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBarProfileLayout(
        bottomNavBar: PupilProfileBottomNavBar(),
      ),
    );
  }
}
