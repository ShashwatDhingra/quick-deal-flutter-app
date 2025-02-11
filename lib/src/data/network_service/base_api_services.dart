

import '../models/response_model.dart';

abstract class BaseApiService{

  Future<ResponseModel> get(String url);

  Future<ResponseModel> post(String  url, dynamic data);

  Future<ResponseModel> put(String  url, dynamic data);

  Future<ResponseModel> delete(String url, dynamic data);
}