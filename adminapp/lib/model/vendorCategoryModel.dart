
import 'dart:convert';

vendorCategoryModel countryModelFromJson(String str) => vendorCategoryModel.fromJson(json.decode(str));

String countryModelToJson(vendorCategoryModel data) => json.encode(data.toJson());

class vendorCategoryModel {
  vendorCategoryModel({
    required this.name,
    required this.deleted,
    required this.date,
    this.id
  });


  String name;
  bool deleted;
  String? id;
  DateTime date;

  factory vendorCategoryModel.fromJson(Map<String, dynamic> json) => vendorCategoryModel(
    name: json["name"],
    deleted: json["deleted"],

    date: json["date"].toDate(),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "deleted": deleted,
    "date": date,
    "id": id,
  };
}
