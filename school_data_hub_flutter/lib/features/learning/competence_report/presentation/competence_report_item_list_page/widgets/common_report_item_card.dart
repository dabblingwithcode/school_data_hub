import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/widgets/custom_expansion_tile/custom_expansion_tile_controller.dart';
import 'package:school_data_hub_flutter/common/widgets/custom_expansion_tile/custom_expansion_tile_content.dart';
import 'package:school_data_hub_flutter/common/widgets/custom_expansion_tile/custom_expansion_tile_switch.dart';
import 'package:flutter_it/flutter_it.dart';

class CommonReportItemCard extends WatchingWidget {
  final CompetenceReportItem item;
  final void Function({int? parentItemId, CompetenceReportItem? item})
      navigateToPostOrPatch;
  final List<Widget> children;

  const CommonReportItemCard({
    required this.item,
    required this.navigateToPostOrPatch,
    required this.children,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final childrenController =
        createOnce(() => CustomExpansionTileController());

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: item.parentItem == null ? 3 : 0,
      ),
      child: Card(
        color: AppColors.backgroundColor,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.zero,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Gap(10),
                  Expanded(
                    child: InkWell(
                      onTap: () => navigateToPostOrPatch(item: item),
                      onLongPress: () => navigateToPostOrPatch(
                        parentItemId: item.publicId,
                      ),
                      child: Text(
                        item.name,
                        maxLines: 4,
                        softWrap: true,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: item.parentItem == null ? 20 : 16,
                        ),
                      ),
                    ),
                  ),
                  if (children.isNotEmpty) ...<Widget>[
                    CustomExpansionTileSwitch(
                      customExpansionTileController: childrenController,
                    ),
                    const Gap(10),
                  ],
                ],
              ),
            ),
            CustomExpansionTileContent(
              tileController: childrenController,
              widgetList: children,
            ),
          ],
        ),
      ),
    );
  }
}
