import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';

class GenericAppBar extends StatelessWidget implements PreferredSizeWidget {
  final IconData iconData;
  final String title;

  /// Optional widget to replace the default icon + title row.
  final Widget? titleWidget;

  /// Optional callback — wraps the entire title area in an [InkWell].
  final VoidCallback? onTitleTap;

  const GenericAppBar({
    super.key,
    this.iconData = Icons.home,
    this.title = '',
    this.titleWidget,
    this.onTitleTap,
  });

  @override
  Widget build(BuildContext context) {
    final content = SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child:
          titleWidget ??
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(iconData, size: 25, color: Colors.white),
              const SizedBox(width: 10),
              Text(title, style: AppStyles.appBarTextStyle),
            ],
          ),
    );

    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      backgroundColor: AppColors.backgroundColor,
      title: onTitleTap != null
          ? InkWell(onTap: onTitleTap, child: content)
          : content,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
