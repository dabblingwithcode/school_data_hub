import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/button.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/popup.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';

Future<int?> minutesLateDialog(BuildContext context) async {
  int? result;

  await Popup.show(
    context: context,
    title: 'Minuten Verspätung',
    child: _MinutesLateContent(
      onResult: (value) => result = value,
    ),
  );

  return result;
}

class _MinutesLateContent extends StatefulWidget {
  final ValueChanged<int?> onResult;

  const _MinutesLateContent({
    required this.onResult,
  });

  @override
  State<_MinutesLateContent> createState() => _MinutesLateContentState();
}

class _MinutesLateContentState extends State<_MinutesLateContent> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Form(
        key: _formKey,
        child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 100,
            child: TextFormField(
              focusNode: _focusNode,
              autofocus: true,
              textAlign: TextAlign.center,
              style: context.typography.display,
              keyboardType: TextInputType.number,
              controller: _controller,
              validator: (value) {
                return value!.isNotEmpty ? null : "";
              },
              decoration: InputDecoration(
                hintText: "?",
                hintStyle: context.typography.display.withColor(
                  Style.of(context).colors.mutedForeground,
                ),
              ),
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
                    _controller.clear();
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
                      int amount = int.parse(_controller.text);
                      widget.onResult(amount);
                      _controller.clear();
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ),
            ],
          ),
          ],
        ),
      ),
    );
  }
}
