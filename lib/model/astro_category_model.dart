class AstrologyCategoryModel {
  int? acatId;
  String? categoryName;
  String? description;
  String? image;
  int? status;
  String? createdAt;
  String? updatedAt;

  AstrologyCategoryModel(
      {this.acatId,
        this.categoryName,
        this.description,
        this.image,
        this.status,
        this.createdAt,
        this.updatedAt});

  AstrologyCategoryModel.fromJson(Map<String, dynamic> json) {
    acatId = json['acat_id'];
    categoryName = json['category_name'];
    description = json['description'];
    image = json['image'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['acat_id'] = acatId;
    data['category_name'] = categoryName;
    data['description'] = description;
    data['image'] = image;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}