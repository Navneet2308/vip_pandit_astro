import 'Followers.dart';

class AstroFollowers {
  bool? status;
  String? message;
  String? errors;
  String? error;
  int? statusCode;
  List<Followers>? followers;

  AstroFollowers({
    this.status,
    this.message,
    this.errors,
    this.error,
    this.statusCode,
    this.followers,
  });

  factory AstroFollowers.fromJson(Map<String, dynamic> json) => AstroFollowers(
    status: json['status'] ?? false, // Default to `false` if `status` is null
    message: json['message'] ?? 'No message available',
    errors: json['errors'] ?? '',
    error: json['error'] ?? '',
    statusCode: json['status_code'] ?? 404, // Default status code for "not found"
    followers: json['data'] != null
        ? (json['data'] as List<dynamic>)
        .map((item) => Followers.fromJson(item as Map<String, dynamic>))
        .toList()
        : null,
  );


}

