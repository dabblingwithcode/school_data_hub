import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/learning/domain/competence_manager.dart';
import 'package:watch_it/watch_it.dart';

class CommonCompetenceCardSortable extends WatchingStatefulWidget {
  final Color competenceBackgroundColor;
  final Function({int? competenceId, Competence? competence})
  navigateToNewOrPatchCompetencePage;
  final Competence competence;
  final List<Widget> children;
  const CommonCompetenceCardSortable({
    required this.competence,
    required this.competenceBackgroundColor,
    required this.navigateToNewOrPatchCompetencePage,
    required this.children,
    super.key,
  });

  @override
  State<CommonCompetenceCardSortable> createState() =>
      _CommonCompetenceCardState();
}

class _CommonCompetenceCardState extends State<CommonCompetenceCardSortable> {
  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final item = widget.children.removeAt(oldIndex);
      widget.children.insert(newIndex, item);
      for (final competenceId in widget.children) {
        final competence = di<CompetenceManager>().getCompetenceById(
          (competenceId.key as ValueKey<int>).value,
        );
        di<CompetenceManager>().updateCompetenceProperty(
          publicId: competence.publicId,
          order: (value: widget.children.indexOf(competenceId)),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // final childrenController = useCustomExpansionTileController();

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: widget.competence.parentCompetence == null ? 3 : 0,
      ),
      child: Card(
        color: widget.competenceBackgroundColor,
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
                      onTap: () => widget.navigateToNewOrPatchCompetencePage(
                        competence: widget.competence,
                      ),
                      onLongPress: () =>
                          widget.navigateToNewOrPatchCompetencePage(
                            competenceId: widget.competence.publicId,
                          ),
                      child: Text(
                        widget.competence.name,
                        maxLines: 4,
                        softWrap: true,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: widget.competence.parentCompetence == null
                              ? 20
                              : 16,
                        ),
                      ),
                    ),
                  ),

                  // CustomExpansionTileSwitch(
                  //   customExpansionTileController: pupilListController,
                  //   expansionSwitchWidget: const Icon(
                  //     Icons.add,
                  //     color: Colors.white,
                  //   ),
                  // ),
                ],
              ),
            ),
            if (widget.children.isNotEmpty)
              ReorderableListView(
                shrinkWrap: true,
                onReorder: _onReorder,
                children: widget.children,
              ),

            // Padding(
            //   padding: const EdgeInsets.only(
            //       left: 5.0, right: 5.0, bottom: 2.5, top: 2.5),
            //   child: CustomExpansionTileContent(
            //       tileController: pupilListController,
            //       widgetList: [
            //         ListView.builder(
            //           shrinkWrap: true,
            //           physics: const NeverScrollableScrollPhysics(),
            //           itemCount: competenceFilteredPupils.length,
            //           itemBuilder: (context, index) {
            //             final pupil = competenceFilteredPupils[index];
            //             return MultiPupilCompetenceCheckCard(pupil: pupil);
            //           },
            //         ),
            //       ]),
            // ),
          ],
        ),
      ),
    );
  }
}
