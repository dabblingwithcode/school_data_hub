import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';

class LanguageDialogDropdown extends StatelessWidget {
  final int value;
  final ValueChanged<int?> onChanged;
  final String label;
  final IconData icon;

  const LanguageDialogDropdown({
    super.key,
    required this.value,
    required this.onChanged,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Icon(icon),
              const Gap(5),
              Text(
                "$label: ",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          Row(
            children: [
              DropdownButtonHideUnderline(
                child: DropdownButton<int>(
                  onTap: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  value: value,
                  items: [
                    DropdownMenuItem(
                      value: 0,
                      child: Center(
                        child: Text(
                          "nicht",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.interactiveColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    DropdownMenuItem(
                      value: 1,
                      child: Center(
                        child: Text(
                          "einfache Anliegen",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.interactiveColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    DropdownMenuItem(
                      value: 2,
                      child: Center(
                        child: Text(
                          "komplexere Informationen",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.interactiveColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    DropdownMenuItem(
                      value: 3,
                      child: Center(
                        child: Text(
                          "ohne Probleme",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.interactiveColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    DropdownMenuItem(
                      value: 4,
                      child: Center(
                        child: Text(
                          "unbekannt",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.interactiveColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                  onChanged: onChanged,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
