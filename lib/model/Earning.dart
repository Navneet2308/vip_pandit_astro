class Earning {
  final int? waId;
  final int? astroId;
  final int? cusId;
  final String? walletType;
  final int? conId;
  final String? duration;
  final double? totalAmount;
  final int? status;
  final String? createdAt;
  final String? updatedAt;

  Earning({
    this.waId,
    this.astroId,
    this.cusId,
    this.walletType,
    this.conId,
    this.duration,
    this.totalAmount,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Earning.fromJson(Map<String, dynamic> json) {
    return Earning(
      waId: json['wa_id'] as int?,
      astroId: json['astro_id'] as int?,
      cusId: json['cus_id'] as int?,
      walletType: json['wallet_type'] as String?,
      conId: json['con_id'] as int?,
      duration: json['duration'] as String?,
      totalAmount: (json['total_amount'] as num?)?.toDouble(),
      status: json['status'] as int?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }
}
