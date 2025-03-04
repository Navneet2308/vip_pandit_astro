class ConsultationResponse {
  final String? message;
  final List<Consultation>? data;
  String? error;


  ConsultationResponse({ this.message,  this.data, this.error});

  factory ConsultationResponse.fromJson(Map<String, dynamic> json) {
    return ConsultationResponse(
      message: json['message'],
      error: json['error'] ?? '',
      data: List<Consultation>.from(json['data'].map((item) => Consultation.fromJson(item))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'error': error,
      'data': data!.map((item) => item.toJson()).toList(),
    };
  }
}

class Consultation {
  final int conId;
  final int cusId;
  final int astroId;
  final String fullName;
  final String dateOfBirth;
  final String timeOfBirth;
  final String placeOfBirth;
  final int pincode;
  final String gender;
  final String concernTopic;
  final String? partnerName;
  final String? partnerDob;
  final String? partnerTob;
  final String? partnerPob;
  final int consultationType;
  final String? duration;
  final int? chargeAmount;
  final double? rating;
  final String? review;
  final int status;
  final String createdAt;
  final String updatedAt;

  Consultation({
    required this.conId,
    required this.cusId,
    required this.astroId,
    required this.fullName,
    required this.dateOfBirth,
    required this.timeOfBirth,
    required this.placeOfBirth,
    required this.pincode,
    required this.gender,
    required this.concernTopic,
    this.partnerName,
    this.partnerDob,
    this.partnerTob,
    this.partnerPob,
    required this.consultationType,
    this.duration,
    this.chargeAmount,
    this.rating,
    this.review,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Consultation.fromJson(Map<String, dynamic> json) {
    return Consultation(
      conId: json['con_id'],
      cusId: json['cus_id'],
      astroId: json['astro_id'],
      fullName: json['full_name'],
      dateOfBirth: json['date_of_birth'],
      timeOfBirth: json['time_of_birth'],
      placeOfBirth: json['place_of_birth'],
      pincode: json['pincode'],
      gender: json['gender'],
      concernTopic: json['concern_topic'],
      partnerName: json['partner_name'],
      partnerDob: json['patner_dob'],
      partnerTob: json['patner_tob'],
      partnerPob: json['patner_pob'],
      consultationType: json['consultation_type'],
      duration: json['duration'],
      chargeAmount: (json['charge_amount'] as num?)?.toInt(),
      rating: (json['rating'] as num?)?.toDouble(),
      review: json['review'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
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
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
