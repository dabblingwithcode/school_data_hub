import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/learning/domain/competence_manager.dart';
import 'package:flutter_it/flutter_it.dart';

class CommonCompetenceCardSortable extends StatefulWidget {
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
  late List<Widget> _children;

  @override
  void initState() {
    super.initState();
    _children = List.of(widget.children);
  }

  @override
  void didUpdateWidget(CommonCompetenceCardSortable oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.children != oldWidget.children) {
      _children = List.of(widget.children);
    }
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final item = _children.removeAt(oldIndex);
      _children.insert(newIndex, item);

      for (int i = 0; i < _children.length; i++) {
        final competence = di<CompetenceManager>().getCompetenceById(
          (_children[i].key as ValueKey<int>).value,
        );
        if (competence.order != i) {
          di<CompetenceManager>().updateCompetenceProperty(
            publicId: competence.publicId,
            order: (value: i),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
                ],
              ),
            ),
            if (_children.isNotEmpty)
              ReorderableListView(
                shrinkWrap: true,
                onReorder: _onReorder,
                children: _children,
              ),
          ],
        ),
      ),
    );
  }
}
