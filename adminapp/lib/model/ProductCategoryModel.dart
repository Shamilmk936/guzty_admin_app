
import 'dart:convert';

productCategoryModel countryModelFromJson(String str) => productCategoryModel.fromJson(json.decode(str));

String countryModelToJson(productCategoryModel data) => json.encode(data.toJson());

class productCategoryModel {
  productCategoryModel({
    required this.name,
    required this.image,
    required this.deleted,
    required this.date,
    required this.search,
    this.id
  });


  String name;
  List search;
  String image;
  bool deleted;
  String? id;
  DateTime date;

  factory productCategoryModel.fromJson(Map<String, dynamic> json) => productCategoryModel(
    name: json["name"],
    image: json["image"],
    search: json["search"],
    deleted: json["deleted"],
    date: json["date"].toDate(),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "search": search,
    "image": image,
    "deleted": deleted,
    "date": date,
    "id": id,
  };
}
