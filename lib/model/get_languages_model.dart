class LanguagesModel {
  int? langId;
  String? languageName;
  int? status;
  String? createdAt;
  String? updatedAt;

  LanguagesModel(
      {this.langId,
        this.languageName,
        this.status,
        this.createdAt,
        this.updatedAt});

  LanguagesModel.fromJson(Map<String, dynamic> json) {
    langId = json['lang_id'];
    languageName = json['language_name'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lang_id'] = langId;
    data['language_name'] = languageName;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}