// To parse this JSON data, do
//
//     final variantModel = variantModelFromJson(jsonString);

// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

CategoryProductModel CategoryProductModelFromJson(String str) =>
    CategoryProductModel.fromJson(json.decode(str));

String CategoryProductModelToJson(CategoryProductModel data) =>
    json.encode(data.toJson());

class CategoryProductModel {
  String? productId;
  String? categoryId;
  String? categoryName;
  String? name;
  String? shortDescription;
  bool? deleted;
  bool? available;
  bool? combo;
  List<String>? search;
  List<String>? image;
  List<String>? inside;
  DateTime? createdTime;
  double? price;

  CategoryProductModel(
      {this.productId,
      this.name,
      this.createdTime,
      this.deleted,
      this.search,
      this.available,
      this.categoryId,
      this.categoryName,
      this.combo,
      this.image,
      this.inside,
      this.price,
      this.shortDescription});

  CategoryProductModel copyWith(
          {String? shortDescription,
          String? name,
          String? productId,
          String? categoryId,
          String? categoryName,
          bool? deleted,
          bool? available,
          bool? combo,
          List<String>? search,
          List<String>? image,
          List<String>? inside,
          DateTime? createdTime,
          double? price}) =>
      CategoryProductModel(
          shortDescription: shortDescription ?? this.shortDescription,
          productId: productId ?? this.productId,
          categoryId: categoryId ?? this.categoryId,
          categoryName: categoryName ?? this.categoryName,
          name: name ?? this.name,
          deleted: deleted ?? this.deleted,
          available: available ?? this.available,
          combo: combo ?? this.combo,
          createdTime: createdTime ?? this.createdTime,
          search: search ?? this.search,
          image: image ?? this.image,
          inside: inside ?? this.inside,
          price: price ?? this.price);

  factory CategoryProductModel.fromJson(Map<String, dynamic> json) =>
      CategoryProductModel(
        shortDescription: json["shortDescription"],
        productId: json["productId"],
        categoryId: json["categoryId"],
        categoryName: json["categoryName"],
        name: json["name"],
        deleted: json["deleted"],
        available: json["available"],
        combo: json["combo"],
        createdTime: json["createdTime"]?.toDate(),
        search: json["search"] == null
            ? []
            : List<String>.from(json["search"]!.map((x) => x)),
        image: json["image"] == null
            ? []
            : List<String>.from(json["image"]!.map((x) => x)),
        inside: json["inside"] == null
            ? []
            : List<String>.from(json["inside"]!.map((x) => x)),
        price: double.tryParse(json["price"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "shortDescription": shortDescription,
        "productId": productId,
        "categoryId": categoryId,
        "categoryName": categoryName,
        "name": name,
        "createdTime": createdTime,
        "deleted": deleted,
        "available": available,
        "combo": combo,
        "search":
            search == null ? [] : List<dynamic>.from(search!.map((x) => x)),
        "image": image == null ? [] : List<dynamic>.from(image!.map((x) => x)),
        "inside":
            inside == null ? [] : List<dynamic>.from(inside!.map((x) => x)),
        "price": price ?? 0,
      };
}
