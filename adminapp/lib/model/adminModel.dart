
import 'dart:convert';

AdminModel countryModelFromJson(String str) => AdminModel.fromJson(json.decode(str));

String countryModelToJson(AdminModel data) => json.encode(data.toJson());

class AdminModel {
  AdminModel({
    required this.userName,
    required this.password,
    required this.phone,
    required this.email,
    required this.role,
    required this.deleted,
    required this.date,
    this.id
  });


  String userName;
  String password;
  String email;
  String phone;
  String role;
  bool deleted;
  String? id;
  DateTime date;

  factory AdminModel.fromJson(Map<String, dynamic> json) => AdminModel(
     userName: json["userName"],
    password: json["password"],
    phone: json["phone"],
    email: json["email"],
    role: json["role"],
    deleted: json["deleted"],
    date: json["date"].toDate(),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
   "userName": userName,
    "password": password,
    "email": email,
    "date": date,
    "phone": phone,
    "role": role,
    "deleted": deleted,
    "id": id,
  };
}
