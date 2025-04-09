import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/support_category_list_page/controller/category_list_controller.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/support_category_list_page/widgets/support_category_tree.dart';

class CategoryListPage extends StatelessWidget {
  final CategoryListController controller;
  const CategoryListPage(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        centerTitle: true,
        backgroundColor: AppColors.backgroundColor,
        title: const Text(
          'Förderkategorien',
          style: AppStyles.appBarTextStyle,
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding:
              const EdgeInsets.only(top: 8.0, left: 10, right: 10, bottom: 10),
          child: Center(
            child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: const SupportCategoryTree(
                    parentId: null, indentation: 0, backGroundColor: null)),
          ),
        ),
      ),
    );
  }
}
