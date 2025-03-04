class ScheduleData {
  int? csId;
  int? astroId;
  String? monday;
  String? tuesday;
  String? wednesday;
  String? thursday;
  String? friday;
  String? saturday;
  String? sunday;
  String? createdAt;
  String? updatedAt;

  ScheduleData({
    this.csId,
    this.astroId,
    this.monday,
    this.tuesday,
    this.wednesday,
    this.thursday,
    this.friday,
    this.saturday,
    this.sunday,
    this.createdAt,
    this.updatedAt,
  });

  factory ScheduleData.fromJson(Map<String, dynamic> json) => ScheduleData(
    csId: json['cs_id'],
    astroId: json['astro_id'],
    monday: json['monday'],
    tuesday: json['tuesday'],
    wednesday: json['wednesday'],
    thursday: json['thursday'],
    friday: json['friday'],
    saturday: json['saturday'],
    sunday: json['sunday'],
    createdAt: json['created_at'],
    updatedAt: json['updated_at'],
  );

  Map<String, dynamic> toJson() => {
    'cs_id': csId,
    'astro_id': astroId,
    'monday': monday,
    'tuesday': tuesday,
    'wednesday': wednesday,
    'thursday': thursday,
    'friday': friday,
    'saturday': saturday,
    'sunday': sunday,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };
}
