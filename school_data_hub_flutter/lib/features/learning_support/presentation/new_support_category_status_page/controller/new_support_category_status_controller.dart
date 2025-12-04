import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/learning_support_manager.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/new_support_category_status_page/new_support_category_status_page.dart';
import 'package:watch_it/watch_it.dart';

class NewSupportCategoryStatus extends StatefulWidget {
  final String appBarTitle;
  final int pupilId;
  final int goalCategoryId;
  final String elementType;

  const NewSupportCategoryStatus({
    super.key,
    required this.appBarTitle,
    required this.pupilId,
    required this.goalCategoryId,
    required this.elementType,
  });

  @override
  NewSupportCategoryStatusController createState() =>
      NewSupportCategoryStatusController();
}

class NewSupportCategoryStatusController
    extends State<NewSupportCategoryStatus> {
  LearningSupportManager get _learningSupportPlanManager =>
      di<LearningSupportManager>();

  @override
  void initState() {
    super.initState();
    goalCategoryId = widget.goalCategoryId;
  }

  final TextEditingController descriptionTextFieldController =
      TextEditingController();
  final TextEditingController strategiesTextField2Controller =
      TextEditingController();
  int? goalCategoryId;
  int categoryStatusValue = 1;
  void setGoalCategoryId(int id) {
    setState(() {
      goalCategoryId = id;
    });
  }

  void setCategoryStatusValue(int value) {
    setState(() {
      categoryStatusValue = value;
    });
  }

  void setTextFieldControllerValues({
    required String description,
    required String strategies,
  }) {
    descriptionTextFieldController.text = description;
    strategiesTextField2Controller.text = strategies;
  }

  Future postCategoryStatus() async {
    if (goalCategoryId == null) {
      return;
    }

    await _learningSupportPlanManager.postSupportCategoryStatus(
      supportCategoryId: goalCategoryId!,
      pupilId: widget.pupilId,
      status: categoryStatusValue,
      comment: strategiesTextField2Controller.text,
    );
  }

  Future postCategoryGoal() async {
    if (goalCategoryId == null) {
      return;
    }

    await _learningSupportPlanManager.postNewSupportCategoryGoal(
      goalCategoryId: goalCategoryId!,
      pupilId: widget.pupilId,
      description: descriptionTextFieldController.text,
      strategies: strategiesTextField2Controller.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return NewSupportCategoryStatusPage(this);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the tree
    descriptionTextFieldController.dispose();
    strategiesTextField2Controller.dispose();
    super.dispose();
  }
}
