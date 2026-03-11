import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/confirmation_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/dialogs/information_dialog.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/support_category_manager.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/support_category_list_sortable_page/select_parent_category_page.dart';

class PostOrPatchSupportCategoryPage extends StatefulWidget {
  final SupportCategory? category;
  final int? parentCategoryId;

  const PostOrPatchSupportCategoryPage({
    super.key,
    this.category,
    this.parentCategoryId,
  });

  @override
  State<PostOrPatchSupportCategoryPage> createState() =>
      _PostOrPatchSupportCategoryPageState();
}

class _PostOrPatchSupportCategoryPageState
    extends State<PostOrPatchSupportCategoryPage> {
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
    final result = await Navigator.of(context).push<int>(
      MaterialPageRoute<int>(
        builder: (ctx) => SelectParentCategoryPage(
          movingCategoryId: widget.category?.categoryId ?? -1,
        ),
      ),
    );
    if (result != null && mounted) {
      if (result == SelectParentCategoryPage.rootSentinel) {
        _selectedParentId.value = null;
      } else {
        _selectedParentId.value = result;
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GenericAppBar(
        iconData: Icons.category_rounded,
        title: widget.category != null
            ? 'Förderkategorie überarbeiten'
            : 'Neue Förderkategorie',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Name', style: AppStyles.title),
                const Gap(10),
                TextField(
                  controller: _nameController,
                  decoration: AppStyles.textFieldDecoration(
                    labelText: 'Name der Kategorie',
                  ),
                ),
                const Gap(20),
                const Text(
                  'Übergeordnete Kategorie (optional)',
                  style: AppStyles.title,
                ),
                const Gap(10),
                ValueListenableBuilder<int?>(
                  valueListenable: _selectedParentId,
                  builder: (context, parentId, _) {
                    if (parentId == null) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          backgroundColor: AppColors.backgroundColor,
                          minimumSize: const Size.fromHeight(60),
                        ),
                        onPressed: _openSelectParent,
                        child: const Text(
                          'KATEGORIE AUSWÄHLEN',
                          style: AppStyles.buttonTextStyle,
                        ),
                      );
                    }
                    return InkWell(
                      onTap: _openSelectParent,
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: _manager.getCategoryColor(parentId),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  _manager.getSupportCategory(parentId).name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              const Icon(
                                Icons.edit,
                                color: Colors.white,
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
                ElevatedButton(
                  style: AppStyles.actionButtonStyle,
                  onPressed: _submit,
                  child: const Text('SENDEN', style: AppStyles.buttonTextStyle),
                ),
                const Gap(15),
                ElevatedButton(
                  style: AppStyles.cancelButtonStyle,
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'ABBRECHEN',
                    style: AppStyles.buttonTextStyle,
                  ),
                ),
                if (widget.category != null) ...[
                  const Gap(15),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      backgroundColor: AppColors.dangerButtonColor,
                      minimumSize: const Size.fromHeight(50),
                    ),
                    onPressed: _deleteCategory,
                    child: const Text(
                      'FÖRDERKATEGORIE LÖSCHEN',
                      style: AppStyles.buttonTextStyle,
                    ),
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
