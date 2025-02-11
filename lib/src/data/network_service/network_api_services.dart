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
        status: false, statusCode: 500, message: null, error: null, data: null);
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

  @override
  Future<ResponseModel> post(String url, dynamic data) async {
    ResponseModel response = ResponseModel(
        status: false, statusCode: 500, message: null, error: null, data: null);
    try {
      final apiResponse =
          await dioClient.dio.post(url, data: json.encode(data));
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
  Future<ResponseModel> delete(String url, dynamic data) async {
    ResponseModel response = ResponseModel(
        status: false, statusCode: 500, message: null, error: null, data: null);
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
        status: false, statusCode: 500, message: null, error: null, data: null);
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
    final decodedResponse = ResponseModel.fromJson(response.data);
    var statusCode = response.statusCode ?? 500;

    if (statusCode >= 200 && statusCode < 300) {
      return decodedResponse;
    } else if (statusCode == 400) {
      throw BadRequestException(decodedResponse.error ?? '');
    } else if (response.statusCode == 401) {
      throw UnauthorizedException(decodedResponse.error ?? '');
    } else if (response.statusCode == 404) {
      throw UnauthorizedException(decodedResponse.error ?? '');
    } else {
      throw FetchDataException(
          'Error : ${response.statusCode} ${decodedResponse.error ?? ''}');
    }
  }
}
