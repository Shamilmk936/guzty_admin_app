// To parse this JSON data, do
//
//     final runnerModel = runnerModelFromJson(jsonString);

import 'dart:convert';

RunnerModel runnerModelFromJson(String str) =>
    RunnerModel.fromJson(json.decode(str));

String runnerModelToJson(RunnerModel data) => json.encode(data.toJson());

class RunnerModel {
  String? name;
  String? mobileNumber;
  String? email;
  String? rejectedReason;
  String? password;
  String? branchId;
  int? status;
  DateTime? createdTime;
  bool? available;
  bool? delete;
  BankDetails? bankDetails;
  double? guztyCash;
  DateTime? cashInHandUpdate;
  Map<String, dynamic>? documents;
  List<String>? search;
  double? earnings;
  DateTime? earningsUpdate;
  double? tips;
  DateTime? tipsUpdate;
  String? uid;
  bool? verified;
  double? walletBalance;
  DateTime? walletUpdate;

  RunnerModel({
    this.name,
    this.mobileNumber,
    this.email,
    this.rejectedReason,
    this.status,
    this.branchId,
    this.password,
    this.createdTime,
    this.available,
    this.delete,
    this.bankDetails,
    this.guztyCash,
    this.cashInHandUpdate,
    this.documents,
    this.search,
    this.earnings,
    this.earningsUpdate,
    this.tips,
    this.tipsUpdate,
    this.uid,
    this.verified,
    this.walletBalance,
    this.walletUpdate,
  });

  RunnerModel copyWith({
    String? name,
    String? mobileNumber,
    String? email,
    String? branchId,
    String? rejectedReason,
    int? status,
    String? password,
    DateTime? createdTime,
    bool? available,
    bool? delete,
    BankDetails? bankDetails,
    double? guztyCash,
    DateTime? cashInHandUpdate,
    Map<String, dynamic>? documents,
    List<String>? search,
    double? earnings,
    DateTime? earningsUpdate,
    double? tips,
    DateTime? tipsUpdate,
    String? uid,
    bool? verified,
    double? walletBalance,
    DateTime? walletUpdate,
  }) =>
      RunnerModel(
        name: name ?? this.name,
        branchId: branchId ?? this.branchId,
        mobileNumber: mobileNumber ?? this.mobileNumber,
        email: email ?? this.email,
        rejectedReason: rejectedReason ?? this.rejectedReason,
        status: status ?? this.status,
        password: password ?? this.password,
        createdTime: createdTime ?? this.createdTime,
        available: available ?? this.available,
        delete: delete ?? this.delete,
        bankDetails: bankDetails ?? this.bankDetails,
        guztyCash: guztyCash ?? this.guztyCash,
        cashInHandUpdate: cashInHandUpdate ?? this.cashInHandUpdate,
        documents: documents ?? this.documents,
        search: search ?? this.search,
        earnings: earnings ?? this.earnings,
        earningsUpdate: earningsUpdate ?? this.earningsUpdate,
        tips: tips ?? this.tips,
        tipsUpdate: tipsUpdate ?? this.tipsUpdate,
        uid: uid ?? this.uid,
        verified: verified ?? this.verified,
        walletBalance: walletBalance ?? this.walletBalance,
        walletUpdate: walletUpdate ?? this.walletUpdate,
      );

  factory RunnerModel.fromJson(Map<String, dynamic> json) => RunnerModel(
        name: json["name"],
        branchId: json["branchId"],
        mobileNumber: json["mobileNumber"],
        email: json["email"],
        rejectedReason: json["rejectedReason"],
        password: json["password"],
        status: json["status"],
        createdTime: json["createdTime"].toDate(),
        available: json["available"],
        delete: json["delete"],
        bankDetails: json["bankDetails"] == null
            ? null
            : BankDetails.fromJson(json["bankDetails"]),
        guztyCash: json["guztyCash"],
        cashInHandUpdate: json["cashInHandUpdate"] == null
            ? null
            : json["cashInHandUpdate"].toDate(),
        documents: json["documents"],
        search: json["search"] == null
            ? []
            : List<String>.from(json["search"]!.map((x) => x)),
        earnings: json["earnings"],
        earningsUpdate: json["earningsUpdate"] == null
            ? null
            : json["earningsUpdate"].toDate(),
        tips: json["tips"],
        tipsUpdate:
            json["tipsUpdate"] == null ? null : json["tipsUpdate"].toDate(),
        uid: json["uid"],
        verified: json["verified"],
        walletBalance: json["walletBalance"],
        walletUpdate:
            json["walletUpdate"] == null ? null : json["walletUpdate"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "branchId": branchId,
        "mobileNumber": mobileNumber,
        "email": email,
        "rejectedReason": rejectedReason,
        "status": status,
        "password": password,
        "createdTime": createdTime,
        "available": available,
        "delete": delete,
        "bankDetails": bankDetails?.toJson(),
        "guztyCash": guztyCash,
        "cashInHandUpdate": cashInHandUpdate,
        "documents": documents ?? {},
        "search":
            search == null ? [] : List<dynamic>.from(search!.map((x) => x)),
        "earnings": earnings,
        "earningsUpdate": earningsUpdate,
        "tips": tips,
        "tipsUpdate": tipsUpdate,
        "uid": uid,
        "verified": verified,
        "walletBalance": walletBalance,
        "walletUpdate": walletUpdate,
      };
}

class BankDetails {
  String? acctNo;
  String? bank;
  String? branch;
  String? ifsc;
  String? name;

  BankDetails({
    this.acctNo,
    this.bank,
    this.ifsc,
    this.branch,
    this.name,
  });

  BankDetails copyWith({
    String? acctNo,
    String? bank,
    String? ifsc,
    String? branch,
    String? name,
  }) =>
      BankDetails(
        acctNo: acctNo ?? this.acctNo,
        bank: bank ?? this.bank,
        ifsc: ifsc ?? this.ifsc,
        branch: branch ?? this.branch,
        name: name ?? this.name,
      );

  factory BankDetails.fromJson(Map<String, dynamic> json) => BankDetails(
        acctNo: json["acctNo"],
        bank: json["bank"],
        branch: json["branch"],
        ifsc: json["ifsc"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "acctNo": acctNo,
        "bank": bank,
        "ifsc": ifsc,
        "branch": branch,
        "name": name,
      };
}

class Documents {
  String? drivingLicense;
  String? rcCopy;
  String? aadhar;

  Documents({
    this.drivingLicense,
    this.rcCopy,
    this.aadhar,
  });

  Documents copyWith({
    String? drivingLicense,
    String? rcCopy,
    String? aadhar,
  }) =>
      Documents(
        drivingLicense: drivingLicense ?? this.drivingLicense,
        rcCopy: rcCopy ?? this.rcCopy,
        aadhar: aadhar ?? this.aadhar,
      );

  factory Documents.fromJson(Map<String, dynamic> json) => Documents(
        drivingLicense: json["drivingLicense"],
        rcCopy: json["rcCopy"],
        aadhar: json["aadhar"],
      );

  Map<String, dynamic> toJson() => {
        "drivingLicense": drivingLicense,
        "rcCopy": rcCopy,
        "aadhar": aadhar,
      };
}
