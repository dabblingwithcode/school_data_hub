import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/learning/_competence/presentation/widgets/competence_grades_widget.dart';

class LastChildReportItemCard extends StatelessWidget {
  final CompetenceReportItem item;
  final Function({int? parentItemId, CompetenceReportItem? item})
  navigateToPostOrPatch;

  const LastChildReportItemCard({
    required this.item,
    required this.navigateToPostOrPatch,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Flexible(
                  child: InkWell(
                    onTap: () => navigateToPostOrPatch(item: item),
                    onLongPress: () =>
                        navigateToPostOrPatch(parentItemId: item.publicId),
                    child: Text(
                      item.name,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            if (item.level != null && item.level!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: GradesWidget(
                        stringWithGrades: item.level!.join(","),
                      ),
                    ),
                    const Gap(10),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
