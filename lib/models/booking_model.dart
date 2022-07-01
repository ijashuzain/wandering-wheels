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
  String insuranceType;
  String bookingId;
  String? returnedDate;
  double? latitude;
  double? longitude;
  int qty;
  String rate;

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
    required this.insuranceType,
    required this.qty,
    required this.returnedDate,
    this.latitude,
    this.longitude,
    required this.rate,
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
        insuranceType = json['insuranceType'],
        latitude = json['latitude'] ?? 0,
        longitude = json['longitude'] ?? 0,
        car = json['car'],
        qty = json['qty'],
        rate = json['rate'] ?? '';

  Map<String, dynamic> toJson() => {
        "pickup_date": pickupDate,
        "return_date": returnDate,
        "driver_name": driverName,
        "status": status,
        "driver_email": driverEmail,
        "driver_phone": driverPhone,
        "driver_place": driverPlace,
        "carId": carId,
        "userId": userId,
        "bookingId": bookingId,
        "returnedDate": returnedDate,
        "car": car,
        "insuranceType": insuranceType,
        "latitude": latitude,
        "qty" : qty,
        "longitude": longitude,
        'rate': rate,
      };
}
