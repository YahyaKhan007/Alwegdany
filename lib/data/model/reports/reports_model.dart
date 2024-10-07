class ReportsDataModel {
  int? id;
  String? dataKeys;
  DataValues? dataValues;
  String? templateName;
  String? createdAt;
  String? updatedAt;

  ReportsDataModel(
      {this.id,
      this.dataKeys,
      this.dataValues,
      this.templateName,
      this.createdAt,
      this.updatedAt});

  ReportsDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dataKeys = json['data_keys'];
    dataValues = json['data_values'] != null
        ? DataValues.fromJson(json['data_values'])
        : null;
    templateName = json['template_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['data_keys'] = dataKeys;
    if (dataValues != null) {
      data['data_values'] = dataValues!.toJson();
    }
    data['template_name'] = templateName;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class DataValues {
  List<String>? hasImage;
  String? title;
  String? description;
  String? blogType;
  String? image;

  DataValues(
      {this.hasImage, this.title, this.description, this.blogType, this.image});

  DataValues.fromJson(Map<String, dynamic> json) {
    hasImage = json['has_image'].cast<String>();
    title = json['title'];
    description = json['description'];
    blogType = json['blog_type'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['has_image'] = hasImage;
    data['title'] = title;
    data['description'] = description;
    data['blog_type'] = blogType;
    data['image'] = image;
    return data;
  }
}
