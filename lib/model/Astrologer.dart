class Astrologer {
  final int? astroId;
  final String? fullName;
  final String? mobileNo;
  final String? emailId;
  final String? dateOfBirth;
  final String? profilePhoto;
  final String? astroLivingCity;
  final String? fullAddress;
  final int? pincode;
  final String? gender;
  final int? acatId;
  final String? astroSkills;
  final String? astroLanguage;
  final String? astroExperience;
  final int? astroChatCharge;
  final int? astroMinuteCharge;
  final String? astroProfileBio;
  final String? totalCallMinute;
  final String? totalChatMinute;
  final int? walletAmount;
  final int? astroKyc;
  final int? status;
  final String? createdAt;
  final String? updatedAt;

  Astrologer({
    this.astroId,
    this.fullName,
    this.mobileNo,
    this.emailId,
    this.dateOfBirth,
    this.profilePhoto,
    this.astroLivingCity,
    this.fullAddress,
    this.pincode,
    this.gender,
    this.acatId,
    this.astroSkills,
    this.astroLanguage,
    this.astroExperience,
    this.astroChatCharge,
    this.astroMinuteCharge,
    this.astroProfileBio,
    this.totalCallMinute,
    this.totalChatMinute,
    this.walletAmount,
    this.astroKyc,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Astrologer.fromJson(Map<String, dynamic>? json) {
    if (json == null) return Astrologer();
    return Astrologer(
      astroId: json['astro_id'] as int?,
      fullName: json['full_name'] as String?,
      mobileNo: json['mobile_no'] as String?,
      emailId: json['email_id'] as String?,
      dateOfBirth: json['date_of_birth'] as String?,
      profilePhoto: json['profile_photo'] as String?,
      astroLivingCity: json['astro_living_city'] as String?,
      fullAddress: json['full_address'] as String?,
      pincode: json['pincode'] as int?,
      gender: json['gender'] as String?,
      acatId: json['ac_id'] as int?,
      astroSkills: json['astro_skills'] as String?,
      astroLanguage: json['astro_language'] as String?,
      astroExperience: json['astro_experience'] as String?,
      astroChatCharge: json['astro_chat_charge'] as int?,
      astroMinuteCharge: json['astro_minute_charge'] as int?,
      astroProfileBio: json['astro_profile_bio'] as String?,
      totalCallMinute: json['total_call_minute'] as String?,
      totalChatMinute: json['total_chat_minute'] as String?,
      walletAmount: json['wallet_amount'] as int?,
      astroKyc: json['astro_kyc'] as int?,
      status: json['status'] as int?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }
}

class LoginResponse {
  final String? error;
  final String? message;
  final Astrologer? astrologer;
  final String? token;

  LoginResponse({this.error,this.message, this.astrologer, this.token});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      message: json['message'] as String?,
      astrologer: json['Astrologer Details'] != null
          ? Astrologer.fromJson(json['Astrologer Details'])
          : null,
      error: json['error'] as String?,
      token: json['token'] as String?,
    );
  }
}
