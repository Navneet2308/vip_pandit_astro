class AstrologerRegisterModel {
  String? message;
  String? error;
  AstrologerData? data;

  AstrologerRegisterModel({
    this.message,
    this.error,
    this.data,
  });

  factory AstrologerRegisterModel.fromJson(Map<String, dynamic> json) {
    return AstrologerRegisterModel(
      message: json['message'] as String?,
      error: json['error'] as String?,
      data: json['data'] != null
          ? AstrologerData.fromJson(json['data'])
          : null, // Handle missing 'data' gracefully
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (message != null) 'message': message,
      if (error != null) 'error': error,
      if (data != null) 'data': data!.toJson(), // Include only if not null
    };
  }
}

class AstrologerData {
  String fullName;
  String mobileNo;
  String emailId;
  String dateOfBirth;
  String fullAddress;
  String pincode;
  String gender;
  String profilePhoto;
  int status;
  String astroLivingCity;
  String acatId;
  String astroSkills;
  String astroLanguage;
  String astroExperience;
  String astroChatCharge;
  String astroMinuteCharge;
  String astroProfileBio;
  String updatedAt;
  String createdAt;
  int astroId;

  AstrologerData({
    required this.fullName,
    required this.mobileNo,
    required this.emailId,
    required this.dateOfBirth,
    required this.fullAddress,
    required this.pincode,
    required this.gender,
    required this.profilePhoto,
    required this.status,
    required this.astroLivingCity,
    required this.acatId,
    required this.astroSkills,
    required this.astroLanguage,
    required this.astroExperience,
    required this.astroChatCharge,
    required this.astroMinuteCharge,
    required this.astroProfileBio,
    required this.updatedAt,
    required this.createdAt,
    required this.astroId,
  });

  factory AstrologerData.fromJson(Map<String, dynamic> json) {
    return AstrologerData(
      fullName: json['full_name'] ?? 'N/A', // Default value if null
      mobileNo: json['mobile_no'] ?? 'N/A',
      emailId: json['email_id'] ?? 'N/A',
      dateOfBirth: json['date_of_birth'] ?? 'N/A',
      fullAddress: json['full_address'] ?? 'N/A',
      pincode: json['pincode'] ?? '000000',
      gender: json['gender'] ?? 'Unknown',
      profilePhoto: json['profile_photo'] ?? '',
      status: json['status'] ?? 0,
      astroLivingCity: json['astro_living_city'] ?? 'N/A',
      acatId: json['acat_id'] ?? '0',
      astroSkills: json['astro_skills'] ?? 'N/A',
      astroLanguage: json['astro_language'] ?? 'N/A',
      astroExperience: json['astro_experience'] ?? '0',
      astroChatCharge: json['astro_chat_charge'] ?? '0',
      astroMinuteCharge: json['astro_minute_charge'] ?? '0',
      astroProfileBio: json['astro_profile_bio'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      createdAt: json['created_at'] ?? '',
      astroId: json['astro_id'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'full_name': fullName,
      'mobile_no': mobileNo,
      'email_id': emailId,
      'date_of_birth': dateOfBirth,
      'full_address': fullAddress,
      'pincode': pincode,
      'gender': gender,
      'profile_photo': profilePhoto,
      'status': status,
      'astro_living_city': astroLivingCity,
      'acat_id': acatId,
      'astro_skills': astroSkills,
      'astro_language': astroLanguage,
      'astro_experience': astroExperience,
      'astro_chat_charge': astroChatCharge,
      'astro_minute_charge': astroMinuteCharge,
      'astro_profile_bio': astroProfileBio,
      'updated_at': updatedAt,
      'created_at': createdAt,
      'astro_id': astroId,
    };
  }
}
