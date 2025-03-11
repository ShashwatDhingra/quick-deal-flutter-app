import 'package:quickdeal/src/data/models/property_model.dart';

import '../../core/utils/ui_utils/constants/api_endpoints.dart';
import '../models/response_model.dart';
import '../network_service/base_api_services.dart';
import '../network_service/network_api_services.dart';

class PropertyRepository {
  final BaseApiService apiService = NetworkApiService();

  Future<ResponseModel?> addProperty(PropertyModel property) async {
    try {
      ResponseModel response =
          await apiService.post(ApiEndpionts.propertyUrl, property.toJson());
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<ResponseModel?> fetchProperty(String filter) async {
    try {
      ResponseModel response = await apiService.get(ApiEndpionts.propertyUrl + filter);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
