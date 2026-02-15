import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/common/widgets/bottom_nav_bar/bottom_nav_bar_layouts.dart';
import 'package:school_data_hub_flutter/common/widgets/generic_components/generic_app_bar.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/support_category_manager.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/support_category_list_sortable_page/select_parent_category_page.dart';

class NewSupportCategoryPage extends WatchingWidget {
  const NewSupportCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = createOnce(() => TextEditingController());
    final selectedParentId = createOnce(() => ValueNotifier<int?>(null));

    final parentId = watch(selectedParentId).value;

    final categoryManager = di<SupportCategoryManager>();

    return Scaffold(
      appBar: const GenericAppBar(
        iconData: Icons.category_rounded,
        title: 'Neue Förderkategorie',
      ),
      body: Center(
        heightFactor: 1,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Name', style: AppStyles.title),
                  const Gap(10),
                  TextField(
                    controller: nameController,
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
                  if (parentId == null)
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        backgroundColor: AppColors.backgroundColor,
                        minimumSize: const Size.fromHeight(60),
                      ),
                      onPressed: () async {
                        final result = await Navigator.of(context).push<int>(
                          MaterialPageRoute(
                            builder: (ctx) => const SelectParentCategoryPage(
                              movingCategoryId: -1,
                            ),
                          ),
                        );
                        if (result != null) {
                          if (result == SelectParentCategoryPage.rootSentinel) {
                            selectedParentId.value = null;
                          } else {
                            selectedParentId.value = result;
                          }
                        }
                      },
                      child: const Text(
                        'KATEGORIE AUSWÄHLEN',
                        style: AppStyles.buttonTextStyle,
                      ),
                    )
                  else
                    InkWell(
                      onTap: () async {
                        final result = await Navigator.of(context).push<int>(
                          MaterialPageRoute(
                            builder: (ctx) => const SelectParentCategoryPage(
                              movingCategoryId: -1,
                            ),
                          ),
                        );
                        if (result != null) {
                          if (result == SelectParentCategoryPage.rootSentinel) {
                            selectedParentId.value = null;
                          } else {
                            selectedParentId.value = result;
                          }
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: categoryManager.getCategoryColor(parentId),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  categoryManager
                                      .getSupportCategory(parentId)
                                      .name,
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
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBarLayout(
        bottomNavBar: BottomAppBar(
          height: 60,
          padding: const EdgeInsets.all(10),
          shape: null,
          color: AppColors.backgroundColor,
          child: IconTheme(
            data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Row(
                children: [
                  const Spacer(),
                  IconButton(
                    tooltip: 'Abbrechen',
                    icon: const Icon(Icons.close, size: 30),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const Gap(30),
                  IconButton(
                    tooltip: 'Speichern',
                    icon: const Icon(Icons.check, size: 30),
                    onPressed: () async {
                      final name = nameController.text.trim();
                      if (name.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Bitte einen Namen für die Kategorie eingeben',
                            ),
                          ),
                        );
                        return;
                      }
                      final success = await categoryManager
                          .createSupportCategory(
                            name: name,
                            parentCategory: selectedParentId.value,
                          );
                      if (success && context.mounted) {
                        Navigator.pop(context);
                      }
                    },
                  ),
                  const Gap(15),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
