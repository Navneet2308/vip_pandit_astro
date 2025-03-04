class AstrologySkillModel {
  int? skill_id;
  String? skill_name;
  int? status;

  AstrologySkillModel(
      {this.skill_id,
        this.skill_name,
        this.status});

  AstrologySkillModel.fromJson(Map<String, dynamic> json) {
  skill_id = json['skill_id'];
  skill_name = json['skill_name'];
  status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['skill_id'] = skill_id;
    data['skill_name'] = skill_name;
    data['status'] = status;
    return data;
  }
}