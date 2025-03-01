import 'package:quickdeal/src/core/utils/ui_utils/extensions.dart';
import 'package:quickdeal/src/core/utils/ui_utils/helper.dart';
import 'package:quickdeal/src/data/models/property_mode.dart';

import '../../core/utils/ui_utils/constants/api_endpoints.dart';
import '../models/response_model.dart';
import '../network_service/base_api_services.dart';
import '../network_service/network_api_services.dart';

class PropertyRepository {
  final BaseApiService apiService = NetworkApiService();

  Future<ResponseModel?> addProperty(Property property) async {
    print(property.toJson());
    try {
      ResponseModel response =
          await apiService.post(ApiEndpionts.addPropertyUrl, property.toJson());
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
