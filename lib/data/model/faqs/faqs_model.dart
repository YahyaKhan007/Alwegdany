class FAQsModel {
  int? id;
  String? dataKeys;
  DataValues? dataValues;
  String? templateName;
  String? createdAt;
  String? updatedAt;

  FAQsModel(
      {this.id,
      this.dataKeys,
      this.dataValues,
      this.templateName,
      this.createdAt,
      this.updatedAt});

  FAQsModel.fromJson(Map<String, dynamic> json) {
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
  String? question;
  String? answer;

  DataValues({this.question, this.answer});

  DataValues.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    answer = json['answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['question'] = question;
    data['answer'] = answer;
    return data;
  }
}
