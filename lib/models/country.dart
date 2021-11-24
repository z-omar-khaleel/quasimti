class Country {
  int id;
  String shortcut;
  String image;
  String name;

  Country({this.id, this.shortcut, this.image, this.name});

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shortcut = json['shortcut'];
    image = json['image'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['shortcut'] = this.shortcut;
    data['image'] = this.image;
    data['name'] = this.name;
    return data;
  }
}
