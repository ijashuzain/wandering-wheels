class UserData {
  String name;
  String email;
  String phone;
  String? id;
  String type;
  double? latitude;
  double? longitude;
  bool trackMe;

  UserData(
      {required this.name,
      required this.email,
      required this.phone,
      this.id,
      required this.type,
      this.latitude,
      required this.trackMe,
      this.longitude});

  UserData.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        phone = json["phone"],
        id = json["id"],
        type = json["type"],
        latitude = json["latitude"] ?? 0,
        longitude = json["longitude"] ?? 0,
        trackMe = json["trackMe"] ?? false,
        email = json["email"];

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['name'] = name;
    map['email'] = email;
    map['phone'] = phone;
    map['id'] = id;
    map['type'] = type;
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    map['trackMe'] = trackMe;
    return map;
  }
}
