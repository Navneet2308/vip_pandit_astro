
import 'BankDetails.dart';

class AstroBank {
  bool? status;
  String? message;
  String? errors;
  String? error;
  int? statusCode;
  BankDetails? bank;

  AstroBank({
    this.status,
    this.message,
    this.errors,
    this.error,
    this.statusCode,
    this.bank,
  });

  factory AstroBank.fromJson(Map<String, dynamic> json) =>
      AstroBank(
        status: json['status'] ?? false, // Default to `false` if `status` is null
        message: json['message'] ?? 'No message available',
        errors: json['errors'] ?? '',
        error: json['error'] ?? '',
        statusCode: json['status_code'] ?? 404, // Default status code for "not found"
        bank:
        json['data'] != null
            ? BankDetails.fromJson(json['data'])
            : null,

      );

  Map<String, dynamic> toJson() =>
      {
        'status': status,
        'message': message,
        'errors': errors,
        'error': error,
        'status_code': statusCode,
        'data': bank,
      };


}
