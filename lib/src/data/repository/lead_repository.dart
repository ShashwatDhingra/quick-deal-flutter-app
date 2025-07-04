import '../../core/utils/ui_utils/constants/api_endpoints.dart';
import '../models/response_model.dart';
import '../network_service/base_api_services.dart';
import '../network_service/network_api_services.dart';

//{{devBaseUrl}}/api/v1/lead?page=1&limit=1&filters[followUpDate][gte]=2024-02-20&filters[followUpDate][lte]=2024-02-22
class LeadRepository {
  final BaseApiService apiService = NetworkApiService();

  Future<ResponseModel?> addLead(dynamic data) async {
    try {
      ResponseModel response =
          await apiService.post(ApiEndpionts.createLeadUrl, data);

      return response;
    } catch (e) {
      rethrow;
    }
  }

// Fetch Leads
  Future<ResponseModel?> fetchLead(url) async {
    try {
      var response = await apiService.get(
        ApiEndpionts.createLeadUrl + url,
      );
    //  print("call fun" + response.statusCode.toString());
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
