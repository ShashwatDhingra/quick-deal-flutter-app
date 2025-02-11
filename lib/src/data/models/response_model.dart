// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ResponseModel {
  final bool? status;
  final int? statusCode;
  final String? message;
  final String? error;
  final String? data;

  ResponseModel({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.error,
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'statusCode': statusCode,
      'message': message,
      'error': error,
      'data': data,
    };
  }

  factory ResponseModel.fromMap(Map<String, dynamic> map) {
    return ResponseModel(
        status: map['status'] ?? false,
        statusCode: map['statusCode'] ?? 500,
        message: map['message'],
        error: map['error'],
        data: map['data']);
  }

  String toJson() => json.encode(toMap());

  factory ResponseModel.fromJson(String source) =>
      ResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  ResponseModel copyWith({
    bool? status,
    int? statusCode,
    String? message,
    String? error,
    String? data,
  }) {
    return ResponseModel(
      status: status ?? this.status,
      statusCode: statusCode ?? this.statusCode,
      message: message ?? this.message,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }

  ResponseModel copyWithInstance(ResponseModel response) {
    return ResponseModel(
      status: response.status ?? false,
      statusCode: response.statusCode ?? 500,
      message: response.message ?? message,
      error: response.error ?? error,
      data: response.data ?? data,
    );
  }
}
