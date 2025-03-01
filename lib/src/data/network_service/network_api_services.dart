import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:quickdeal/src/core/injections/locator.dart';

import '../../core/injections/dio_client_injection.dart';
import '../api_exception.dart';
import '../models/response_model.dart';
import 'base_api_services.dart';

class NetworkApiService extends BaseApiService {
  //** Dependency Injection **//
  final DioClientInjection dioClient = locator<DioClientInjection>();

  @override
  Future<ResponseModel> get(String url) async {
    ResponseModel response = ResponseModel(
        success: false,
        statusCode: 500,
        message: null,
        error: null,
        data: null);
    try {
      final apiResponse = await dioClient.dio.get(url);
      final res = resolveResponse(apiResponse);
      if (res.data != null || res.error != null || res.message != null) {
        response.copyWithInstance(res);
      }
    } catch (e) {
      rethrow;
    }
    return response;
  }

  Future<ResponseModel> post(String url, dynamic data) async {
    ResponseModel response = ResponseModel(
        success: false,
        statusCode: 500,
        message: null,
        error: null,
        data: null);

    try {
      final apiResponse =
          await dioClient.dio.post(url, data: json.encode(data));
      return resolveResponse(apiResponse);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ResponseModel> delete(String url, dynamic data) async {
    ResponseModel response = ResponseModel(
        success: false,
        statusCode: 500,
        message: null,
        error: null,
        data: null);
    try {
      final apiResponse =
          await dioClient.dio.delete(url, data: json.encode(data));

      final res = resolveResponse(apiResponse);
      if (res.data != null || res.error != null || res.message != null) {
        response.copyWithInstance(res);
      }
    } catch (e) {
      rethrow;
    }

    return response;
  }

  @override
  Future<ResponseModel> put(String url, dynamic data) async {
    ResponseModel response = ResponseModel(
        success: false,
        statusCode: 500,
        message: null,
        error: null,
        data: null);
    try {
      final apiResponse = await dioClient.dio.put(url, data: json.encode(data));

      final res = resolveResponse(apiResponse);
      if (res.data != null || res.error != null || res.message != null) {
        response.copyWithInstance(res);
      }
    } catch (e) {
      rethrow;
    }

    return response;
  }

  ResponseModel resolveResponse(Response response) {
    final decodedResponse = ResponseModel.fromMap(response.data);
    var statusCode = response.statusCode ?? 500;
    // Every this this case will get true because
    if (statusCode >= 200 && statusCode < 300) {
      return decodedResponse;
    }
    // Here all these cases are itself handled by DioException. We actually dont need to handle them exception.
    else if (statusCode == 400 || statusCode == 401) {
      throw UnauthorizedException(
          decodedResponse.error ?? 'Invalid credentials');
    } else if (statusCode == 403) {
      throw UnauthorizedException(decodedResponse.error ?? 'Access denied');
    } else if (statusCode == 404) {
      throw NotFoundException(
          decodedResponse.error ?? 'API endpoint not found');
    } else {
      throw FetchDataException(
          'Error: $statusCode - ${decodedResponse.error ?? 'Unknown error'}');
    }
  }
}
