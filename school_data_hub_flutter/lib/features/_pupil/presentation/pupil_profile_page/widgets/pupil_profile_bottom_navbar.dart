import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/tappable_icon.dart';

class PupilProfileBottomNavBar extends StatelessWidget {
  const PupilProfileBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    return BottomAppBar(
      padding: const EdgeInsets.only(bottom: 0, right: 10, top: 6),
      shape: null,
      color: style.colors.accent,
      child: IconTheme(
        data: IconThemeData(color: style.colors.background),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: SizedBox(
            height: Platform.isWindows ? 10 : 35,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Gap(Style.spacing.md),
                TappableIcon(
                  size: 35,
                  icon: Icon(Icons.arrow_back, color: style.colors.background),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const Spacer(),
                TappableIcon(
                  size: 35,
                  onPressed: () =>
                      Navigator.popUntil(context, (route) => route.isFirst),
                  icon: Icon(Icons.home, color: style.colors.background),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
