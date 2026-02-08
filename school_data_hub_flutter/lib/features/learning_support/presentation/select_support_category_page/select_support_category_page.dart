import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';
import 'package:school_data_hub_flutter/common/theme/styles.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/select_support_category_page/manager/select_support_category_manager.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/widgets/support_category_widgets/selectable_support_category_tree.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';

class SelectSupportCategoryPage extends WatchingWidget {
  final PupilProxy pupil;
  final String elementType;

  const SelectSupportCategoryPage({
    required this.pupil,
    required this.elementType,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final manager = createOnce(() => SelectSupportCategoryManager());
    final selectedCategoryId = watch(manager.selectedCategoryId).value;

    return Theme(
      data: ThemeData(
        unselectedWidgetColor: Colors.white,
        radioTheme: RadioThemeData(
          fillColor: WidgetStateProperty.all(Colors.white),
          // overlayColor: MaterialStateProperty.all(Colors.green),
        ),
      ),
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
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Bitte eine Kategorie auswählen!',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    RadioGroup<int>(
                      groupValue: selectedCategoryId,
                      onChanged: (value) {
                        if (value != null) {
                          manager.selectCategory(value);
                        }
                      },
                      child: SelectableSupportCategoryTree(
                        pupil: pupil,
                        manager: manager,
                        elementType: elementType,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        floatingActionButton: selectedCategoryId != null
            ? FloatingActionButton(
                backgroundColor: AppColors.backgroundColor,
                child: const Icon(Icons.check, color: Colors.white, size: 35),
                onPressed: () {
                  Navigator.of(context).pop(selectedCategoryId);
                },
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}
