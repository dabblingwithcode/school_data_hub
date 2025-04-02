import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/theme/app_colors.dart';

class AppActionButton extends StatelessWidget {
  final Function function;
  final String title;
  const AppActionButton({
    super.key,
    required this.function,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        //margin: const EdgeInsets.only(bottom: 16),
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.appStyleButtonColor,
              minimumSize: const Size.fromHeight(50)),
          onPressed: () {
            function;
          },
          child: Text(
            title,
            style: TextStyle(fontSize: 17.0),
          ),
        ),
      ),
    );
  }
}
