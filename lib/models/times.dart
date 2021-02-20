class HoursModel {
  bool status;
  String errNum;
  String msg;
  List<Data> data;

  HoursModel({this.status, this.errNum, this.msg, this.data});

  HoursModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['errNum'] = this.errNum;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int id;
  String time;
  bool available;

  Data({this.id, this.time , this.available});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    time = json['time'];
    available = false ;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['time'] = this.time;
    return data;
  }
}
