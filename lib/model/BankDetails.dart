class BankDetails {
  final int? akId;
  final int? astroId;
  final String? adharCard;
  final String? adharPhotoFront;
  final String? adharPhotoBack;
  final String? bankName;
  final String? accountNo;
  final String? ifscCode;
  final String? accountHolder;
  final String? reason;
  final int? status;
  final String? createdAt;
  final String? updatedAt;

  BankDetails({
    this.akId,
    this.astroId,
    this.adharCard,
    this.adharPhotoFront,
    this.adharPhotoBack,
    this.bankName,
    this.accountNo,
    this.ifscCode,
    this.accountHolder,
    this.reason,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory BankDetails.fromJson(Map<String, dynamic> json) {
    return BankDetails(
      akId: json['ak_id'] as int?,
      astroId: json['astro_id'] as int?,
      adharCard: json['adhar_card'] as String?,
      adharPhotoFront: json['adhar_photo_front'] as String?,
      adharPhotoBack: json['adhar_photo_back'] as String?,
      bankName: json['bank_name'] as String?,
      accountNo: json['account_no'] as String?,
      ifscCode: json['ifsc_code'] as String?,
      accountHolder: json['account_holder'] as String?,
      reason: json['reason'] as String?,
      status: json['kyc_status'] as int?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }
}
