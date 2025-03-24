class WithdrawlHistory {
  final String message;
  final List<WithdrawlData> data;

  WithdrawlHistory({this.message = '', this.data = const []});

  factory WithdrawlHistory.fromJson(Map<String, dynamic> json) {
    return WithdrawlHistory(
      message: json['message'] ?? '',
      data: (json['PendingRequest'] as List?)
              ?.map((e) => WithdrawlData.fromJson(e))
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

class WithdrawlData {
  final int wrId;
  final int astroId;
  final String requestAmount;
  final String? reasonStatus;
  final int status;
  final String createdAt;
  final String updatedAt;

  WithdrawlData({
    this.wrId = 0,
    this.astroId = 0,
    this.requestAmount = '0.00',
    this.reasonStatus,
    this.status = 0,
    this.createdAt = '',
    this.updatedAt = '',
  });

  factory WithdrawlData.fromJson(Map<String, dynamic> json) {
    return WithdrawlData(
      wrId: json['wr_id'] ?? 0,
      astroId: json['astro_id'] ?? 0,
      requestAmount: json['request_amount'] ?? '0.00',
      reasonStatus: json['reason_status'],
      status: json['status'] ?? 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'wr_id': wrId,
      'astro_id': astroId,
      'request_amount': requestAmount,
      'reason_status': reasonStatus,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
