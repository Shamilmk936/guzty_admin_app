// To parse this JSON data, do
//
//     final vendorModel = vendorModelFromJson(jsonString);

import 'dart:convert';

VendorModel vendorModelFromJson(String str) =>
    VendorModel.fromJson(json.decode(str));

String vendorModelToJson(VendorModel data) => json.encode(data.toJson());

class VendorModel {
  String? categoryId;
  String? categoryName;
  String? shopName;
  String? city;
  String? fssaiNumber;
  String? ownerName;
  String? contactNumber;
  String? contactNumber2;
  String? ownerEmail;
  String? id;
  String? password;
  DateTime? createdTime;
  double? commission;
  bool? deleted;
  bool? verified;
  bool? rejected;
  bool? available;
  Map? position;
  double? lat;
  double? long;
  Map<String, dynamic>? document;
  String? rejectReason;
  String? countryShortName;
  String? countryCode;
  String? countryShortName2;
  String? countryCode2;
  List? ordersType;
  List? productCategories;
  String? image;
  String? description;
  String? branch;
  String? branchId;

  VendorModel({
    this.categoryId,
    this.categoryName,
    this.shopName,
    this.city,
    this.fssaiNumber,
    this.ownerName,
    this.contactNumber,
    this.contactNumber2,
    this.ownerEmail,
    this.id,
    this.password,
    this.createdTime,
    this.commission,
    this.deleted,
    this.verified,
    this.rejected,
    this.available,
    this.position,
    this.document,
    this.lat,
    this.long,
    this.rejectReason,
    this.countryCode,
    this.countryCode2,
    this.countryShortName,
    this.countryShortName2,
    this.ordersType,
    this.productCategories,
    this.image,
    this.description,
    this.branch,
    this.branchId,
  });

  VendorModel copyWith({
    String? categoryId,
    String? categoryName,
    String? shopName,
    String? city,
    String? fssaiNumber,
    String? ownerName,
    String? contactNumber,
    String? contactNumber2,
    String? ownerEmail,
    String? id,
    String? password,
    DateTime? createdTime,
    double? commission,
    bool? deleted,
    bool? verified,
    bool? rejected,
    bool? available,
    Map? position,
    double? lat,
    double? long,
    Map<String, dynamic>? document,
    String? rejectReason,
    String? countryCode,
    String? countryCode2,
    String? countryShortName,
    String? countryShortName2,
    List? ordersType,
    List? productCategories,
    String? image,
    String? description,
    String? branch,
    String? branchId,
  }) =>
      VendorModel(
        categoryId: categoryId ?? this.categoryId,
        categoryName: categoryName ?? this.categoryName,
        shopName: shopName ?? this.shopName,
        city: city ?? this.city,
        fssaiNumber: fssaiNumber ?? this.fssaiNumber,
        ownerName: ownerName ?? this.ownerName,
        contactNumber: contactNumber ?? this.contactNumber,
        contactNumber2: contactNumber2 ?? this.contactNumber2,
        ownerEmail: ownerEmail ?? this.ownerEmail,
        id: id ?? this.id,
        password: password ?? this.password,
        createdTime: createdTime ?? this.createdTime,
        commission: commission ?? this.commission,
        deleted: deleted ?? this.deleted,
        verified: verified ?? this.verified,
        rejected: rejected ?? this.rejected,
        available: available ?? this.available,
        position: position ?? this.position,
        lat: lat ?? this.lat,
        long: long ?? this.long,
        document: document ?? this.document,
        rejectReason: rejectReason ?? this.rejectReason,
        countryCode: countryCode ?? this.countryCode,
        countryCode2: countryCode2 ?? this.countryCode2,
        countryShortName: countryShortName ?? this.countryShortName,
        countryShortName2: countryShortName2 ?? this.countryShortName2,
        ordersType: ordersType ?? this.ordersType,
        productCategories: productCategories ?? this.productCategories,
        image: image ?? this.image,
        description: description ?? this.description,
        branch: branch ?? this.branch,
        branchId: branchId ?? this.branchId,
      );

  factory VendorModel.fromJson(Map<String, dynamic> json) => VendorModel(
    categoryId: json["categoryId"],
    categoryName: json["categoryName"],
    shopName: json["shopName"] ?? '',
    city: json["city"] ?? '',
    fssaiNumber: json["fssaiNumber"] ?? '',
    ownerName: json["ownerName"] ?? '',
    contactNumber: json["contactNumber"] ?? '',
    contactNumber2: json["contactNumber2"] ?? '',
    ownerEmail: json["ownerEmail"] ?? '',
    id: json["id"],
    password: json["password"],
    createdTime: json["createdTime"].toDate(),
    commission: double.tryParse(json["commission"].toString()),
    deleted: json["deleted"],
    verified: json["verified"],
    rejected: json["rejected"],
    available: json["available"],
    position: json["position"],
    lat: double.tryParse(json["lat"].toString()),
    long: double.tryParse(json["long"].toString()),
    document: json["document"],
    rejectReason: json["rejectReason"],
    countryCode: json["countryCode"],
    countryCode2: json["countryCode2"],
    countryShortName: json["countryShortName"],
    countryShortName2: json["countryShortName2"],
    ordersType: json["ordersType"] == null
        ? []
        : List<String>.from(json["ordersType"]!.map((x) => x)),
    productCategories: json["productCategories"] == null
        ? []
        : List<String>.from(json["productCategories"]!.map((x) => x)),
    image: json['image'],
    description: json['description'],
    branch: json['branch'],
    branchId: json['branchId'],
  );

  Map<String, dynamic> toJson() => {
    "categoryId": categoryId,
    "categoryName": categoryName,
    "shopName": shopName,
    "city": city,
    "fssaiNumber": fssaiNumber,
    "ownerName": ownerName,
    "contactNumber": contactNumber,
    "contactNumber2": contactNumber2,
    "ownerEmail": ownerEmail,
    "id": id,
    "password": password,
    "createdTime": createdTime,
    "commission": double.tryParse(commission.toString()) ?? 0,
    "deleted": deleted ?? false,
    "verified": verified ?? false,
    "rejected": rejected ?? false,
    "available": available ?? true,
    "position": position,
    "lat": lat ?? 0,
    "long": long ?? 0,
    "document": document,
    "rejectReason": rejectReason,
    "countryCode": countryCode,
    "countryCode2": countryCode2,
    "countryShortName": countryShortName,
    "countryShortName2": countryShortName2,
    "ordersType": ordersType == null
        ? []
        : List<dynamic>.from(ordersType!.map((x) => x)),
    "productCategories": productCategories == null
        ? []
        : List<dynamic>.from(productCategories!.map((x) => x)),
    "image": image,
    "description": description,
    "branch": branch,
    "branchId": branchId,
  };
}