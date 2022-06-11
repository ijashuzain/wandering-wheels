import 'package:flutter/material.dart';
import 'package:wandering_wheels/models/rental_model.dart';

class RentalProvider extends ChangeNotifier {
  bool isLoading = false;
  List<Rental> rentals = [];
  List<Rental> allRentals = [
    Rental(
      driverName: "Ijas Hussain M",
      carName: "Toyota Avalon",
      pickupDate: "14 Jan 2020",
      returnDate: "15 Jan 2020",
      driverEmail: "ijashussain3@gamil.com",
      driverPhone: "9037190469",
      driverPlace: "Someehere on Earth",
      status: "Onride",
    )
  ];

  void fetchRentals() {
    _setLoading(true);
    rentals = allRentals;
    _setLoading(false);
  }

  void _setLoading(bool val) {
    isLoading = val;
  }
}
