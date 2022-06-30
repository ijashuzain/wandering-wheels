import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wandering_wheels/constants/status.dart';
import 'package:wandering_wheels/models/car_model.dart';
import 'package:provider/provider.dart';
import 'package:wandering_wheels/models/booking_model.dart';
import 'package:wandering_wheels/providers/car_provider.dart';
import 'package:wandering_wheels/providers/user_provider.dart';

class BookingProvider extends ChangeNotifier {
  List<Booking> myBookings = [];
  List<Booking> allBookings = [];
  bool bookingUpdating = false;
  bool isMyBookingLoading = false;
  bool isAllBookingLoading = false;
  bool isAddingBooking = false;
  FirebaseFirestore db = FirebaseFirestore.instance;

  Car dummyCar = Car(
    name: "No Car Found",
    rate: 0,
    categoryId: "NONE",
    manufacturer: "NONE",
    model: "NONE",
    year: 1000,
    mileage: 0,
    seats: 0,
    regNumber: '',
    quantity: 0,
    fuel: "NONE",
    id: "1",
  );

  fetchAllBookings(BuildContext context) async {
    _setAllBookingLoading(true);
    var ref = await db.collection('bookings').get();
    await context.read<CarProvider>().fetchCars();
    List<Car> cars = context.read<CarProvider>().cars;
    allBookings = [];
    for (var doc in ref.docs) {
      Booking booking = Booking.fromJson(doc.data());
      bool result = await _checkForDue(booking);
      if (result) {
        booking.status = BookingStatus.overdue;
      }
      log(cars.length.toString());
      var car = cars.firstWhere(
        (car) => car.id == booking.carId,
        orElse: () => dummyCar,
      );
      booking.car = car;
      allBookings.add(booking);
      notifyListeners();
    }
    _setAllBookingLoading(false);
  }

  Future<bool> _checkForDue(Booking booking) async {
    if (booking.status != BookingStatus.overdue) {
      var differance = DateTime.now().difference(DateTime.parse(booking.returnDate)).inDays;
      if (differance > 0) {
        await updateBookingStatus(status: BookingStatus.overdue, id: booking.bookingId);
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  fetchMyBookings(BuildContext context) async {
    log("Fetching My Bookings");
    _setMyBookingLoading(true);
    var user = context.read<UserProvider>().currentUser;
    var ref = await db.collection('bookings').where('userId', isEqualTo: user!.id).get();
    await context.read<CarProvider>().fetchCars();
    List<Car> cars = context.read<CarProvider>().cars;
    log(cars.length.toString());
    myBookings = [];
    for (var doc in ref.docs) {
      Booking booking = Booking.fromJson(doc.data());
      var car = cars.firstWhere(
        (car) => car.id == booking.carId,
        orElse: () => dummyCar,
      );
      booking.car = car;
      myBookings.add(booking);
      notifyListeners();
    }
    _setMyBookingLoading(false);
  }

  addBooking({
    required Booking booking,
    required VoidCallback onSuccess,
    required Function onError,
  }) async {
    _setAddingBooking(true);
    try {
      var ref = db.collection('bookings').doc();
      booking.bookingId = ref.id;
      booking.status = BookingStatus.pending;
      await db.collection('bookings').doc(ref.id).set(booking.toJson());
      onSuccess();
      _setAddingBooking(false);
    } catch (e) {
      onError(e);
      _setAddingBooking(false);
      log(e.toString());
    }
  }

  updateBookingStatus({
    required String status,
    required String id,
  }) async {
    _setBookingUpdating(true);
    try {
      await db.collection("bookings").doc(id).update(
        {
          "status": status,
          "returnedDate": status == BookingStatus.completed ? DateFormat('yyyy-MM-dd').format(DateTime.now()) : '',
        },
      );
      _setBookingUpdating(false);
    } catch (e) {
      _setBookingUpdating(false);
      log(e.toString());
    }
  }

  deleteBooking({required String id}) async {
    _setBookingUpdating(true);
    try {
      await db.collection("bookings").doc(id).delete();
      _setBookingUpdating(false);
    } catch (e) {
      _setBookingUpdating(false);
      log(e.toString());
    }
  }

  void _setAddingBooking(bool value) {
    isAddingBooking = value;
    notifyListeners();
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
