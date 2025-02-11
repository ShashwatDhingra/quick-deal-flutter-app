
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

  Future<ResponseModel> login(Map<String, String> data) async {
    try {
      ResponseModel response = await apiService.post(ApiEndpionts.loginUrl, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<ResponseModel> signup(Map<String, String> data) async {
    try {
      ResponseModel response = await apiService.post(ApiEndpionts.signupUrl, data);
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
