class Helpdesk {
  final int helpId;
  final String liveChatLink;
  final String whatsappChatLink;
  final String supportPhone;
  final String supportEmail;
  final String supportFaq;
  final String supportTicket;
  final DateTime createdAt;
  final DateTime updatedAt;

  Helpdesk({
    this.helpId = 0,
    this.liveChatLink = '',
    this.whatsappChatLink = '',
    this.supportPhone = '',
    this.supportEmail = '',
    this.supportFaq = '',
    this.supportTicket = '',
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  factory Helpdesk.fromJson(Map<String, dynamic> json) {
    return Helpdesk(
      helpId: json['helpdesk']['help_id'] ?? 0,
      liveChatLink: json['helpdesk']['live_chat_link'] ?? '',
      whatsappChatLink: json['helpdesk']['whatsapp_chat_link'] ?? '',
      supportPhone: (json['helpdesk']['support_phone'] ?? '').toString(),
      supportEmail: json['helpdesk']['support_email'] ?? '',
      supportFaq: json['helpdesk']['support_faq'] ?? '',
      supportTicket: json['helpdesk']['support_ticket'] ?? '',
      createdAt: _parseDate(json['helpdesk']['created_at']),
      updatedAt: _parseDate(json['helpdesk']['updated_at']),
    );
  }

  static DateTime _parseDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) {
      return DateTime.now();
    }
    try {
      return DateTime.parse(dateString);
    } catch (e) {
      return DateTime.now();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'helpdesk': {
        'help_id': helpId,
        'live_chat_link': liveChatLink,
        'whatsapp_chat_link': whatsappChatLink,
        'support_phone': supportPhone,
        'support_email': supportEmail,
        'support_faq': supportFaq,
        'support_ticket': supportTicket,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
      },
    };
  }
}
