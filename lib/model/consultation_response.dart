class ConsultationResponse {
  final String message;
  final List<Consultation> data;
  String error;

  ConsultationResponse({
    this.message = '',
    this.data = const [],
    this.error = '',
  });

  factory ConsultationResponse.fromJson(Map<String, dynamic> json) {
    return ConsultationResponse(
      message: json['message'] ?? '',
      error: json['error'] ?? '',
      data: (json['data'] as List?)
          ?.map((item) => Consultation.fromJson(item))
          .toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'error': error,
      'data': data.map((item) => item.toJson()).toList(),
    };
  }
}

class Consultation {
  final int conId;
  final int cusId;
  final int astroId;
  final String fullName;
  final String customer_image;
  final String dateOfBirth;
  final String timeOfBirth;
  final String placeOfBirth;
  final int pincode;
  final String gender;
  final String concernTopic;
  final String partnerName;
  final String partnerDob;
  final String partnerTob;
  final String partnerPob;
  final int consultationType;
  final String duration;
  final int chargeAmount;
  final double rating;
  final String review;
  final int status;
  final String createdAt;
  final String updatedAt;

  Consultation({
    this.conId = 0,
    this.cusId = 0,
    this.astroId = 0,
    this.fullName = '',
    this.customer_image='',
    this.dateOfBirth = '',
    this.timeOfBirth = '',
    this.placeOfBirth = '',
    this.pincode = 0,
    this.gender = '',
    this.concernTopic = '',
    this.partnerName = '',
    this.partnerDob = '',
    this.partnerTob = '',
    this.partnerPob = '',
    this.consultationType = 0,
    this.duration = '',
    this.chargeAmount = 0,
    this.rating = 0.0,
    this.review = '',
    this.status = 0,
    this.createdAt = '',
    this.updatedAt = '',
  });

  factory Consultation.fromJson(Map<String, dynamic> json) {
    return Consultation(
      conId: json['con_id'] ?? 0,
      cusId: json['cus_id'] ?? 0,
      astroId: json['astro_id'] ?? 0,
      fullName: json['full_name'] ?? '',
      customer_image : json['customer_image']??'',
      dateOfBirth: json['date_of_birth'] ?? '',
      timeOfBirth: json['time_of_birth'] ?? '',
      placeOfBirth: json['place_of_birth'] ?? '',
      pincode: json['pincode'] ?? 0,
      gender: json['gender'] ?? '',
      concernTopic: json['concern_topic'] ?? '',
      partnerName: json['partner_name'] ?? '',
      partnerDob: json['patner_dob'] ?? '',
      partnerTob: json['patner_tob'] ?? '',
      partnerPob: json['patner_pob'] ?? '',
      consultationType: json['consultation_type'] ?? 0,
      duration: json['duration'] ?? '',
      chargeAmount: (json['charge_amount'] as num?)?.toInt() ?? 0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      review: json['review'] ?? '',
      status: json['status'] ?? 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'con_id': conId,
      'cus_id': cusId,
      'astro_id': astroId,
      'full_name': fullName,
      'customer_image':customer_image,
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
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
