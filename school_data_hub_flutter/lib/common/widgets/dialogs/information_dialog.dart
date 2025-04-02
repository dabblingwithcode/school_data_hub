import 'package:flutter/material.dart';
import 'package:school_data_hub_flutter/theme/app_colors.dart';
import 'package:school_data_hub_flutter/theme/styles.dart';

void informationDialog(context, title, text) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(
          Icons.info,
          color: AppColors.backgroundColor,
          size: 50,
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        content: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 300),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Text(
              text,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: ElevatedButton(
              style: AppStyles.successButtonStyle,
              onPressed: () {
                Navigator.of(context).pop(true);
              }, // Add onPressed
              child: const Text(
                "OK",
                style: AppStyles.buttonTextStyle,
              ),
            ),
          ),
        ],
      ),
    );
