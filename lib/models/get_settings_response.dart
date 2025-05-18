import 'dart:convert';

class GetSettingsResponse {
  bool success;
  String message;
  Data data;
  dynamic errorCode;

  GetSettingsResponse({
    required this.success,
    required this.message,
    required this.data,
    required this.errorCode,
  });

  factory GetSettingsResponse.fromRawJson(String str) =>
      GetSettingsResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetSettingsResponse.fromJson(Map<String, dynamic> json) =>
      GetSettingsResponse(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
        errorCode: json["errorCode"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
        "errorCode": errorCode,
      };
}

class Data {
  int branchId;
  String branchNameAr;
  String branchNameEn;
  List<Services> services;

  Data({
    required this.branchId,
    required this.branchNameAr,
    required this.branchNameEn,
    required this.services,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        branchId: json["branchId"],
        branchNameAr: json["branchNameAr"],
        branchNameEn: json["branchNameEn"],
        services: List<Services>.from(
            json["services"].map((x) => Services.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "branchId": branchId,
        "branchNameAr": branchNameAr,
        "branchNameEn": branchNameEn,
        "services": List<dynamic>.from(services.map((x) => x.toJson())),
      };
}

class Services {
  int serviceId;
  String serviceNameEn;
  String serviceNameAr;
  bool isEnabled;

  Services({
    required this.serviceId,
    required this.serviceNameEn,
    required this.serviceNameAr,
    required this.isEnabled,
  });

  factory Services.fromRawJson(String str) =>
      Services.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Services.fromJson(Map<String, dynamic> json) => Services(
        serviceId: json["serviceId"],
        serviceNameEn: json["serviceNameEn"],
        serviceNameAr: json["serviceNameAr"],
        isEnabled: json["isEnabled"],
      );

  Map<String, dynamic> toJson() => {
        "serviceId": serviceId,
        "serviceNameEn": serviceNameEn,
        "serviceNameAr": serviceNameAr,
        "isEnabled": isEnabled,
      };
}
