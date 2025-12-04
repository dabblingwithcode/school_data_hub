import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/paddings.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar_layouts.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/authorizations/presentation/new_authorization_page/new_authorization_page.dart';
import 'package:watch_it/watch_it.dart';

class AuthorizationListBottomNavBar extends StatelessWidget {
  const AuthorizationListBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final _hubSessionManager = di<HubSessionManager>();
    return BottomNavBarLayout(
      bottomNavBar: BottomAppBar(
        height: 60,
        padding: const EdgeInsets.all(9),
        shape: null,
        color: AppColors.backgroundColor,
        child: IconTheme(
          data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
          child: Row(
            children: <Widget>[
              const Spacer(),
              IconButton(
                tooltip: 'zurück',
                icon: const Icon(
                  Icons.arrow_back,
                  size: 35,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              if (_hubSessionManager.isAdmin == true) ...[
                const Gap(AppPaddings.bottomNavBarButtonGap),
                IconButton(
                  tooltip: 'Neue Liste',
                  icon: const Icon(
                    Icons.add,
                    size: 35,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => const NewAuthorizationPage(),
                    ));
                  },
                ),
              ],
              const Gap(15)
            ],
          ),
        ),
      ),
    );
  }
}
