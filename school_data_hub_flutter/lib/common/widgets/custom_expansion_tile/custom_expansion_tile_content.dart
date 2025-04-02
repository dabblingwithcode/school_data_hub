import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/common/widgets/custom_expansion_tile/custom_expansion_tile.dart';

class CustomExpansionTileContent extends StatelessWidget {
  final List<Widget> widgetList;
  final CustomExpansionTileController? tileController;
  final Widget? title;

  const CustomExpansionTileContent(
      {super.key, required this.widgetList, this.tileController, this.title});

  @override
  Widget build(BuildContext context) {
    return ListTileTheme(
      contentPadding: const EdgeInsets.all(0),
      dense: true,
      horizontalTitleGap: 0.0,
      minLeadingWidth: 0,
      minVerticalPadding: 0,
      tileColor: Colors.transparent,
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 2.0),
          child: CustomExpansionTile(
              collapsedBackgroundColor: Colors.transparent,
              tilePadding: const EdgeInsets.all(0),
              title: title ?? const SizedBox.shrink(),
              controller: tileController,
              children: [...widgetList]),
        ),
      ),
    );
  }
}
