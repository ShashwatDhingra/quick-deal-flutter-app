// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ResponseModel {
  final bool? success;
  final int? statusCode;
  final String? message;
  final String? error;
  final dynamic data;

  ResponseModel({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.error,
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'success': success,
      'statusCode': statusCode,
      'message': message,
      'error': error,
      'data': data,
    };
  }

  factory ResponseModel.fromMap(Map<String, dynamic> map) {
    return ResponseModel(
        success: map['success'] ?? false,
        statusCode: map['statusCode'] ?? 500,
        message: map['message'],
        error: map['error'],
        data: map['data']);
  }

  String toJson() => json.encode(toMap());

  factory ResponseModel.fromJson(String source) =>
      ResponseModel.fromMap(source as Map<String, dynamic>);

  ResponseModel copyWith({
    bool? success,
    int? statusCode,
    String? message,
    String? error,
    String? data,
  }) {
    return ResponseModel(
      success: success ?? this.success,
      statusCode: statusCode ?? this.statusCode,
      message: message ?? this.message,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }

  ResponseModel copyWithInstance(ResponseModel response) {
    return ResponseModel(
      success: response.success ?? false,
      statusCode: response.statusCode ?? 500,
      message: response.message ?? message,
      error: response.error ?? error,
      data: response.data ?? data,
    );
  }
}
