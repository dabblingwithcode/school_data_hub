import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar/generic_bottom_nav_bar.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';

/// Page that displays the School Data Hub server data model diagram (SVG).
class ServerModelDiagramPage extends StatelessWidget {
  const ServerModelDiagramPage({super.key});

  static const String _assetPath = 'assets/school_data_hub_server.svg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: AppColors.canvasColor,
      appBar: const GenericAppBar(
        iconData: Icons.account_tree_rounded,
        title: 'Server-Datenmodell',
      ),
      body: InteractiveViewer(
        minScale: 0.1,
        maxScale: 25.0,
        child: Center(child: SvgPicture.asset(_assetPath, fit: BoxFit.contain)),
      ),
      bottomNavigationBar: const GenericBottomNavBar(),
    );
  }
}
