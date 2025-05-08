import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/select_support_category_page/controller/select_support_category_controller.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/widgets/support_category_widgets/pupil_support_category_tree.dart';

class SelectSupportCategoryPage extends StatelessWidget {
  final SelectCategoryPageController controller;
  const SelectSupportCategoryPage(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          unselectedWidgetColor: Colors.white,
          radioTheme: RadioThemeData(
            fillColor: WidgetStateProperty.all(Colors.white),
            // overlayColor: MaterialStateProperty.all(Colors.green),
          )),
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          centerTitle: true,
          backgroundColor: AppColors.backgroundColor,
          title: const Text('Förderung', style: AppStyles.appBarTextStyle),
          // automaticallyImplyLeading: false,
        ),
        body: Center(
          heightFactor: 1,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Bitte eine Kategorie auswählen!',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    ),
                  ),
                  ...pupilSupportCategoryTree(
                      context: context,
                      pupil: controller.widget.pupil,
                      parentCategoryId: null,
                      indentation: 0,
                      backGroundColor: null,
                      controller: controller,
                      elementType: controller.widget.elementType),
                ]),
              ),
            ),
          ),
        ),
        floatingActionButton: controller.selectedCategoryId != null
            ? FloatingActionButton(
                backgroundColor: AppColors.backgroundColor,
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 35,
                ),
                onPressed: () {
                  Navigator.of(context).pop(controller.selectedCategoryId);
                })
            : const SizedBox.shrink(),
      ),
    );
  }
}
