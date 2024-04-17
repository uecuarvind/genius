import 'package:genius_bank/config/dependency.dart';

class SupportPages {
  SupportPages({
      this.status, 
      this.data, 
      this.error,});

  SupportPages.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Page.fromJson(v));
      });
    }
    if (json['error'] != null) {
      error = [];
      json['error'].forEach((v) {
        error?.add(v);
      });
    }
  }
  bool? status;
  List<Page>? data;
  List<dynamic>? error;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    if (error != null) {
      map['error'] = error?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  static SupportPages? getPages(){
    try{
      return instance.get<SupportPages>();
    } catch(e){
      return null;
    }
  }

}

class Page {
  Page({
      this.id, 
      this.title, 
      this.slug, 
      this.content, 
      this.metaTag, 
      this.metaDescription, 
      this.header, 
      this.footer,});

  Page.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    content = json['content'];
    metaTag = json['meta_tag'];
    metaDescription = json['meta_description'];
    header = json['header'];
    footer = json['footer'];
  }
  num? id;
  String? title;
  String? slug;
  String? content;
  dynamic metaTag;
  dynamic metaDescription;
  String? header;
  String? footer;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['slug'] = slug;
    map['content'] = content;
    map['meta_tag'] = metaTag;
    map['meta_description'] = metaDescription;
    map['header'] = header;
    map['footer'] = footer;
    return map;
  }

}