import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/button.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/popup.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';

Future<int?> minutesLateDialog(BuildContext context) async {
  final controller = TextEditingController();
  int? result;

  await Popup.show(
    context: context,
    title: 'Minuten Verspätung',
    child: _MinutesLateContent(
      controller: controller,
      onResult: (value) => result = value,
    ),
  );

  controller.dispose();
  return result;
}

class _MinutesLateContent extends StatefulWidget {
  final TextEditingController controller;
  final ValueChanged<int?> onResult;

  const _MinutesLateContent({
    required this.controller,
    required this.onResult,
  });

  @override
  State<_MinutesLateContent> createState() => _MinutesLateContentState();
}

class _MinutesLateContentState extends State<_MinutesLateContent> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 100,
            child: TextFormField(
              textAlign: TextAlign.center,
              style: context.typography.display,
              keyboardType: TextInputType.number,
              controller: widget.controller,
              validator: (value) {
                return value!.isNotEmpty ? null : "";
              },
              decoration: const InputDecoration(hintText: "?"),
            ),
          ),
          SizedBox(height: Style.spacing.xl),
          Row(
            children: [
              Expanded(
                child: Button(
                  label: 'ABBRECHEN',
                  variant: ButtonVariant.secondary,
                  onPressed: () {
                    widget.controller.clear();
                    Navigator.of(context).pop();
                  },
                ),
              ),
              SizedBox(width: Style.spacing.lg),
              Expanded(
                child: Button(
                  label: 'OKAY',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      int amount = int.parse(widget.controller.text);
                      widget.onResult(amount);
                      widget.controller.clear();
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
