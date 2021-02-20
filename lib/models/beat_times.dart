class BeatTHoursResponse {
  bool status;
  String errNum;
  String msg;
  List<Schedule> schedule;

  BeatTHoursResponse({this.status, this.errNum, this.msg, this.schedule});

  BeatTHoursResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    if (json['schedule'] != null) {
      schedule = new List<Schedule>();
      json['schedule'].forEach((v) {
        schedule.add(new Schedule.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['errNum'] = this.errNum;
    data['msg'] = this.msg;
    if (this.schedule != null) {
      data['schedule'] = this.schedule.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Schedule {
  int id;
  int timeId;
  int beauticianId;
  int status;
  Time time;

  Schedule({this.id, this.timeId, this.beauticianId, this.status, this.time});

  Schedule.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    timeId = json['time_id'];
    beauticianId = json['beautician_id'];
    status = json['status'];
    time = json['time'] != null ? new Time.fromJson(json['time']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['time_id'] = this.timeId;
    data['beautician_id'] = this.beauticianId;
    data['status'] = this.status;
    if (this.time != null) {
      data['time'] = this.time.toJson();
    }
    return data;
  }
}

class Time {
  int id;
  String time;

  Time({this.id, this.time});

  Time.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['time'] = this.time;
    return data;
  }
}
