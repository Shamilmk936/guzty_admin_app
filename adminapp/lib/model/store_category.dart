import 'dart:convert';

StoreCategoryModel storeCategoryModelFromJson(String str) =>
    StoreCategoryModel.fromJson(json.decode(str));

String storeCategoryModelToJson(StoreCategoryModel data) =>
    json.encode(data.toJson());

class StoreCategoryModel {
  String? name;
  bool? available;
  String? categoryId;
  bool? kit;
  DateTime? date;
  bool? deleted;
  List<String>? search;

  StoreCategoryModel({
    this.name,
    this.available,
    this.categoryId,
    this.kit,
    this.date,
    this.deleted,
    this.search,
  });

  StoreCategoryModel copyWith({
    String? name,
    bool? available,
    String? categoryId,
    bool? kit,
    DateTime? date,
    bool? deleted,
    List<String>? search,
  }) =>
      StoreCategoryModel(
        name: name ?? this.name,
        available: available ?? this.available,
        categoryId: categoryId ?? this.categoryId,
        kit: kit ?? this.kit,
        date: date ?? this.date,
        deleted: deleted ?? this.deleted,
        search: search ?? this.search,
      );

  factory StoreCategoryModel.fromJson(Map<String, dynamic> json) =>
      StoreCategoryModel(
        name: json["name"],
        available: json["available"],
        categoryId: json["categoryId"],
        kit: json["kit"],
        date: json["date"]?.toDate(),
        deleted: json["deleted"],
        search: json["search"] == null
            ? []
            : List<String>.from(json["search"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "available": available,
        "categoryId": categoryId,
        "kit": kit,
        "date": date,
        "deleted": deleted,
        "search":
            search == null ? [] : List<dynamic>.from(search!.map((x) => x)),
      };
}
