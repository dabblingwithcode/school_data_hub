import 'package:flutter/material.dart' hide ReorderableList;
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/reorderable_list.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/learning/competence/domain/competence_helper.dart';
import 'package:school_data_hub_flutter/features/learning/competence/domain/competence_manager.dart';
import 'package:school_data_hub_flutter/features/learning/competence/presentation/competence_list_sortable_screen/widgets/common_competence_card_sortable.dart';
import 'package:school_data_hub_flutter/features/learning/competence/presentation/competence_list_sortable_screen/widgets/last_child_competence_card_sortable.dart';

class CompetenceTreeSortable extends StatefulWidget {
  final List<Competence> competences;
  final void Function({int? competenceId, Competence? competence})
  navigateToNewOrPatchCompetencePage;

  const CompetenceTreeSortable({
    super.key,
    required this.competences,
    required this.navigateToNewOrPatchCompetencePage,
  });

  @override
  State<CompetenceTreeSortable> createState() => _CompetenceTreeSortableState();
}

class _CompetenceTreeSortableState extends State<CompetenceTreeSortable> {
  late List<int> _rootOrder;

  @override
  void initState() {
    super.initState();
    _rootOrder = _buildRootOrder();
  }

  @override
  void didUpdateWidget(CompetenceTreeSortable oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.competences != oldWidget.competences) {
      _rootOrder = _buildRootOrder();
    }
  }

  List<int> _buildRootOrder() {
    final roots =
        widget.competences.where((c) => c.parentCompetence == null).toList()
          ..sort((a, b) {
            if (a.order != null && b.order != null) {
              return a.order!.compareTo(b.order!);
            }
            if (a.order != null) return -1;
            if (b.order != null) return 1;
            return a.publicId.compareTo(b.publicId);
          });
    return roots.map((c) => c.publicId).toList();
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final id = _rootOrder.removeAt(oldIndex);
      _rootOrder.insert(newIndex, id);

      for (int i = 0; i < _rootOrder.length; i++) {
        final competence = di<CompetenceManager>().getCompetenceById(
          _rootOrder[i],
        );
        if (competence.order != i) {
          di<CompetenceManager>().updateCompetenceOrder(
            publicId: _rootOrder[i],
            order: i,
          );
        }
      }
    });
  }

  Widget _buildRootItem(int index, int publicId) {
    final competence = widget.competences.firstWhere(
      (c) => c.publicId == publicId,
    );
    final color = CompetenceHelper.getCompetenceColor(competence.publicId);
    final hasChildren = widget.competences.any(
      (c) => c.parentCompetence == publicId,
    );

    if (hasChildren) {
      return CommonCompetenceCardSortable(
        key: ValueKey(publicId),
        index: index,
        competence: competence,
        backgroundColor: color,
        allCompetences: widget.competences,
        navigateToNewOrPatchCompetencePage:
            widget.navigateToNewOrPatchCompetencePage,
      );
    } else {
      return Padding(
        key: ValueKey(publicId),
        padding: EdgeInsets.symmetric(
          horizontal: Style.spacing.xs,
          vertical: Style.spacing.xs / 2,
        ),
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
    return ReorderableList(
      onReorder: _onReorder,
      children: [
        for (int i = 0; i < _rootOrder.length; i++)
          _buildRootItem(i, _rootOrder[i]),
      ],
    );
  }
}
