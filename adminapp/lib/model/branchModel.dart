// To parse this JSON data, do
//
//     final branchModel = branchModelFromJson(jsonString);

import 'dart:convert';

BranchModel branchModelFromJson(String str) => BranchModel.fromJson(json.decode(str));

String branchModelToJson(BranchModel data) => json.encode(data.toJson());

class BranchModel {
  String? name;
  String? mobileNumber;
  String? address;
  String? email;

  String? branchId;
  List<String>? search;
  List<String>? admins;

  BranchModel({
    this.name,
    this.mobileNumber,
    this.address,
    this.email,

    this.branchId,
    this.search,
    this.admins,
  });

  BranchModel copyWith({
    String? name,
    String? mobileNumber,
    String? address,
    String? email,

    String? branchId,
    List<String>? search,
    List<String>? admins,
  }) =>
      BranchModel(
        name: name ?? this.name,
        mobileNumber: mobileNumber ?? this.mobileNumber,
        address: address ?? this.address,
        email: email ?? this.email,

        branchId: branchId ?? this.branchId,
        search: search ?? this.search,
        admins: admins ?? this.admins,
      );

  factory BranchModel.fromJson(Map<String, dynamic> json) => BranchModel(
    name: json["name"],
    mobileNumber: json["mobileNumber"],
    address: json["address"],
    email: json["email"],

    branchId: json["branchId"],
    search: json["search"] == null ? [] : List<String>.from(json["search"]!.map((x) => x)),
    admins: json["admins"] == null ? [] : List<String>.from(json["admins"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "mobileNumber": mobileNumber,
    "address": address,
    "email": email,
    "branchId": branchId,
    "search": search == null ? [] : List<dynamic>.from(search!.map((x) => x)),
    "admins": admins == null ? [] : List<dynamic>.from(admins!.map((x) => x)),
  };
}

