import 'package:flutter/material.dart';

class CarDetailsProvider extends ChangeNotifier {
  String pickupDate = '';
  String dropDate = '';

  int selectedGender = 1;

  void selectGender(int val) {
    selectedGender = val;
    notifyListeners();
  }

  void addPickupDate(String val) {
    pickupDate = val;
    notifyListeners();
  }

  void addDropDate(String val) {
    dropDate = val;
    notifyListeners();
  }

  void reset() {
    pickupDate = '';
    dropDate = '';
    selectedGender = 1;
    notifyListeners();
  }

}
