import 'package:flutter/material.dart' hide ReorderableList;
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/expansion/expansion_body.dart';
import 'package:school_data_hub_flutter/common/widgets/expansion/expansion_controller.dart';
import 'package:school_data_hub_flutter/common/widgets/expansion/expansion_header.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/reorderable_list.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/learning/_competence/domain/competence_manager.dart';
import 'package:school_data_hub_flutter/features/learning/_competence/presentation/competence_list_sortable_page/widgets/last_child_competence_card_sortable.dart';

class CommonCompetenceCardSortable extends WatchingStatefulWidget {
  final Competence competence;
  final Color backgroundColor;
  final int index;
  final List<Competence> allCompetences;
  final void Function({int? competenceId, Competence? competence})
  navigateToNewOrPatchCompetencePage;

  const CommonCompetenceCardSortable({
    required this.competence,
    required this.backgroundColor,
    required this.index,
    required this.allCompetences,
    required this.navigateToNewOrPatchCompetencePage,
    super.key,
  });

  @override
  State<CommonCompetenceCardSortable> createState() =>
      _CommonCompetenceCardSortableState();
}

class _CommonCompetenceCardSortableState
    extends State<CommonCompetenceCardSortable> {
  late List<int> _childOrder;

  @override
  void initState() {
    super.initState();
    _childOrder = _buildChildOrder();
  }

  @override
  void didUpdateWidget(CommonCompetenceCardSortable oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.allCompetences != oldWidget.allCompetences) {
      _childOrder = _buildChildOrder();
    }
  }

  List<int> _buildChildOrder() {
    final children =
        widget.allCompetences
            .where((c) => c.parentCompetence == widget.competence.publicId)
            .toList()
          ..sort((a, b) {
            if (a.order != null && b.order != null) {
              return a.order!.compareTo(b.order!);
            }
            if (a.order != null) return -1;
            if (b.order != null) return 1;
            return a.publicId.compareTo(b.publicId);
          });
    return children.map((c) => c.publicId).toList();
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final id = _childOrder.removeAt(oldIndex);
      _childOrder.insert(newIndex, id);

      for (int i = 0; i < _childOrder.length; i++) {
        final competence = di<CompetenceManager>().getCompetenceById(
          _childOrder[i],
        );
        if (competence.order != i) {
          di<CompetenceManager>().updateCompetenceOrder(
            publicId: _childOrder[i],
            order: i,
          );
        }
      }
    });
  }

  Widget _buildChildItem(int index, int publicId) {
    final competence = widget.allCompetences.firstWhere(
      (c) => c.publicId == publicId,
    );
    final hasChildren = widget.allCompetences.any(
      (c) => c.parentCompetence == publicId,
    );

    if (hasChildren) {
      return CommonCompetenceCardSortable(
        key: ValueKey(publicId),
        index: index,
        competence: competence,
        backgroundColor: widget.backgroundColor,
        allCompetences: widget.allCompetences,
        navigateToNewOrPatchCompetencePage:
            widget.navigateToNewOrPatchCompetencePage,
      );
    } else {
      return Padding(
        key: ValueKey(publicId),
        padding: EdgeInsets.symmetric(horizontal: Style.spacing.xs),
        child: LastChildCompetenceCardSortable(
          index: index,
          competence: competence,
          navigateToNewOrPatchCompetencePage:
              widget.navigateToNewOrPatchCompetencePage,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final expansionController = createOnce(() => ExpansionController());
    final isExpanded = watch(expansionController.isExpanded).value;
    final isRoot = widget.competence.parentCompetence == null;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: isRoot ? 3 : 0),
      child: Container(
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: BorderRadius.circular(Style.radii.medium),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(Style.spacing.sm),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Gap(Style.spacing.sm),
                  Expanded(
                    child: GestureDetector(
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
                        style: (isRoot
                                ? context.typography.title
                                : context.typography.subtitle.bold)
                            .withColor(style.colors.background),
                      ),
                    ),
                  ),
                  if (_childOrder.isNotEmpty) ...[
                    ExpansionHeader(expansionController: expansionController),
                  ],
                  if (isExpanded)
                    const SizedBox(width: 36)
                  else
                    ReorderableDragStartListener(
                      index: widget.index,
                      child: Icon(
                        Icons.drag_handle,
                        color: style.colors.background.withValues(alpha: 0.7),
                      ),
                    ),
                ],
              ),
            ),
            if (_childOrder.isNotEmpty)
              ExpansionBody(
                tileController: expansionController,
                widgetList: [
                  ReorderableList(
                    onReorder: _onReorder,
                    children: [
                      for (int i = 0; i < _childOrder.length; i++)
                        _buildChildItem(i, _childOrder[i]),
                    ],
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
