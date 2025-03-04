class EarningHistory {
  final String message;
  final List<EarningData> data;

  EarningHistory({this.message = '', this.data = const []});

  factory EarningHistory.fromJson(Map<String, dynamic> json) {
    return EarningHistory(
      message: json['message'] ?? '',
      data: (json['data'] as List?)
          ?.map((e) => EarningData.fromJson(e))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': data.map((e) => e.toJson()).toList(),
    };
  }
}

class EarningData {
  final int conId;
  final int totalAmount;
  final int count;
  final String customerName;
  final ConsultationDetail consultationDetails;

  EarningData({
    this.conId = 0,
    this.totalAmount = 0,
    this.count = 0,
    this.customerName = 'Unknown',
    ConsultationDetail? consultationDetails,
  }) : consultationDetails = consultationDetails ?? ConsultationDetail();

  factory EarningData.fromJson(Map<String, dynamic> json) {
    return EarningData(
      conId: json['con_id'] ?? 0,
      totalAmount: json['total_amount'] ?? 0,
      count: json['count'] ?? 0,
      customerName: json['customer_name'] ?? 'Unknown',
      consultationDetails: json['consultation_details'] != null
          ? ConsultationDetail.fromJson(json['consultation_details'])
          : ConsultationDetail(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'con_id': conId,
      'total_amount': totalAmount,
      'count': count,
      'customer_name': customerName,
      'consultation_details': consultationDetails.toJson(),
    };
  }
}

class ConsultationDetail {
  final int waId;
  final int cusId;
  final int astroId;
  final String walletType;
  final String txnType;
  final String customerName;
  final DateTime createdAt;
  final DateTime updatedAt;

  ConsultationDetail({
    this.waId = 0,
    this.cusId = 0,
    this.astroId = 0,
    this.walletType = '',
    this.txnType = '',
    this.customerName = '',
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  factory ConsultationDetail.fromJson(Map<String, dynamic> json) {
    return ConsultationDetail(
      waId: json['wa_id'] ?? 0,
      cusId: json['cus_id'] ?? 0,
      astroId: json['astro_id'] ?? 0,
      walletType: json['wallet_type'] ?? '',
      txnType: json['txn_type'] ?? '',
      customerName: json['customer_name'] ?? '',
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at']) ?? DateTime.now()
          : DateTime.now(),
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at']) ?? DateTime.now()
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'wa_id': waId,
      'cus_id': cusId,
      'astro_id': astroId,
      'wallet_type': walletType,
      'txn_type': txnType,
      'customer_name': customerName,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
