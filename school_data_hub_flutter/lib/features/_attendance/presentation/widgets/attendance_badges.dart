import 'package:flutter/material.dart';
import 'package:school_data_hub_client/school_data_hub_client.dart';
import 'package:school_data_hub_flutter/common/theme/app_colors.dart';

Widget contactedBadge(contacted) {
  if (contacted == 1 || contacted == 2 || contacted == 3) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Container(
        width: 25.0,
        height: 25.0,
        decoration: BoxDecoration(
          color: Colors.red[900],
          shape: BoxShape.circle,
        ),
        child: const Center(
          child: Text(
            "K",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  } else {
    return Container();
  }
}

Widget contactedDayBadge(contacted) {
  return (contacted != ContactedType.notSet)
      ? Padding(
        padding: const EdgeInsets.all(1),
        child: Container(
          width: 25.0,
          height: 25.0,
          decoration: BoxDecoration(
            color:
                contacted == ContactedType.contacted
                    ? AppColors.contactedSuccessColor
                    : contacted == ContactedType.calledBack
                    ? AppColors.contactedCalledBackColor
                    : contacted == ContactedType.notReached
                    ? AppColors.contactedFailedColor
                    : AppColors.contactedFailedColor,
            shape: BoxShape.circle,
          ),
          child: Center(
            child:
                contacted == ContactedType.contacted
                    ? const Icon(Icons.local_phone_rounded)
                    : contacted == ContactedType.calledBack
                    ? const Icon(Icons.phone_callback_rounded)
                    : const Icon(Icons.phone_disabled_rounded),
          ),
        ),
      )
      : const SizedBox.shrink();
}

Widget returnedBadge(returned) {
  if (returned == true) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Container(
        width: 25.0,
        height: 25.0,
        decoration: const BoxDecoration(
          color: AppColors.goneHomeColor,
          shape: BoxShape.circle,
        ),
        child: const Center(
          child: Text(
            "H",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  } else {
    return Container();
  }
}

Widget excusedBadge(excused) {
  if (excused == true) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        width: 25.0,
        height: 25.0,
        decoration: const BoxDecoration(
          color: AppColors.unexcusedCheckColor,
          shape: BoxShape.circle,
        ),
        child: const Center(
          child: Text(
            "U",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  } else {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        width: 25.0,
        height: 25.0,
        decoration: BoxDecoration(
          color: Colors.green[600],
          shape: BoxShape.circle,
        ),
        child: const Center(
          child: Text(
            "E",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}

Widget missedTypeBadge(missedtype) {
  if (missedtype == MissedType.missed) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        width: 25.0,
        height: 25.0,
        decoration: const BoxDecoration(
          color: AppColors.missedColor,
          shape: BoxShape.circle,
        ),
        child: const Center(
          child: Text(
            "F",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  } else if (missedtype == MissedType.late) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        width: 25.0,
        height: 25.0,
        decoration: const BoxDecoration(
          color: AppColors.lateColor,
          shape: BoxShape.circle,
        ),
        child: const Center(
          child: Text(
            "V",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  } else if (missedtype == MissedType.notSet) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        width: 25.0,
        height: 25.0,
        decoration: const BoxDecoration(
          color: AppColors.presentColor,
          shape: BoxShape.circle,
        ),
        child: const Center(
          child: Text(
            "A",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  } else {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        width: 25.0,
        height: 25.0,
        decoration: const BoxDecoration(
          color: AppColors.homeColor,
          shape: BoxShape.circle,
        ),
        child: const Center(
          child: Text(
            "H",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
