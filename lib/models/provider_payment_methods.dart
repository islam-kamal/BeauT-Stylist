import 'package:BeauT_Stylist/Base/AllTranslation.dart';
import 'package:BeauT_Stylist/helpers/network-mappers.dart';

class ProviderPaymentMethodResponse extends BaseMappable {
  bool status;
  String errNum;
  String msg;
  List<PaymentMethods> paymentMethods;

  ProviderPaymentMethodResponse(
      {this.status, this.errNum, this.msg, this.paymentMethods});

  @override
  Mappable fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    if (json['payment_methods'] != null) {
      paymentMethods = new List<PaymentMethods>();
      json['payment_methods'].forEach((v) {
        paymentMethods.add(new PaymentMethods.fromJson(v));
      });
    }
    return ProviderPaymentMethodResponse(
        status: status,
        errNum: errNum,
        msg: msg,
        paymentMethods: paymentMethods);
  }
}

class PaymentMethods {
  int id;
  String name;
  bool isSellected;

  PaymentMethods({this.id, this.name, this.isSellected});

  PaymentMethods.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name =allTranslations.currentLanguage=="en"? json['name_en']: json['name_ar'];
    isSellected = false;
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['name_ar'] = this.name;
  //   return data;
  // }
}
