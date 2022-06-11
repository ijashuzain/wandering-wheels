class Rental {
  final String driverName;
  final String carName;
  final String pickupDate;
  final String returnDate;
  final String status;
  final String driverPhone;
  final String driverEmail;
  final String driverPlace;

  Rental({
    required this.driverName,
    required this.carName,
    required this.pickupDate,
    required this.returnDate,
    required this.status,
    required this.driverEmail,
    required this.driverPhone,
    required this.driverPlace,
  });

  Rental.fromJson(Map<String, dynamic> json)
      : pickupDate = json["pickup_date"],
        returnDate = json["return_date"],
        driverName = json["driver_name"],
        status = json['status'],
        driverEmail = json["driver_email"],
        driverPhone = json["driver_phone"],
        driverPlace = json['driver_place'],
        carName = json['car_name'];
}
