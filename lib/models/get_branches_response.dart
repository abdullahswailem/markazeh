import 'dart:convert';

class GetBranchesResponse {
  bool success;
  String message;
  List<Datum> data;
  dynamic errorCode;

  GetBranchesResponse({
    required this.success,
    required this.message,
    required this.data,
    required this.errorCode,
  });

  factory GetBranchesResponse.fromRawJson(String str) =>
      GetBranchesResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetBranchesResponse.fromJson(Map<String, dynamic> json) =>
      GetBranchesResponse(
        success: json["success"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        errorCode: json["errorCode"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "errorCode": errorCode,
      };
}

class Datum {
  int id;
  String branchNameAr;
  String branchNameEn;
  List<Service> services;

  Datum({
    required this.id,
    required this.branchNameAr,
    required this.branchNameEn,
    required this.services,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        branchNameAr: json["branchNameAr"],
        branchNameEn: json["branchNameEn"],
        services: List<Service>.from(
            json["services"].map((x) => Service.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "branchNameAr": branchNameAr,
        "branchNameEn": branchNameEn,
        "services": List<dynamic>.from(services.map((x) => x.toJson())),
      };
}

class Service {
  int id;
  String nameEn;
  String nameAr;

  Service({
    required this.id,
    required this.nameEn,
    required this.nameAr,
  });

  factory Service.fromRawJson(String str) => Service.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        id: json["id"],
        nameEn: json["nameEn"],
        nameAr: json["nameAr"]!,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nameEn": nameEn,
        "nameAr": nameAr,
      };
}
