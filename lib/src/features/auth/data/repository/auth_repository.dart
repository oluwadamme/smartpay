import 'dart:io';

import 'package:smartpay/src/core/api_client.dart';
import 'package:smartpay/src/core/endpoints.dart';
import 'package:smartpay/src/core/request_res.dart';
import 'package:smartpay/src/features/auth/data/model/login_response.dart';
import 'package:smartpay/src/features/auth/data/model/register_request.dart';

class AuthRepository extends ApiClient {
  Future<RequestRes> registration(RegisterRequest request) async {
    try {
      final response = await post(Endpoints.register, data: request.toJson());
      final resp = LoginResponse.fromJson(response);
      return RequestRes(response: resp);
    } catch (e) {
      return RequestRes(error: ErrorRes(message: e.toString()));
    }
  }

  Future<RequestRes> login(String email, String password) async {
    try {
      final response =
          await post(Endpoints.login, data: {"email": email, "password": password, "device_name": Platform.localeName})
              .then((value) => value['data']);
      final resp = LoginResponse.fromJson(response);
      return RequestRes(response: resp);
    } catch (e) {
      return RequestRes(error: ErrorRes(message: e.toString()));
    }
  }

  Future<RequestRes> getEmailTokem(String email) async {
    try {
      final response =
          await post(Endpoints.getEmailToken, data: {"email": email}).then((value) => value['data']['token']);

      return RequestRes(response: response);
    } catch (e) {
      return RequestRes(error: ErrorRes(message: e.toString()));
    }
  }

  Future<RequestRes> verifyEmailTokem(String email, String token) async {
    try {
      final response = await post(Endpoints.verifyEmailToken, data: {"email": email, "token": token})
          .then((value) => value['message']);

      return RequestRes(response: response);
    } catch (e) {
      return RequestRes(error: ErrorRes(message: e.toString()));
    }
  }
}
