import 'package:flutter/material.dart';

class InsuranceProvider extends ChangeNotifier {
  int selectedInsurance = 1;
  String selectedInsuranceType = "NONE";

  void selectInsurance(int val) {
    selectedInsurance = val;
    if (val == 1) {
      selectedInsuranceType = "NONE";
    } else if (val == 2) {
      selectedInsuranceType = "BASIC";
    } else {
      selectedInsuranceType = "PREMIUM";
    }
    notifyListeners();
  }
}
