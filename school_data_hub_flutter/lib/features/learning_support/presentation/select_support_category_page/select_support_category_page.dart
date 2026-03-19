import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/select_support_category_page/manager/select_support_category_manager.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/widgets/support_category_widgets/selectable_support_category_tree.dart';
import 'package:school_data_hub_flutter/features/_pupil/domain/models/pupil_proxy.dart';

class SelectSupportCategoryScreen extends WatchingWidget {
  final PupilProxy pupil;
  final String elementType;

  const SelectSupportCategoryScreen({
    required this.pupil,
    required this.elementType,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final style = Style.of(context);
    final manager = createOnce(() => SelectSupportCategoryManager());
    final selectedCategoryId = watch(manager.selectedCategoryId).value;

    return Theme(
      data: ThemeData(
        unselectedWidgetColor: style.colors.background,
        radioTheme: RadioThemeData(
          fillColor: WidgetStateProperty.all(style.colors.background),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: style.colors.background,
          centerTitle: true,
          backgroundColor: style.colors.accent,
          title: Text('Förderung', style: context.typography.title.withColor(style.colors.background)),
        ),
        body: Center(
          heightFactor: 1,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(Style.spacing.sm),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(Style.spacing.sm),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Bitte eine Kategorie auswählen!',
                            style: context.typography.title.withColor(style.colors.foreground),
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
                backgroundColor: style.colors.accent,
                child: Icon(Icons.check, color: style.colors.background, size: 35),
                onPressed: () {
                  Navigator.of(context).pop(selectedCategoryId);
                },
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}
