import 'package:flutter/foundation.dart';
import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';
import 'package:quickdeal/src/core/utils/ui_utils/helper.dart';

import '../../core/utils/ui_utils/constants/api_endpoints.dart';
import '../models/response_model.dart';
import '../network_service/base_api_services.dart';
import '../network_service/network_api_services.dart';

class AuthRepository {
  final BaseApiService apiService = NetworkApiService();

  Future<ResponseModel> confirmMail(String email) async {
    try {
      ResponseModel response =
          await apiService.post(ApiEndpionts.confirmEmailUrl, {'email': email});
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<ResponseModel> verifyConfirmMailPin(String email, int pin) async {
    try {
      ResponseModel response = await apiService.post(
          ApiEndpionts.verifyConfirmMailPinUrl, {'email': email, 'pin': pin});
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<ResponseModel?> login(String email, String password) async {
    try {
      ResponseModel response = await apiService
          .post(ApiEndpionts.loginUrl, {"email": email, "password": password});

      // Saving the TOKEN of user
      if (response.success ?? false) {
        if (!await AuthPrefHelper.saveUserToken(response.data['token'])) {
          "Something went wrong".showErrorToast();
          return null;
        }
      }
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<ResponseModel?> signup(
      {required String name,
      required String email,
      required String password}) async {
    try {
      ResponseModel response = await apiService.post(ApiEndpionts.signupUrl, {
        'name': name,
        'email': email,
        'password': password,
      });

      // Saving the TOKEN of user
      if (response.success ?? false) {
        if (!await AuthPrefHelper.saveUserToken(response.data['token'])) {
          "Something went wrong".showErrorToast();
          return null;
        }
      }
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<ResponseModel> forgetPassword(String email) async {
    try {
      ResponseModel resopnse = await apiService
          .post(ApiEndpionts.forgetPasswordUrl, {"email": email});
      return resopnse;
    } catch (e) {
      rethrow;
    }
  }

  Future<ResponseModel> verifyResetPasswordPin(String email, int pin) async {
    try {
      ResponseModel resopnse = await apiService
          .post(ApiEndpionts.verifyResetPinUrl, {"email": email, "pin": pin});
      return resopnse;
    } catch (e) {
      rethrow;
    }
  }

  Future<ResponseModel> resetPassword(String email, String password) async {
    try {
      if (kDebugMode) {
        print('${email}');
      }
      ResponseModel resopnse = await apiService.post(
          ApiEndpionts.resetPasswordUrl,
          {"email": email, "password": password});
      return resopnse;
    } catch (e) {
      rethrow;
    }
  }

  Future<ResponseModel> sendFirebaseToken(String email, String firebaseToken)async{
     try {
      ResponseModel resopnse = await apiService.post(
          ApiEndpionts.sendFirebaseToken,
          {"email": email, "firebaseToken": firebaseToken});
      return resopnse;
    } catch (e) {
      rethrow;
    }
  }
}
