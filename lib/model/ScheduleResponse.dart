import 'ScheduleData.dart';

class ScheduleResponse {
  bool? status;
  String? message;
  String? errors;
  String? error;
  int? statusCode;
  final List<ScheduleData>? data;

  ScheduleResponse({
    this.status,
    this.message,
    this.errors,
    this.error,
    this.statusCode,
    this.data,
  });

  factory ScheduleResponse.fromJson(Map<String, dynamic> json) =>
      ScheduleResponse(
        status: json['status'] ?? false, // Default to `false` if `status` is null
        message: json['message'] ?? 'No message available',
        errors: json['errors'] ?? '',
        error: json['error'] ?? '',
        statusCode: json['status_code'] ?? 404, // Default status code for "not found"
        data: (json['data'] as List<dynamic>?)
            ?.map((e) => ScheduleData.fromJson(e as Map<String, dynamic>))
            .toList(),      );

  Map<String, dynamic> toJson() =>
      {
        'status': status,
        'message': message,
        'errors': errors,
        'error': error,
        'status_code': statusCode,
        'data': data,
      };

  @override
  String toString() {
    return 'CommonResponse{status: $status, message: $message, errors: $errors, status_code: $statusCode, data: $data}';
  }
}
