class BannerModel {
  int? id;
  String? title;
  String? image;
  String? link;
  int? status;
  String? createdAt;
  String? updatedAt;

  BannerModel(
      {this.id,
      this.title,
      this.image,
      this.link,
      this.status,
      this.createdAt,
      this.updatedAt});

  BannerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    link = json['link'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['image'] = image;
    data['link'] = link;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
