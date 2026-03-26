import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/button.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/popup.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';

Future<String?> shortTextfieldDialog({
  required BuildContext context,
  required String title,
  required String labelText,
  String? textinField,
  required String hintText,
  bool? obscureText,
}) async {
  String? result;

  await Popup.show(
    context: context,
    title: title,
    child: _ShortTextfieldContent(
      labelText: labelText,
      textinField: textinField,
      hintText: hintText,
      obscureText: obscureText ?? false,
      onResult: (value) => result = value,
    ),
  );

  return result;
}

class _ShortTextfieldContent extends StatefulWidget {
  final String labelText;
  final String? textinField;
  final String hintText;
  final bool obscureText;
  final ValueChanged<String?> onResult;

  const _ShortTextfieldContent({
    required this.labelText,
    this.textinField,
    required this.hintText,
    required this.obscureText,
    required this.onResult,
  });

  @override
  State<_ShortTextfieldContent> createState() => _ShortTextfieldContentState();
}

class _ShortTextfieldContentState extends State<_ShortTextfieldContent> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.textinField ?? '');
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
    final style = Style.of(context);

    return Material(
      type: MaterialType.transparency,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            focusNode: _focusNode,
            autofocus: true,
            controller: _controller,
            obscureText: widget.obscureText,
            style: context.typography.subtitle.bold,
            decoration: InputDecoration(
              labelText: widget.labelText,
              labelStyle: context.typography.body.withColor(
                style.colors.mutedForeground,
              ),
              hintText: widget.hintText,
              hintStyle: context.typography.body.withColor(
                style.colors.mutedForeground,
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: style.colors.border, width: 2),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: style.colors.accent, width: 2),
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
                    Navigator.of(context).pop();
                  },
                ),
              ),
              SizedBox(width: Style.spacing.lg),
              Expanded(
                child: Button(
                  label: 'OKAY',
                  onPressed: () {
                    widget.onResult(_controller.text);
                    Navigator.of(context).pop();
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
