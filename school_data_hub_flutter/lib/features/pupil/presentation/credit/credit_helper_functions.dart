//- Values for the search bar

import 'package:school_data_hub_flutter/features/pupil/domain/models/pupil_proxy.dart';

class CreditHelper {
  static int totalFluidCredit(List<PupilProxy> pupils) {
    int totalCredit = 0;
    for (PupilProxy pupil in pupils) {
      totalCredit = totalCredit + pupil.credit;
    }
    return totalCredit;
  }

  static int totalGeneratedCredit(List<PupilProxy> pupils) {
    int totalGeneratedCredit = 0;
    for (PupilProxy pupil in pupils) {
      totalGeneratedCredit = totalGeneratedCredit + pupil.creditEarned;
    }
    return totalGeneratedCredit;
  }
}
