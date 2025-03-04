class Followers {
  final int? frId;
  final int? cusId;
  final int? astroId;
  final int? status;
  final String? customerName;
  final String? cusProfilePhoto;
  final String? createdAt;
  final String? updatedAt;

  Followers({
    this.frId,
    this.cusId,
    this.astroId,
    this.status,
    this.customerName,
    this.cusProfilePhoto,
    this.createdAt,
    this.updatedAt,
  });

  factory Followers.fromJson(Map<String, dynamic> json) {
    return Followers(
      frId: json['fr_id'] as int?,
      cusId: json['cus_id'] as int?,
      astroId: json['astro_id'] as int?,
      status: json['status'] as int?,
      customerName: json['customer_name'] as String?,
      cusProfilePhoto: json['cus_profile_photo'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fr_id': frId,
      'cus_id': cusId,
      'astro_id': astroId,
      'status': status,
      'customer_name': customerName,
      'cus_profile_photo': cusProfilePhoto,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
