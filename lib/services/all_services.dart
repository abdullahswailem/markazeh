import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;

import 'package:markazeh/models/get_branches_response.dart';
import 'package:markazeh/models/get_settings_response.dart';

class AllServices with ChangeNotifier {
  final dio =
      Dio(BaseOptions(baseUrl: "https://ecashiertest.markaziaapis.com"));
  bool loading = false;
  GetBranchesResponse? branches;
  String? token;
  GetSettingsResponse? settingsResponse;
  int? branchId;

  Future<void> clearData() async {
    branchId = null;
    token = null;
    settingsResponse = null;
    branches = null;
    notifyListeners();
  }

  @override
  Future<void> getAllBranches() async {
    loading = true;
    Response result;
    result = await dio.get(
      "/api/Branch/GetBranch",
      queryParameters: {},
    );

    branches = GetBranchesResponse.fromJson(result.data);

    developer.log(result.data.toString());
    loading = false;
    notifyListeners();
  }

  @override
  Future<bool> login(String username, String pass) async {
    loading = true;
    Response result;
    result = await dio.post(
      "/api/Users/loginToken",
      data: {
        "username": username,
        "password": pass,
      },
    );
    developer.log(result.data.toString());
    if (result.statusCode == 200) {
      token = result.data['accessToken'];
      loading = false;
      notifyListeners();
      return true;
    } else {
      token = null;
      loading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> getSettingsBybranchId(int id) async {
    loading = true;

    final result = await dio.get(
      '/api/Kiosk/GetSettingsBybranchId',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token', // ← pass the token here
        },
      ),
      queryParameters: {'branchId': id},
    );

    developer.log(result.data.toString());

    if (result.statusCode == 200) {
      settingsResponse = GetSettingsResponse.fromJson(result.data);
    }

    loading = false;
    notifyListeners();
  }

  Future<bool> updateBranchServiceStatus(Services data, int id) async {
    loading = true;

    final result = await dio.put(
      '/api/Kiosk/UpdateBranchServiceStatus',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token', // ← pass the token here
        },
      ),
      data: {
        "branchId": id,
        "serviceId": data.serviceId,
        "isEnabled": data.isEnabled,
      },
    );

    developer.log(result.data.toString());

    if (result.statusCode == 200) {
      loading = false;
      notifyListeners();
      return true;
    } else {
      loading = false;
      notifyListeners();
      return false;
    }
  }
}
