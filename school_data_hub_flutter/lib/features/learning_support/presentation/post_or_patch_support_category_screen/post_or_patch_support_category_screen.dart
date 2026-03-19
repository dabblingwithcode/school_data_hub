import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/information_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/app_header.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/button.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/support_category_manager.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/support_category_list_sortable_screen/select_parent_category_screen.dart';

class PostOrPatchSupportCategoryScreen extends StatefulWidget {
  final SupportCategory? category;
  final int? parentCategoryId;

  const PostOrPatchSupportCategoryScreen({
    super.key,
    this.category,
    this.parentCategoryId,
  });

  @override
  State<PostOrPatchSupportCategoryScreen> createState() =>
      _PostOrPatchSupportCategoryScreenState();
}

class _PostOrPatchSupportCategoryScreenState
    extends State<PostOrPatchSupportCategoryScreen> {
  final TextEditingController _nameController = TextEditingController();
  late ValueNotifier<int?> _selectedParentId;

  SupportCategoryManager get _manager => di<SupportCategoryManager>();

  @override
  void initState() {
    super.initState();
    _selectedParentId = ValueNotifier<int?>(widget.parentCategoryId);
    if (widget.category != null) {
      _nameController.text = widget.category!.name;
      _selectedParentId.value = widget.category!.parentCategory;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _selectedParentId.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      informationDialog(
        context,
        'Name fehlt',
        'Bitte einen Namen für die Kategorie eingeben.',
      );
      return;
    }

    if (widget.category == null) {
      final success = await _manager.createSupportCategory(
        name: name,
        parentCategory: _selectedParentId.value,
      );
      if (success && mounted) {
        Navigator.pop(context);
      }
      return;
    }

    await _manager.updateSupportCategoryName(
      categoryId: widget.category!.categoryId,
      name: name,
    );
    final currentParent = widget.category!.parentCategory;
    final newParent = _selectedParentId.value;
    if (currentParent != newParent && mounted) {
      await _manager.updateSupportCategoryParent(
        categoryId: widget.category!.categoryId,
        parentCategory: newParent,
      );
    }
    if (mounted) {
      Navigator.pop(context);
    }
  }

  Future<void> _deleteCategory() async {
    if (widget.category == null) return;
    if (_manager.hasChildren(widget.category!.categoryId)) {
      informationDialog(
        context,
        'Förderkategorie kann nicht gelöscht werden',
        'Diese Kategorie hat Unterkategorien. Bitte löschen Sie zuerst die Unterkategorien.',
      );
      return;
    }
    final confirm = await confirmationDialog(
      context: context,
      title: 'Förderkategorie löschen',
      message: 'Sind Sie sicher?',
    );
    if (confirm != true) return;
    await _manager.deleteSupportCategory(widget.category!);
    if (mounted) {
      Navigator.pop(context);
    }
  }

  Future<void> _openSelectParent() async {
    final result = await Navigator.of(context, rootNavigator: true).push<int>(
      MaterialPageRoute<int>(
        builder: (ctx) => SelectParentCategoryScreen(
          movingCategoryId: widget.category?.categoryId ?? -1,
        ),
      ),
    );
    if (result != null && mounted) {
      if (result == SelectParentCategoryScreen.rootSentinel) {
        _selectedParentId.value = null;
      } else {
        _selectedParentId.value = result;
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    return Scaffold(
      appBar: AppHeader(
        iconData: Icons.category_rounded,
        title: widget.category != null
            ? 'Förderkategorie überarbeiten'
            : 'Neue Förderkategorie',
      ),
      body: Padding(
        padding: EdgeInsets.all(Style.spacing.lg),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name', style: context.typography.title),
                Gap(Style.spacing.md),
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(Style.spacing.sm),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Style.radii.small),
                    ),
                    labelText: 'Name der Kategorie',
                  ),
                ),
                Gap(Style.spacing.xl),
                Text(
                  'Übergeordnete Kategorie (optional)',
                  style: context.typography.title,
                ),
                Gap(Style.spacing.md),
                ValueListenableBuilder<int?>(
                  valueListenable: _selectedParentId,
                  builder: (context, parentId, _) {
                    if (parentId == null) {
                      return Button(
                        onPressed: _openSelectParent,
                        label: 'KATEGORIE AUSWÄHLEN',
                      );
                    }
                    return GestureDetector(
                      onTap: _openSelectParent,
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            Style.radii.medium,
                          ),
                          color: _manager.getCategoryColor(parentId),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(Style.spacing.lg),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  _manager.getSupportCategory(parentId).name,
                                  style: context.typography.subtitle.bold
                                      .withColor(style.colors.background),
                                ),
                              ),
                              Icon(
                                Icons.edit,
                                color: style.colors.background,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const Spacer(),
                Button(onPressed: _submit, label: 'SENDEN'),
                Gap(Style.spacing.lg),
                Button(
                  variant: ButtonVariant.secondary,
                  onPressed: () => Navigator.pop(context),
                  label: 'ABBRECHEN',
                ),
                if (widget.category != null) ...[
                  Gap(Style.spacing.lg),
                  Button(
                    variant: ButtonVariant.destructive,
                    onPressed: _deleteCategory,
                    label: 'FÖRDERKATEGORIE LÖSCHEN',
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
