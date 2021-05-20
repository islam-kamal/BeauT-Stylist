import 'package:BeauT_Stylist/helpers/network-mappers.dart';

class UpadteProfileResponse extends BaseMappable {
  bool status;
  String errNum;
  String msg;
  User user;

  UpadteProfileResponse({this.status, this.errNum, this.msg, this.user});

  @override
  Mappable fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    return UpadteProfileResponse(
        status: status, msg: msg, errNum: errNum, user: user);
  }
}

class User {
  int id;
  String name;
  String email;
  String mobile;
  int emailVerified;
  int block;
  Null createdAt;
  String updatedAt;

  User(
      {this.id,
      this.name,
      this.email,
      this.mobile,
      this.emailVerified,
      this.block,
      this.createdAt,
      this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    emailVerified = json['email_verified'];
    block = json['block'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['email_verified'] = this.emailVerified;
    data['block'] = this.block;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
