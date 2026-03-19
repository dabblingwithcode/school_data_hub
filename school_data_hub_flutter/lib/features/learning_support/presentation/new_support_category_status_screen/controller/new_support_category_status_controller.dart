import 'package:flutter/material.dart';
import 'package:flutter_it/flutter_it.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/features/learning_support/domain/learning_support_manager.dart';
import 'package:school_data_hub_flutter/features/learning_support/presentation/new_support_category_status_screen/new_support_category_status_screen.dart';

class NewSupportCategoryStatus extends StatefulWidget {
  final String appBarTitle;
  final int pupilId;
  final int goalCategoryId;
  final String elementType;
  final SupportGoal? existingGoal;

  const NewSupportCategoryStatus({
    super.key,
    required this.appBarTitle,
    required this.pupilId,
    required this.goalCategoryId,
    required this.elementType,
    this.existingGoal,
  });

  @override
  NewSupportCategoryStatusController createState() =>
      NewSupportCategoryStatusController();
}

class NewSupportCategoryStatusController
    extends State<NewSupportCategoryStatus> {
  LearningSupportManager get _learningSupportPlanManager =>
      di<LearningSupportManager>();

  bool get isEditMode => widget.existingGoal != null;

  @override
  void initState() {
    super.initState();
    goalCategoryId = widget.goalCategoryId;
    if (widget.existingGoal != null) {
      descriptionTextFieldController.text = widget.existingGoal!.description;
      strategiesTextField2Controller.text = widget.existingGoal!.strategies;
    }
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

  Future<void> postCategoryStatus() async {
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

  Future<void> postCategoryGoal() async {
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

  Future<void> updateCategoryGoal() async {
    if (widget.existingGoal == null) {
      return;
    }

    await _learningSupportPlanManager.updateSupportGoal(
      pupilId: widget.pupilId,
      supportGoalId: widget.existingGoal!.id!,
      description: descriptionTextFieldController.text,
      strategies: strategiesTextField2Controller.text,
      supportCategoryId: goalCategoryId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return NewSupportCategoryStatusScreen(this);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the tree
    descriptionTextFieldController.dispose();
    strategiesTextField2Controller.dispose();
    super.dispose();
  }
}
