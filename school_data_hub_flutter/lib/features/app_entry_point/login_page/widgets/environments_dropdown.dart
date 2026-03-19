import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/common/widgets/orient_ui/style.dart';
import 'package:school_data_hub_flutter/core/env/env_manager.dart';
import 'package:flutter_it/flutter_it.dart';

class EnvironmentsDropdown extends StatelessWidget {
  final String selectedEnv;
  final Function changeEnv;
  const EnvironmentsDropdown({
    required this.selectedEnv,
    required this.changeEnv,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final envManager = di<EnvManager>();
    final style = Style.of(context);
    return DropdownButton<String>(
      value: selectedEnv,
      hint: Text(
        'Select Server',
        style: TextStyle(color: style.colors.background),
      ),
      dropdownColor: style.colors.mutedForeground,
      icon: Icon(Icons.arrow_downward, color: style.colors.background),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: style.colors.background),
      underline: const SizedBox.shrink(),
      onChanged: (String? newValue) {
        changeEnv(newValue);
      },
      items: envManager.envs.keys.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Padding(
            padding: EdgeInsets.all(Style.spacing.md),
            child: Text(
              value,
              style: context.typography.title.withColor(
                style.colors.background,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
