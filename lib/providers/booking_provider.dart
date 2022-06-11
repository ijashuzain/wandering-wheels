import 'package:flutter/material.dart';
import 'package:wandering_wheels/models/car_model.dart';

class CarBookingProvider extends ChangeNotifier {
  List<Car> myBookings = [];
  bool isLoading = false;

  List<Car> allCars = [
    Car(
      name: "2020 Toyota Avalon",
      category: "Sport",
      image: "assets/images/car.jpeg",
      manufacturer: "Toyota",
      model: "Avalon",
      mileage: 2134,
      quantity: 20,
      rate: 500,
      seats: 5,
      year: 2020,
      fuel: "Petrol",
    ),
    Car(
      name: "Hyundai Santro",
      category: "SUV",
      image: "assets/images/santro.jpeg",
      manufacturer: "Hyundai",
      model: "Santro",
      mileage: 2134,
      quantity: 10,
      rate: 400,
      seats: 5,
      year: 2021,
      fuel: "Diesel",
    ),
  ];

  void fetchMyBookings() {
    isLoading = true;
    myBookings = allCars;
    isLoading = false;
  }

  void setLoading(bool val) {
    isLoading = val;
  }
}
