
class BeauticianScheduleResponse {
  BeauticianScheduleResponse({
    this.status,
    this.errNum,
    this.msg,
    this.schedule,
  });

  bool status;
  String errNum;
  String msg;
  List<Schedule> schedule;

  factory BeauticianScheduleResponse.fromJson(Map<String, dynamic> json) => BeauticianScheduleResponse(
    status: json["status"],
    errNum: json["errNum"],
    msg: json["msg"],
    schedule:json["status"]== false ?null : List<Schedule>.from(json["schedule"].map((x) => Schedule.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "errNum": errNum,
    "msg": msg,
    "schedule": List<dynamic>.from(schedule.map((x) => x.toJson())),
  };
}

class Schedule {
  Schedule({
    this.id,
    this.dayName,
    this.dayDate,
    this.workFrom,
    this.workTo,
    this.beauticianId,
    this.createdAt,
    this.deletedAt,
  });

  int id;
  String dayName;
  String dayDate;
  String workFrom;
  String workTo;
  int beauticianId;
  DateTime createdAt;
  dynamic deletedAt;

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
    id: json["id"],
    dayName: json["day_name"],
    dayDate: json["day_date"],
    workFrom: json["work_from"],
    workTo: json["work_to"],
    beauticianId: json["beautician_id"],
    createdAt: DateTime.parse(json["created_at"]),
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "day_name": dayName,
    "day_date": dayDate,
    "work_from": workFrom,
    "work_to": workTo,
    "beautician_id": beauticianId,
    "created_at": createdAt.toIso8601String(),
    "deleted_at": deletedAt,
  };
}
