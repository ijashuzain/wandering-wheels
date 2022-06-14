import 'package:wandering_wheels/constants/status.dart';
import 'package:wandering_wheels/models/car_model.dart';

class Booking {
  Car? car;
  String carId;
  String driverName;
  String pickupDate;
  String returnDate;
  String status;
  String driverPhone;
  String driverEmail;
  String driverPlace;
  String userId;
  String bookingId;
  String? returnedDate;

  Booking({
    required this.driverName,
    required this.pickupDate,
    required this.returnDate,
    required this.status,
    required this.driverEmail,
    required this.driverPhone,
    required this.driverPlace,
    required this.carId,
    required this.car,
    required this.userId,
    required this.bookingId,
    this.returnedDate,
  });

  Booking.fromJson(Map<String, dynamic> json)
      : pickupDate = json["pickup_date"],
        returnDate = json["return_date"],
        driverName = json["driver_name"],
        status = json['status'],
        driverEmail = json["driver_email"],
        driverPhone = json["driver_phone"],
        driverPlace = json['driver_place'],
        carId = json['carId'],
        userId = json['userId'],
        bookingId = json['bookingId'],
        returnedDate = json['returnedDate'] ?? '',
        car = json['car'];
        
}
