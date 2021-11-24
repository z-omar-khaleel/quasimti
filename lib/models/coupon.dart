import 'package:qasimati/models/storeModel.dart';
import 'package:qasimati/models/tag.dart';

class CouponModel {
  int id;
  String type;
  int storeId;
  StoreModel store;
  String link;
  String startDate;
  String endDate;
  int tagId;
  Tag tag;
  String code;
  String enable;
  String order;
  String isFavaiort;
  String mainTitle;
  String description;

  CouponModel({
    this.id,
    this.type,
    this.storeId,
    this.mainTitle,
    this.link,
    this.description,
    this.startDate,
    this.endDate,
    this.tagId,
    this.code,
    this.enable,
    this.store,
    this.tag,
    this.isFavaiort,
  });

  CouponModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ;
    type = json['type'] ;
    storeId = json['store_id'] ;
    mainTitle = json['main_title'] ;
    link = json['link'] ?? "";
    description = json['description'] ;
    startDate = json['start_date']  ;
    endDate = json['end_date'] ;
    tagId = json['tag_id'] ;
    code = json['code'];
    enable = json['enable'];
    isFavaiort = json['is_favaiort'] ;
    store = json['store'] != null ? new StoreModel.fromJson(json['store']) : "";
    tag = json['tag'] != null ? new Tag.fromJson(json['tag']) : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['store_id'] = this.storeId;
    data['main_title_ar'] = this.mainTitle;
    data['link'] = this.link;
    data['description_ar'] = this.description;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['tag_id'] = this.tagId;
    data['code'] = this.code;
    data['enable'] = this.enable;
    data['is_favaiort'] = this.isFavaiort;
    if (this.store != null) {
      data['store'] = this.store.toJson();
    }
    if (this.tag != null) {
      data['tag'] = this.tag.toJson();
    }
    return data;
  }
}
