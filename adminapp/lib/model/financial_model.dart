// To parse this JSON data, do
//
//     final financialModel = financialModelFromJson(jsonString);

import 'dart:convert';

FinancialModel financialModelFromJson(String str) =>
    FinancialModel.fromJson(json.decode(str));

String financialModelToJson(FinancialModel data) => json.encode(data.toJson());

class FinancialModel {
  double amount;
  DateTime date;
  String mbuid;
  String narration;
  int type;
  String userId;
  String userName;
  String id;
  List<String>? search;

  FinancialModel({
    required this.amount,
    required this.date,
    required this.mbuid,
    required this.narration,
    required this.type,
    required this.userId,
    required this.userName,
    required this.id,
    required this.search,
  });

  FinancialModel copyWith({
    double? amount,
    DateTime? date,
    String? mbuid,
    String? narration,
    int? type,
    String? userId,
    String? userName,
    String? id,
    List<String>? search,
  }) =>
      FinancialModel(
        amount: amount ?? this.amount,
        date: date ?? this.date,
        mbuid: mbuid ?? this.mbuid,
        search: search ?? this.search,
        narration: narration ?? this.narration,
        type: type ?? this.type,
        userId: userId ?? this.userId,
        userName: userName ?? this.userName,
        id: id ?? this.id,
      );

  factory FinancialModel.fromJson(Map<String, dynamic> json) => FinancialModel(
        amount: json["amount"]?.toDouble(),
        date: json["date"].toDate(),
        mbuid: json["mbuid"],
        narration: json["narration"],
        type: json["type"],
        userId: json["userId"],
        userName: json["userName"],
        id: json["id"],
        search: json["search"] == null
            ? []
            : List<String>.from(json["search"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "date": date,
        "mbuid": mbuid,
        "narration": narration,
        "type": type,
        "userId": userId,
        "userName": userName,
        "id": id,
        "search":
            search == null ? [] : List<String>.from(search!.map((x) => x)),
      };
}
