import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/select_support_category_page/select_support_category_page.dart';
import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';

class SelectSupportCategory extends StatefulWidget {
  final PupilProxy pupil;
  final String elementType;
  const SelectSupportCategory({
    required this.pupil,
    required this.elementType,
    super.key,
  });

  @override
  SelectCategoryPageController createState() => SelectCategoryPageController();
}

class SelectCategoryPageController extends State<SelectSupportCategory> {
  int? selectedCategoryId;

  void selectCategory(int id) {
    setState(() {
      selectedCategoryId = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SelectSupportCategoryPage(this);
  }
}
