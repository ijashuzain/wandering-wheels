class Car {
  String name;
  String? image;
  int rate;
  String categoryId;
  String manufacturer;
  String model;
  int year;
  int mileage;
  int seats;
  int quantity;
  String fuel;
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
    required this.quantity,
    required this.fuel,
    this.id,
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
        id = json['id'],
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
      'quantity': quantity,
      'id': id
    };
  }
}
