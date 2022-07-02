class Car {
  String name;
  String? image;
  int rate;
  String dealerId;
  String categoryId;
  String manufacturer;
  String model;
  int year;
  int mileage;
  int seats;
  int quantity;
  String pickupLat;
  String pickupLng;
  String fuel;
  bool? isAvailable;
  String regNumber;
  String? id;

  Car({
    required this.name,
    this.image,
    required this.rate,
    required this.categoryId,
    required this.manufacturer,
    required this.model,
    required this.year,
    required this.mileage,
    required this.seats,
    required this.pickupLat,
    required this.pickupLng,
    required this.quantity,
    required this.fuel,
    required this.dealerId,
    required this.regNumber,
    this.id,
    this.isAvailable,
  });

  Car.fromJson(
    Map<String, dynamic> json,
  )   : name = json['name'],
        image = json['image'],
        rate = json['rate'],
        categoryId = json['category'],
        manufacturer = json['manufacturer'],
        model = json['model'],
        year = json['year'],
        mileage = json['mileage'],
        seats = json['seats'],
        fuel = json['fuel'],
        pickupLat = json['pickupLat'],
        pickupLng = json['pickupLng'],
        id = json['id'],
        isAvailable = json['isAvailable'] ?? true,
        regNumber = json['regNumber'],
        dealerId = json['dealerId'],
        quantity = json['quantity'];

  toMap() {
    return {
      'name': name,
      'image': image,
      'rate': rate,
      'category': categoryId,
      'manufacturer': manufacturer,
      'model': model,
      'year': year,
      'mileage': mileage,
      'seats': seats,
      'fuel': fuel,
      'regNumber': regNumber,
      'quantity': quantity,
      'pickupLat': pickupLat,
      'pickupLng': pickupLng,
      'isAvailable': isAvailable,
      'dealerId':dealerId,
      'id': id
    };
  }
}
