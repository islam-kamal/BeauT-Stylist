import 'package:BeauT_Stylist/Base/AllTranslation.dart';

class CategoriesResponse {
  CategoriesResponse({
    this.status,
    this.errNum,
    this.msg,
    this.categories,
  });

  bool status;
  String errNum;
  String msg;
  List<Category> categories;

  factory CategoriesResponse.fromJson(Map<String, dynamic> json) =>
      CategoriesResponse(
        status: json["status"],
        errNum: json["errNum"],
        msg: json["msg"],
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "errNum": errNum,
        "msg": msg,
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
      };
}

class Category {
  Category({
    this.id,
    this.icon,
    this.name
  });

  int id;
 String name ;
  String icon;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
       name:  allTranslations.currentLanguage=="ar"?json["name_ar"]:json["name_en"],
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,

        "icon": icon,
      };
}
