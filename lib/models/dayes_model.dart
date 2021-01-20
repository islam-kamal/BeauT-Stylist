class Days {
  int id;
  String name;
  bool isSellected;

  Days({this.id, this.name ,this.isSellected});

  Days.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isSellected=false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
