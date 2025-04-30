import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';

class MainMenuButton extends StatelessWidget {
  final Widget? destinationPage;
  final Widget buttonIcon;
  final String buttonText;
  const MainMenuButton(
      {this.destinationPage,
      required this.buttonIcon,
      required this.buttonText,
      super.key});

  @override
  Widget build(BuildContext context) {
    double buttonSize = 150;
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        onTap: () {
          if (destinationPage != null) {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) => destinationPage!,
            ));
          }
        },
        child: SizedBox(
          width: buttonSize,
          height: buttonSize,
          child: Card(
            color: AppColors.backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buttonIcon,
                const Gap(10),
                Text(
                  buttonText,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
