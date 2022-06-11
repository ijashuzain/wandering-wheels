import 'package:flutter/material.dart';

class InsuranceProvider extends ChangeNotifier {
  int selectedInsurance = 1;

  void selectInsurance(int val) {
    selectedInsurance = val;
    notifyListeners();
  }
}
