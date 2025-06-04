import 'package:flutter/material.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';

// items for the missedType dropdown
List<DropdownMenuItem<MissedType>> missedTypeMenuItems = [
  DropdownMenuItem(
      value: MissedType.notSet,
      child: Container(
        width: 30.0,
        height: 30.0,
        decoration: const BoxDecoration(
          color: AppColors.presentColor,
          shape: BoxShape.circle,
        ),
        child: const Center(
          child: Text("A",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              )),
        ),
      )),
  DropdownMenuItem(
      value: MissedType.late,
      child: Container(
        width: 30.0,
        height: 30.0,
        decoration: const BoxDecoration(
          color: AppColors.lateColor,
          shape: BoxShape.circle,
        ),
        child: const Center(
          child: Text("V",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              )),
        ),
      )),
  DropdownMenuItem(
      value: MissedType.missed,
      child: Container(
        width: 30.0,
        height: 30.0,
        decoration: const BoxDecoration(
          color: AppColors.missedColor,
          shape: BoxShape.circle,
        ),
        child: const Center(
          child: Text("F",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              )),
        ),
      )),
];

List<DropdownMenuItem<ContactedType>> dropdownContactedMenuItems = [
  DropdownMenuItem(
      value: ContactedType.notSet,
      child: Container(
        width: 30.0,
        height: 30.0,
        decoration: const BoxDecoration(
          color: AppColors.contactedQuestionColor,
          shape: BoxShape.circle,
        ),
        child: const Center(
          child: Text("?",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              )),
        ),
      )),
  DropdownMenuItem(
      value: ContactedType.contacted,
      child: Container(
        width: 30.0,
        height: 30.0,
        decoration: const BoxDecoration(
          color: AppColors.contactedSuccessColor, // Colors.green[100],
          shape: BoxShape.circle,
        ),
        child: const Center(
          child: Icon(Icons.local_phone_rounded),
        ),
      )),
  DropdownMenuItem(
      value: ContactedType.calledBack,
      child: Container(
        width: 30.0,
        height: 30.0,
        decoration: const BoxDecoration(
          color: AppColors.contactedCalledBackColor,
          shape: BoxShape.circle,
        ),
        child: const Center(
          child: Icon(
            Icons.phone_callback_rounded,
          ),
        ),
      )),
  DropdownMenuItem(
      value: ContactedType.notReached,
      child: Container(
        width: 30.0,
        height: 30.0,
        decoration: const BoxDecoration(
          color: AppColors.contactedFailedColor,
          shape: BoxShape.circle,
        ),
        child: const Center(
          child: Icon(Icons.phone_disabled_rounded),
        ),
      )),
];
