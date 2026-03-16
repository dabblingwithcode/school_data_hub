import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';

class PupilProfileContentHeader extends StatelessWidget {
  final IconData icon;
  final String title;

  const PupilProfileContentHeader({
    required this.icon,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Gap(5),
        Icon(icon, color: AppColors.groupColor, size: 28),
        const Gap(5),
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.backgroundColor,
          ),
        ),
      ],
    );
  }
}

class ProfilePageConstraints extends InheritedWidget {
  final double minHeight;

  const ProfilePageConstraints({
    required this.minHeight,
    required super.child,
    super.key,
  });

  static ProfilePageConstraints? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ProfilePageConstraints>();
  }

  @override
  bool updateShouldNotify(ProfilePageConstraints oldWidget) {
    return minHeight != oldWidget.minHeight;
  }
}

class PupilProfileContentCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget child;
  final VoidCallback? onTitleTap;
  final Widget? headerTrailing;

  const PupilProfileContentCard({
    required this.icon,
    required this.title,
    required this.child,
    this.onTitleTap,
    this.headerTrailing,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final pageConstraints = ProfilePageConstraints.of(context);
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: pageConstraints?.minHeight ?? 0),
      child: Container(
        padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.backgroundColor.withValues(alpha: 0.2),
            width: 1.5,
          ),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(5),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: onTitleTap,
                  borderRadius: BorderRadius.circular(8),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 4.0,
                      horizontal: 4.0,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(icon, color: AppColors.backgroundColor, size: 25),
                        const Gap(10),
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.backgroundColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (headerTrailing != null) ...[
                  const Spacer(),
                  headerTrailing!,
                ],
              ],
            ),
            const Gap(12),
            child,
          ],
        ),
      ),
    );
  }
}

class PupilProfileContentRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? value;
  final Widget? valueWidget;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final Widget? actionButton;

  const PupilProfileContentRow({
    required this.icon,
    required this.label,
    this.value,
    this.valueWidget,
    this.onTap,
    this.onLongPress,
    this.actionButton,
    super.key,
  }) : assert(
         value != null || valueWidget != null,
         'Either value or valueWidget must be provided',
       );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, right: 5, bottom: 5),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        decoration: BoxDecoration(
          color: AppColors.cardInCardColor,
          borderRadius: BorderRadius.circular(8),
          // border: Border.all(color: AppColors.cardInCardBorderColor, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: [
                  Icon(
                    icon,
                    color: AppColors.backgroundColor.withValues(alpha: 0.7),
                    size: 18,
                  ),
                  const Gap(8),
                  Text(
                    '$label:',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.backgroundColor,
                    ),
                  ),

                  const Gap(6),
                  Expanded(
                    child: InkWell(
                      onTap: onTap,
                      onLongPress: onLongPress,
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 12,
                        ),
                        decoration: BoxDecoration(
                          color: onTap != null
                              ? Colors.white
                              : Colors.transparent,
                          border: Border.all(
                            color: AppColors.cardInCardBorderColor,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child:
                            valueWidget ??
                            Text(
                              value!,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: onTap != null
                                    ? AppColors.interactiveColor
                                    : Colors.black87,
                              ),
                            ),
                      ),
                    ),
                  ),
                  if (actionButton != null) actionButton!,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
