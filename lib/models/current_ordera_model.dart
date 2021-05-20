import 'package:BeauT_Stylist/helpers/network-mappers.dart';

class CurrentOrdersResponse extends BaseMappable {
  bool status;
  String errNum;
  String msg;
  List<Orders> orders;

  CurrentOrdersResponse({this.status, this.errNum, this.msg, this.orders});

  @override
  Mappable fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    if (json['orders'] != null) {
      orders = new List<Orders>();
      json['orders'].forEach((v) {
        orders.add(new Orders.fromJson(v));
      });
    }
    return CurrentOrdersResponse(
        msg: msg, status: status, errNum: errNum, orders: orders);
  }
}

class Orders {
  int id;
  String date;
  String time;
  int cost;
  int orderNum;
  int appCommission;
  String paymentStatus;
  String orderStatus;
  int beauticianId;
  int userId;
  int paymentMethodId;
  String locationType;
  String createdAt;
  Beautician beautician;
  List<Services> services;
  PaymentMethod paymentMethod;

  Orders(
      {this.id,
      this.date,
      this.time,
      this.cost,
      this.orderNum,
      this.appCommission,
      this.paymentStatus,
      this.orderStatus,
      this.beauticianId,
      this.userId,
      this.paymentMethodId,
      this.locationType,
      this.createdAt,
      this.beautician,
      this.services,
      this.paymentMethod});

  Orders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    time = json['time'];
    cost = json['cost'];
    orderNum = json['order_num'];
    appCommission = json['app_commission'];
    paymentStatus = json['payment_status'];
    orderStatus = json['order_status'];
    beauticianId = json['beautician_id'];
    userId = json['user_id'];
    paymentMethodId = json['payment_method_id'];
    locationType = json['location_type'];
    createdAt = json['created_at'];
    beautician = json['beautician'] != null
        ? new Beautician.fromJson(json['beautician'])
        : null;
    if (json['services'] != null) {
      services = new List<Services>();
      json['services'].forEach((v) {
        services.add(new Services.fromJson(v));
      });
    }
    paymentMethod = json['payment_method'] != null
        ? new PaymentMethod.fromJson(json['payment_method'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['time'] = this.time;
    data['cost'] = this.cost;
    data['order_num'] = this.orderNum;
    data['app_commission'] = this.appCommission;
    data['payment_status'] = this.paymentStatus;
    data['order_status'] = this.orderStatus;
    data['beautician_id'] = this.beauticianId;
    data['user_id'] = this.userId;
    data['payment_method_id'] = this.paymentMethodId;
    data['location_type'] = this.locationType;
    data['created_at'] = this.createdAt;
    if (this.beautician != null) {
      data['beautician'] = this.beautician.toJson();
    }
    if (this.services != null) {
      data['services'] = this.services.map((v) => v.toJson()).toList();
    }
    if (this.paymentMethod != null) {
      data['payment_method'] = this.paymentMethod.toJson();
    }
    return data;
  }
}

class Beautician {
  int id;
  String beautName;

  Beautician({this.id, this.beautName});

  Beautician.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    beautName = json['beaut_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['beaut_name'] = this.beautName;
    return data;
  }
}

class Services {
  String nameAr;
  String nameEn;
  String detailsEn;
  String detailsAr;
  String icon;
  int categoryId;
  String estimatedTime;
  String price;
  String bonus;
  String location;
  int serviceId;
  int personNum;

  Services(
      {this.nameAr,
      this.nameEn,
      this.detailsEn,
      this.detailsAr,
      this.icon,
      this.categoryId,
      this.estimatedTime,
      this.price,
      this.bonus,
      this.location,
      this.serviceId,
      this.personNum});

  Services.fromJson(Map<String, dynamic> json) {
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    detailsEn = json['details_en'];
    detailsAr = json['details_ar'];
    icon = json['icon'];
    categoryId = json['category_id'];
    estimatedTime = json['estimated_time'];
    price = json['price'];
    bonus = json['bonus'];
    location = json['location'];
    serviceId = json['service_id'];
    personNum = json['person_num'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name_ar'] = this.nameAr;
    data['name_en'] = this.nameEn;
    data['details_en'] = this.detailsEn;
    data['details_ar'] = this.detailsAr;
    data['icon'] = this.icon;
    data['category_id'] = this.categoryId;
    data['estimated_time'] = this.estimatedTime;
    data['price'] = this.price;
    data['bonus'] = this.bonus;
    data['location'] = this.location;
    data['service_id'] = this.serviceId;
    data['person_num'] = this.personNum;
    return data;
  }
}

class PaymentMethod {
  int id;
  String nameAr;
  String nameEn;

  PaymentMethod({this.id, this.nameAr, this.nameEn});

  PaymentMethod.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_ar'] = this.nameAr;
    data['name_en'] = this.nameEn;
    return data;
  }
}
