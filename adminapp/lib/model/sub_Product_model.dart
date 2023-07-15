// To parse this JSON data, do
//
//     final variantModel = variantModelFromJson(jsonString);

// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

SubProductModel SubProductModelFromJson(String str) =>
    SubProductModel.fromJson(json.decode(str));

String SubProductModelToJson(SubProductModel data) =>
    json.encode(data.toJson());

class SubProductModel {
  String? subProductId;
  String? name;
  String? image;
  DateTime? createdTime;
  bool? deleted;
  bool? available;
  List<String>? search;

  SubProductModel(
      {this.subProductId,
      this.name,
      this.image,
      this.createdTime,
      this.deleted,
      this.search,
      this.available});

  SubProductModel copyWith({
    String? subProductId,
    String? name,
    String? image,
    DateTime? createdTime,
    bool? deleted,
    bool? available,
    List<String>? search,
  }) =>
      SubProductModel(
        subProductId: subProductId ?? subProductId,
        name: name ?? this.name,
        image: image ?? this.image,
        createdTime: createdTime ?? this.createdTime,
        deleted: deleted ?? this.deleted,
        available: available ?? this.available,
        search: search ?? this.search,
      );

  factory SubProductModel.fromJson(Map<String, dynamic> json) =>
      SubProductModel(
        subProductId: json["subProductId"],
        name: json["name"],
        image: json["image"],
        createdTime: json["createdTime"]?.toDate(),
        deleted: json["deleted"],
        available: json["available"],
        search: json["search"] == null
            ? []
            : List<String>.from(json["search"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "subProductId": subProductId,
        "name": name,
        "image": image,
        "createdTime": createdTime,
        "deleted": deleted,
        "available": available,
        "search":
            search == null ? [] : List<dynamic>.from(search!.map((x) => x)),
      };
}
