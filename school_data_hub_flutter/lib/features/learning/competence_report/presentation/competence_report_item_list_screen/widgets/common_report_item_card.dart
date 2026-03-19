import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/expansion/expansion_body.dart';
import 'package:school_data_hub_flutter/common/widgets/expansion/expansion_controller.dart';
import 'package:school_data_hub_flutter/common/widgets/expansion/expansion_header.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';

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
    final childrenController = createOnce(() => ExpansionController());
    final style = Style.of(context);

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: style.colors.accent,
        borderRadius: BorderRadius.circular(Style.radii.medium),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(Style.spacing.md),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Gap(Style.spacing.md),
                Expanded(
                  child: GestureDetector(
                    onTap: () => navigateToPostOrPatch(item: item),
                    onLongPress: () =>
                        navigateToPostOrPatch(parentItemId: item.publicId),
                    child: Text(
                      item.name,
                      maxLines: 4,
                      softWrap: true,
                      textAlign: TextAlign.start,
                      style: item.parentItem == null
                          ? context.typography.title.withColor(
                              style.colors.background,
                            )
                          : context.typography.subtitle.bold.withColor(
                              style.colors.background,
                            ),
                    ),
                  ),
                ),
                if (children.isNotEmpty) ...<Widget>[
                  ExpansionHeader(expansionController: childrenController),
                  Gap(Style.spacing.md),
                ],
              ],
            ),
          ),
          ExpansionBody(
            tileController: childrenController,
            widgetList: [
              Padding(
                padding: EdgeInsets.only(
                  top: Style.spacing.xs / 2,
                  bottom: Style.spacing.xs,
                ),
                child: Column(children: children),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
