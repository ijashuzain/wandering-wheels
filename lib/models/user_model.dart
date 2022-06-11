class UserData {
  String name;
  String email;
  String phone;
  String? id;
  String type;

  UserData({
    required this.name,
    required this.email,
    required this.phone,
    this.id,
    required this.type,
  });

  UserData.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        phone = json["phone"],
        id = json["id"],
        type = json["type"],
        email = json["email"];

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['name'] = name;
    map['email'] = email;
    map['phone'] = phone;
    map['id'] = id;
    map['type'] = type;
    return map;
  }
}
