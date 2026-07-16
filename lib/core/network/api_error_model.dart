import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
part 'api_error_model.g.dart';

@JsonSerializable()
class ApiErrorModel {
  final String? status;
  final String? message;
  final dynamic reason;

  ApiErrorModel({this.status, this.message, this.reason});

  factory ApiErrorModel.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorModelFromJson(json);

  Map<String, dynamic> toJson() => _$ApiErrorModelToJson(this);

  static String getErrorMessage(dynamic error) {
    if (error is DioException) {
      // Server responded with an error
      if (error.response?.data != null) {
        try {
          final data = error.response?.data;
          if (data is Map<String, dynamic>) {
            final errorModel = ApiErrorModel.fromJson(data);
            return errorModel.message ?? errorModel.reason?.toString() ?? 'Request failed.';
          }
          return error.response?.data['msg'] ?? error.response?.data['message'] ?? 'Request failed.';
        } catch (_) {
          return 'Request failed with status: ${error.response?.statusCode ?? 'Unknown'}';
        }
      } else {
        return 'Network error: ${error.message}';
      }
    }

    // Any other error
    return 'Unexpected error: ${error.toString()}';
  }
}