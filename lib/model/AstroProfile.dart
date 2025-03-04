import 'package:astrologeradmin/model/Astrologer.dart';

class AstroProfile {
  bool? status;
  String? message;
  String? errors;
  String? error;
  int? statusCode;
  Astrologer? user;

  AstroProfile({
    this.status,
    this.message,
    this.errors,
    this.error,
    this.statusCode,
    this.user,
  });

  factory AstroProfile.fromJson(Map<String, dynamic> json) =>
      AstroProfile(
        status: json['status'] ?? false, // Default to `false` if `status` is null
        message: json['message'] ?? 'No message available',
        errors: json['errors'] ?? '',
        error: json['error'] ?? '',
        statusCode: json['status_code'] ?? 404, // Default status code for "not found"
        user: json['user'] != null
            ? Astrologer.fromJson(json['user'])
            : null,      );

  Map<String, dynamic> toJson() =>
      {
        'status': status,
        'message': message,
        'errors': errors,
        'error': error,
        'status_code': statusCode,
        'user': user,
      };


}
