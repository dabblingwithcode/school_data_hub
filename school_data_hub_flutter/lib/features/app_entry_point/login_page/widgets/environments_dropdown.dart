import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/core/env/env_manager.dart';
import 'package:watch_it/watch_it.dart';

class EnvironmentsDropdown extends StatelessWidget {
  final String selectedEnv;
  final Function changeEnv;
  const EnvironmentsDropdown(
      {required this.selectedEnv, required this.changeEnv, super.key});

  @override
  Widget build(BuildContext context) {
    final envManager = di<EnvManager>();
    return DropdownButton<String>(
      value: selectedEnv,
      hint: const Text(
        'Select Server',
        style: TextStyle(color: Colors.white),
      ),
      dropdownColor: Colors.grey[800],
      icon: const Icon(Icons.arrow_downward, color: Colors.white),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.white),
      underline: const SizedBox.shrink(),
      onChanged: (String? newValue) {
        changeEnv(newValue);
      },
      items: envManager.envs.keys.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
