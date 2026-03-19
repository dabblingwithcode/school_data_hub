import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/core/session/hub_session_manager.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/learning_support_helper.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/learning_support_manager.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/support_category_manager.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/select_support_category_page/manager/select_support_category_manager.dart';

const _categoryTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 16,
  fontWeight: FontWeight.bold,
);

/// Displays a recursive tree of support categories for a given pupil,
/// with branch nodes as [ExpansionTile]s and leaf nodes as selectable
/// [Radio] rows.
class SelectableSupportCategoryTree extends StatelessWidget {
  final PupilProxy pupil;
  final int? parentCategoryId;
  final double indentation;
  final Color? backGroundColor;
  final SelectSupportCategoryManager manager;
  final String elementType;

  const SelectableSupportCategoryTree({
    required this.pupil,
    this.parentCategoryId,
    this.indentation = 0,
    this.backGroundColor,
    required this.manager,
    required this.elementType,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final supportCategories =
        di<SupportCategoryManager>().supportCategories.value;

    return Column(
      children: [
        for (final category in supportCategories)
          if (category.parentCategory == parentCategoryId)
            _CategoryNode(
              category: category,
              pupil: pupil,
              indentation: indentation,
              inheritedColor: backGroundColor,
              manager: manager,
              elementType: elementType,
            ),
      ],
    );
  }
}

/// A single node in the support category tree.
///
/// Renders as a [_BranchNode] (expandable) if it has child categories,
/// or as a [_LeafNode] (selectable radio row) otherwise.
class _CategoryNode extends StatelessWidget {
  final SupportCategory category;
  final PupilProxy pupil;
  final double indentation;
  final Color? inheritedColor;
  final SelectSupportCategoryManager manager;
  final String elementType;

  const _CategoryNode({
    required this.category,
    required this.pupil,
    required this.indentation,
    required this.inheritedColor,
    required this.manager,
    required this.elementType,
  });

  @override
  Widget build(BuildContext context) {
    final color =
        inheritedColor ??
        LearningSupportHelper.getRootSupportCategoryColor(category);

    final supportCategories =
        di<SupportCategoryManager>().supportCategories.value;

    final hasChildren = supportCategories.any(
      (c) => c.parentCategory == category.categoryId,
    );

    return Padding(
      padding: EdgeInsets.only(top: Style.spacing.md, left: indentation),
      child: hasChildren
          ? _BranchNode(
              category: category,
              pupil: pupil,
              indentation: indentation,
              color: color,
              manager: manager,
              elementType: elementType,
            )
          : _LeafNode(
              category: category,
              pupil: pupil,
              color: color,
              manager: manager,
            ),
    );
  }
}

/// A branch node displayed as an [ExpansionTile] containing a nested
/// [SelectableSupportCategoryTree]. The category itself is also selectable.
class _BranchNode extends StatelessWidget {
  final SupportCategory category;
  final PupilProxy pupil;
  final double indentation;
  final Color color;
  final SelectSupportCategoryManager manager;
  final String elementType;

  const _BranchNode({
    required this.category,
    required this.pupil,
    required this.indentation,
    required this.color,
    required this.manager,
    required this.elementType,
  });

  @override
  Widget build(BuildContext context) {
    // Domain-specific color: use Container with BoxDecoration instead of CardBox
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(Style.radii.medium),
      ),
      clipBehavior: Clip.hardEdge,
      child: ExpansionTile(
        iconColor: Colors.white,
        collapsedTextColor: Colors.white,
        collapsedIconColor: Colors.white,
        textColor: Colors.white,
        maintainState: false,
        backgroundColor: color,
        collapsedBackgroundColor: color,
        title: Row(
          children: [
            Radio<int>(value: category.categoryId),
            Gap(Style.spacing.xs),
            Expanded(
              child: GestureDetector(
                onTap: () => manager.selectCategory(category.categoryId),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: Style.spacing.sm),
                  child: Text(
                    category.name,
                    maxLines: 3,
                    style: _categoryTextStyle,
                  ),
                ),
              ),
            ),
          ],
        ),
        children: [
          SelectableSupportCategoryTree(
            pupil: pupil,
            parentCategoryId: category.categoryId,
            indentation: indentation + 15,
            backGroundColor: color,
            manager: manager,
            elementType: elementType,
          ),
        ],
      ),
    );
  }
}

/// A leaf node displayed as a selectable row with a [Radio] button.
class _LeafNode extends StatelessWidget {
  final SupportCategory category;
  final PupilProxy pupil;
  final Color color;
  final SelectSupportCategoryManager manager;

  const _LeafNode({
    required this.category,
    required this.pupil,
    required this.color,
    required this.manager,
  });

  @override
  Widget build(BuildContext context) {
    final isAdmin = di<HubSessionManager>().isAdmin;

    return Padding(
      padding: EdgeInsets.all(Style.spacing.sm),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.all(Style.spacing.xs),
            child: Radio<int>(value: category.categoryId),
          ),
          Gap(Style.spacing.xs),
          Flexible(
            child: GestureDetector(
              onTap: () => manager.selectCategory(category.categoryId),
              onLongPress: isAdmin
                  ? () => _handleAdminLongPress(context)
                  : null,
              child: Text(
                category.name,
                maxLines: 4,
                textAlign: TextAlign.start,
                style: _categoryTextStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleAdminLongPress(BuildContext context) async {
    if (pupil.supportCategoryStatuses?.isEmpty ?? true) return;

    final delete = await confirmationDialog(
      context: context,
      title: 'Kategoriestatus löschen',
      message: 'Kategoriestatus löschen?',
    );

    if (delete != true) return;

    final supportCategoryStatus = pupil.supportCategoryStatuses!
        .lastWhereOrNull((e) => e.supportCategoryId == category.categoryId);
    await di<LearningSupportManager>().deleteSupportCategoryStatus(
      pupil.pupilId,
      supportCategoryStatus!.id!,
    );
  }
}
