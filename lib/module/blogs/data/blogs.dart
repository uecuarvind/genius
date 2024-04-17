class Blogs {
  Blogs({
      this.status, 
      this.data, 
      this.error,});

  Blogs.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(BlogData.fromJson(v));
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
  List<BlogData>? data;
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

}

class BlogData {
  BlogData({
      this.id, 
      this.title, 
      this.details, 
      this.photo, 
      this.source, 
      this.views, 
      this.status, 
      this.metaTag, 
      this.metaDescription, 
      this.tags, 
      this.createdAt,});

  BlogData.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    details = json['details'];
    photo = json['photo'];
    source = json['source'];
    views = json['views'];
    status = json['status'];
    metaTag = json['meta_tag'];
    metaDescription = json['meta_description'];
    tags = json['tags'];
    createdAt = json['created_at'];
  }
  num? id;
  String? title;
  String? details;
  String? photo;
  String? source;
  String? views;
  String? status;
  dynamic metaTag;
  dynamic metaDescription;
  String? tags;
  String? createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['details'] = details;
    map['photo'] = photo;
    map['source'] = source;
    map['views'] = views;
    map['status'] = status;
    map['meta_tag'] = metaTag;
    map['meta_description'] = metaDescription;
    map['tags'] = tags;
    map['created_at'] = createdAt;
    return map;
  }

}