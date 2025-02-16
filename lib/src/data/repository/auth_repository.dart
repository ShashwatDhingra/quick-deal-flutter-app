import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';
import 'package:quickdeal/src/core/utils/ui_utils/helper.dart';

import '../../core/utils/ui_utils/constants/api_endpoints.dart';
import '../models/response_model.dart';
import '../network_service/base_api_services.dart';
import '../network_service/network_api_services.dart';

class AuthRepository {
  final BaseApiService apiService = NetworkApiService();

  Future<ResponseModel> confirmMail(Map<String, String> data) async {
    try {
      ResponseModel response =
          await apiService.post(ApiEndpionts.confirmEmailUrl, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<ResponseModel> verifyConfirmMailPin(Map<String, String> data) async {
    try {
      ResponseModel response =
          await apiService.post(ApiEndpionts.verifyConfirmMailPinUrl, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<ResponseModel?> login(String email, String password) async {
    try {
      ResponseModel response = await apiService.post(
          'https://quick-deal.onrender.com/api/v1/auth/login',
          {"email": email, "password": password});

      // Saving the TOKEN of user
      if (response.success ?? false) {
        response.message?.showToast();
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

  Future<ResponseModel> signup(Map<String, String> data) async {
    try {
      ResponseModel response =
          await apiService.post(ApiEndpionts.signupUrl, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<ResponseModel> forgetPassword(Map<String, String> data) async {
    try {
      ResponseModel resopnse =
          await apiService.post(ApiEndpionts.forgetPasswordUrl, data);
      return resopnse;
    } catch (e) {
      rethrow;
    }
  }

  Future<ResponseModel> verifyResetPasswordPin(Map<String, String> data) async {
    try {
      ResponseModel resopnse =
          await apiService.post(ApiEndpionts.verifyResetPinUrl, data);
      return resopnse;
    } catch (e) {
      rethrow;
    }
  }

  Future<ResponseModel> resetPassword(Map<String, String> data) async {
    try {
      ResponseModel resopnse =
          await apiService.post(ApiEndpionts.resetPasswordUrl, data);
      return resopnse;
    } catch (e) {
      rethrow;
    }
  }
}
