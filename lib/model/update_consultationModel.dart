class UpdateConsultationModel {
  final String? message;
  final String? error;
  final ConsultationData? data;

  UpdateConsultationModel({
    this.error,
    this.message,
    this.data,
  });

  factory UpdateConsultationModel.fromJson(Map<String, dynamic> json) {
    return UpdateConsultationModel(
      error: json['error'] as String?,
      message: json['message'] as String?,
      data: json['data'] != null
          ? ConsultationData.fromJson(json['data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'error': error,
      'message': message,
      'data': data?.toJson(),
    };
  }
}

class ConsultationData {
  final int? conId;
  final int? cusId;
  final int? astroId;
  final String? fullName;
  final String? dateOfBirth;
  final String? timeOfBirth;
  final String? placeOfBirth;
  final int? pincode;
  final String? gender;
  final String? concernTopic;
  final String? partnerName;
  final String? partnerDob;
  final String? partnerTob;
  final String? partnerPob;
  final String? consultationType;
  final String? duration;
  final int? chargeAmount;
  final String? rating;
  final String? review;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ConsultationData({
    this.conId,
    this.cusId,
    this.astroId,
    this.fullName,
    this.dateOfBirth,
    this.timeOfBirth,
    this.placeOfBirth,
    this.pincode,
    this.gender,
    this.concernTopic,
    this.partnerName,
    this.partnerDob,
    this.partnerTob,
    this.partnerPob,
    this.consultationType,
    this.duration,
    this.chargeAmount,
    this.rating,
    this.review,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory ConsultationData.fromJson(Map<String, dynamic> json) {
    return ConsultationData(
      conId: json['con_id'] as int?,
      cusId: json['cus_id'] as int?,
      astroId: json['astro_id'] as int?,
      fullName: json['full_name'] as String?,
      dateOfBirth: json['date_of_birth'] as String?,
      timeOfBirth: json['time_of_birth'] as String?,
      placeOfBirth: json['place_of_birth'] as String?,
      pincode: json['pincode'] as int?,
      gender: json['gender'] as String?,
      concernTopic: json['concern_topic'] as String?,
      partnerName: json['partner_name'] as String?,
      partnerDob: json['patner_dob'] as String?,
      partnerTob: json['patner_tob'] as String?,
      partnerPob: json['patner_pob'] as String?,
      consultationType: json['consultation_type'] as String?,
      duration: json['duration'] as String?,
      chargeAmount: json['charge_amount'] as int?,
      rating: json['rating'] as String?,
      review: json['review'] as String?,
      status: json['status'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'con_id': conId,
      'cus_id': cusId,
      'astro_id': astroId,
      'full_name': fullName,
      'date_of_birth': dateOfBirth,
      'time_of_birth': timeOfBirth,
      'place_of_birth': placeOfBirth,
      'pincode': pincode,
      'gender': gender,
      'concern_topic': concernTopic,
      'partner_name': partnerName,
      'patner_dob': partnerDob,
      'patner_tob': partnerTob,
      'patner_pob': partnerPob,
      'consultation_type': consultationType,
      'duration': duration,
      'charge_amount': chargeAmount,
      'rating': rating,
      'review': review,
      'status': status,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
