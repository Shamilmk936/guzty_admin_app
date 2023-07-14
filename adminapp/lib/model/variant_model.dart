// To parse this JSON data, do
//
//     final variantModel = variantModelFromJson(jsonString);

import 'dart:convert';

VariantModel variantModelFromJson(String str) =>
    VariantModel.fromJson(json.decode(str));

String variantModelToJson(VariantModel data) => json.encode(data.toJson());

class VariantModel {
  String? variantId;
  String? name;
  DateTime? createdTime;
  bool? deleted;
  List<String>? search;

  VariantModel(
      {this.variantId, this.name, this.createdTime, this.deleted, this.search});

  VariantModel copyWith({
    String? variantId,
    String? name,
    DateTime? createdTime,
    bool? deleted,
    List<String>? search,
  }) =>
      VariantModel(
        variantId: variantId ?? this.variantId,
        name: name ?? this.name,
        createdTime: createdTime ?? this.createdTime,
        deleted: deleted ?? this.deleted,
        search: search ?? this.search,
      );

  factory VariantModel.fromJson(Map<String, dynamic> json) => VariantModel(
        variantId: json["variantId"],
        name: json["name"],
        createdTime: json["createdTime"]?.toDate(),
        deleted: json["deleted"],
        search: json["search"] == null
            ? []
            : List<String>.from(json["search"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "variantId": variantId,
        "name": name,
        "createdTime": createdTime,
        "deleted": deleted,
        "search":
            search == null ? [] : List<dynamic>.from(search!.map((x) => x)),
      };
}
