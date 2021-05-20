import 'package:BeauT_Stylist/helpers/network-mappers.dart';

class NotificationResponse extends BaseMappable {
  bool status;
  String errNum;
  String msg;
  List<Notifications> notifications;

  NotificationResponse(
      {this.status, this.errNum, this.msg, this.notifications});

  @override
  Mappable fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    if (json['notifications'] != null) {
      notifications = new List<Notifications>();
      json['notifications'].forEach((v) {
        notifications.add(new Notifications.fromJson(v));
      });
    }
    return NotificationResponse(
        notifications: notifications, status: status, msg: msg, errNum: errNum);
  }
}

class Notifications {
  int id;
  String title;
  String message;
  int senderUserId;
  String createdAt;
  String time;
  User user;

  Notifications(
      {this.id,
      this.title,
      this.message,
      this.senderUserId,
      this.createdAt,
      this.time,
      this.user});

  Notifications.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    message = json['message'];
    senderUserId = json['sender_user_id'];
    createdAt = json['created_at'];
    time = json['time'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['message'] = this.message;
    data['sender_user_id'] = this.senderUserId;
    data['created_at'] = this.createdAt;
    data['time'] = this.time;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

class User {
  int id;
  String name;

  User({this.id, this.name});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
