import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wandering_wheels/constants/status.dart';
import 'package:wandering_wheels/models/car_model.dart';
import 'package:provider/provider.dart';
import 'package:wandering_wheels/models/booking_model.dart';
import 'package:wandering_wheels/providers/car_provider.dart';
import 'package:wandering_wheels/providers/user_provider.dart';

class CarBookingProvider extends ChangeNotifier {
  List<Booking> myBookings = [];
  List<Booking> allBookings = [];
  bool bookingUpdating = false;
  bool isMyBookingLoading = false;
  bool isAllBookingLoading = false;
  FirebaseFirestore db = FirebaseFirestore.instance;

  fetchAllBookings(BuildContext context) async {
    _setAllBookingLoading(true);
    var ref = await db.collection('bookings').get();
    await context.read<CarProvider>().fetchCars();
    List<Car> cars = context.read<CarProvider>().cars;
    allBookings = [];
    for (var doc in ref.docs) {
      Booking booking = Booking.fromJson(doc.data());
      var car = cars.firstWhere((car) => car.id == booking.carId);
      booking.car = car;
      allBookings.add(booking);
      notifyListeners();
    }
    _setAllBookingLoading(false);
  }

  fetchMyBookings(BuildContext context) async {
    log("Fetching My Bookings");
    _setMyBookingLoading(true);
    var user = context.read<UserProvider>().currentUser;
    var ref = await db
        .collection('bookings')
        .where('userId', isEqualTo: user!.id)
        .get();
    await context.read<CarProvider>().fetchCars();
    List<Car> cars = context.read<CarProvider>().cars;
    myBookings = [];
    for (var doc in ref.docs) {
      Booking booking = Booking.fromJson(doc.data());
      var car = cars.firstWhere((car) => car.id == booking.carId);
      booking.car = car;
      myBookings.add(booking);
      notifyListeners();
    }
    _setMyBookingLoading(false);
  }

  updateBookingStatus({
    required String status,
    required String id,
  }) async {
    _setBookingUpdating(true);
    try {
      await db.collection("bookings").doc(id).update({"status": status});
      _setBookingUpdating(false);
    } catch (e) {
      _setBookingUpdating(false);
      log(e.toString());
    }
  }

  void _setMyBookingLoading(bool val) {
    isMyBookingLoading = val;
    notifyListeners();
  }

  void _setBookingUpdating(bool val) {
    bookingUpdating = val;
    notifyListeners();
  }

  void _setAllBookingLoading(bool val) {
    isAllBookingLoading = val;
    notifyListeners();
  }
}
