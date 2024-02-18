import 'dart:io';

import 'package:smartpay/src/core/api_client.dart';
import 'package:smartpay/src/core/endpoints.dart';
import 'package:smartpay/src/core/request_res.dart';
import 'package:smartpay/src/features/auth/data/model/login_response.dart';
import 'package:smartpay/src/features/auth/data/model/register_request.dart';
import 'package:smartpay/src/utils/service_locator.dart';

class AuthRepository {
  Future<RequestRes> registration(RegisterRequest request) async {
    final client = locator.get<ApiClient>();
    try {
      final response = await client.post(Endpoints.register, data: request.toJson());
      final resp = LoginResponse.fromJson(response);
      return RequestRes(response: resp);
    } catch (e) {
      return RequestRes(error: ErrorRes(message: e.toString()));
    }
  }

  Future<RequestRes> login(String email, String password) async {
    final client = locator.get<ApiClient>();
    try {
      final response = await client.post(Endpoints.login, data: {
        "email": email,
        "password": password,
        "device_name": Platform.localeName
      }).then((value) => value['data']);
      final resp = LoginResponse.fromJson(response);
      return RequestRes(response: resp);
    } catch (e) {
      return RequestRes(error: ErrorRes(message: e.toString()));
    }
  }

  Future<RequestRes> getEmailTokem(String email) async {
    final client = locator.get<ApiClient>();
    try {
      final response =
          await client.post(Endpoints.getEmailToken, data: {"email": email}).then((value) => value['data']['token']);

      return RequestRes(response: response);
    } catch (e) {
      return RequestRes(error: ErrorRes(message: e.toString()));
    }
  }

  Future<RequestRes> verifyEmailTokem(String email, String token) async {
    final client = locator.get<ApiClient>();
    try {
      final response = await client
          .post(Endpoints.verifyEmailToken, data: {"email": email, "token": token}).then((value) => value['message']);

      return RequestRes(response: response);
    } catch (e) {
      return RequestRes(error: ErrorRes(message: e.toString()));
    }
  }

  Future<RequestRes> dashboard(String token) async {
    final client = locator.get<ApiClient>();
    try {
      final response = await client.get(Endpoints.home, headers: {
        'Content-type': 'application/json',
        "Accept": "application/json",
        'Authorization': 'Bearer $token',
      }).then((value) => value['data']['secret']);

      return RequestRes(response: response);
    } catch (e) {
      return RequestRes(error: ErrorRes(message: e.toString()));
    }
  }

  Future<RequestRes> logout() async {
    final client = locator.get<ApiClient>();
    try {
      final response = await client.post(Endpoints.login, data: {}).then((value) => value['message']);
      return RequestRes(response: response);
    } catch (e) {
      return RequestRes(error: ErrorRes(message: e.toString()));
    }
  }
}
