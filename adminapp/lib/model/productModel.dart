// ignore_for_file: public_member_api_docs, sort_constructors_first
// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  DateTime? createdTime;
  bool? deleted;
  bool? available;
  String? name;
  List<String>? imageUrls;
  String? shortDescription;
  String? longDescription;
  double? price;
  int? leadingTime;
  String? skuSet;
  int? specialOffer;
  String? productId;
  String? vendorId;
  String? vendorName;
  String? categoryId;
  String? categoryName;
  int? oneRating;
  int? twoRating;
  int? threeRating;
  int? fourRating;
  int? fiveRating;
  bool? veg;
  bool? verified;
  List<String>? ordersType;
  int? maxOrder;
  int? minOrder;

  ProductModel({
    this.createdTime,
    this.deleted,
    this.available,
    this.name,
    this.imageUrls,
    this.shortDescription,
    this.longDescription,
    this.price,
    this.leadingTime,
    this.skuSet,
    this.specialOffer,
    this.productId,
    this.vendorId,
    this.vendorName,
    this.categoryId,
    this.categoryName,
    this.oneRating,
    this.twoRating,
    this.threeRating,
    this.fourRating,
    this.fiveRating,
    this.veg,
    this.verified,
    this.ordersType,
    this.maxOrder,
    this.minOrder,
  });

  ProductModel copyWith({
    DateTime? createdTime,
    bool? deleted,
    bool? available,
    String? name,
    List<String>? imageUrls,
    String? shortDescription,
    String? longDescription,
    double? price,
    int? leadingTime,
    String? skuSet,
    int? specialOffer,
    String? productId,
    String? vendorId,
    String? vendorName,
    String? categoryId,
    String? categoryName,
    int? oneRating,
    int? twoRating,
    int? threeRating,
    int? fourRating,
    int? fiveRating,
    bool? veg,
    bool? verified,
    List<String>? ordersType,
    int? maxOrder,
    int? minOrder,
  }) =>
      ProductModel(
        createdTime: createdTime ?? this.createdTime,
        deleted: deleted ?? this.deleted,
        available: available ?? this.available,
        name: name ?? this.name,
        imageUrls: imageUrls ?? this.imageUrls,
        shortDescription: shortDescription ?? this.shortDescription,
        longDescription: longDescription ?? this.longDescription,
        price: price ?? this.price,
        leadingTime: leadingTime ?? this.leadingTime,
        skuSet: skuSet ?? this.skuSet,
        specialOffer: specialOffer ?? this.specialOffer,
        productId: productId ?? this.productId,
        vendorId: vendorId ?? this.vendorId,
        vendorName: vendorName ?? this.vendorName,
        categoryId: categoryId ?? this.categoryId,
        categoryName: categoryName ?? this.categoryName,
        oneRating: oneRating ?? this.oneRating,
        twoRating: twoRating ?? this.twoRating,
        threeRating: threeRating ?? this.threeRating,
        fourRating: fourRating ?? this.fourRating,
        fiveRating: fiveRating ?? this.fiveRating,
        veg: veg ?? this.veg,
        verified: verified ?? this.verified,
        ordersType: ordersType ?? this.ordersType,
        maxOrder: maxOrder ?? this.maxOrder,
        minOrder: minOrder ?? this.minOrder,
      );

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    createdTime: json["createdTime"].toDate(),
    deleted: json["deleted"],
    available: json["available"],
    name: json["name"],
    imageUrls: json["imageUrls"] == null
        ? []
        : List<String>.from(json["imageUrls"]!.map((x) => x)),
    ordersType: json["ordersType"] == null
        ? []
        : List<String>.from(json["ordersType"]!.map((x) => x)),
    shortDescription: json["shortDescription"],
    longDescription: json["longDescription"],
    price: json["price"]?.toDouble() ?? 0,
    leadingTime: json["leadingTime"],
    skuSet: json["skuSet"],
    specialOffer: json["specialOffer"],
    productId: json["productId"],
    vendorId: json["vendorId"],
    vendorName: json["vendorName"],
    categoryId: json["categoryId"],
    categoryName: json["categoryName"],
    oneRating: json["oneRating"],
    twoRating: json["twoRating"],
    threeRating: json["threeRating"],
    fourRating: json["fourRating"],
    fiveRating: json["fiveRating"],
    veg: json["veg"],
    verified: json["verified"],
    maxOrder: json["maxOrder"],
    minOrder: json["minOrder"],
  );

  Map<String, dynamic> toJson() => {
    "createdTime": createdTime,
    "deleted": deleted ?? false,
    "available": available ?? true,
    "name": name,
    "imageUrls": imageUrls == null
        ? []
        : List<String>.from(imageUrls!.map((x) => x)),
    "ordersType": ordersType == null
        ? []
        : List<String>.from(ordersType!.map((x) => x)),
    "shortDescription": shortDescription,
    "longDescription": longDescription,
    "price": price,
    "leadingTime": leadingTime,
    "skuSet": skuSet,
    "specialOffer": specialOffer,
    "productId": productId,
    "vendorId": vendorId,
    "vendorName": vendorName,
    "categoryId": categoryId,
    "categoryName": categoryName,
    "oneRating": oneRating ?? 0,
    "twoRating": twoRating ?? 0,
    "threeRating": threeRating ?? 0,
    "fourRating": fourRating ?? 0,
    "fiveRating": fiveRating ?? 0,
    "veg": veg,
    "verified": verified ?? false,
    "maxOrder": maxOrder ,
    "minOrder": minOrder ,
  };
}

enum ProductStatus {
  delete,
  update,
  create,
}