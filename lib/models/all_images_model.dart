import 'package:BeauT_Stylist/helpers/network-mappers.dart';

class GallaryResponse extends BaseMappable {
  bool status;
  String errNum;
  String msg;
  List<Gallery> gallery;

  GallaryResponse({this.status, this.errNum, this.msg, this.gallery});

  GallaryResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    if (json['gallery'] != null) {
      gallery = new List<Gallery>();
      json['gallery'].forEach((v) {
        gallery.add(new Gallery.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['errNum'] = this.errNum;
    data['msg'] = this.msg;
    if (this.gallery != null) {
      data['gallery'] = this.gallery.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    if (json['gallery'] != null) {
      gallery = new List<Gallery>();
      json['gallery'].forEach((v) {
        gallery.add(new Gallery.fromJson(v));
      });
    }
    return GallaryResponse(status: status ??true,errNum: errNum , msg: msg ,gallery: gallery);
  }
}

class Gallery {
  int id;
  String photo;
  int beauticianId;

  Gallery({this.id, this.photo, this.beauticianId});

  Gallery.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    photo = json['photo'];
    beauticianId = json['beautician_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['photo'] = this.photo;
    data['beautician_id'] = this.beauticianId;
    return data;
  }
}
