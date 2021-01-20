import 'package:butyprovider/helpers/network-mappers.dart';

class GeneralResponse extends BaseMappable {
  bool status;
  String errNum;
  String msg;

  GeneralResponse({this.status, this.errNum, this.msg});

  GeneralResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['errNum'] = this.errNum;
    data['msg'] = this.msg;
    return data;
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    return GeneralResponse(status: status, errNum: errNum, msg: msg);
  }
}
