class StoreModel {
  int id;
  String link;
  String image;
  String status;
  String name;

  StoreModel({this.id, this.link, this.image, this.status, this.name});

  StoreModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    link = json['link'] ?? "";
    image = json['image'] ?? "";
    status = json['status'] ?? "";
    name = json['name'] ?? r"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['link'] = this.link;
    data['image'] = this.image;
    data['status'] = this.status;
    data['name'] = this.name;
    return data;
  }
}
