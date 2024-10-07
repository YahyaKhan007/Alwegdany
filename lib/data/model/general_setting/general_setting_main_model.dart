import '../auth/registration_response_model.dart';

class GeneralSettingMainModel {
  GeneralSettingMainModel({
      int? code, 
      String? status, 
      Message? message, 
      Data? data,}){
    _code = code;
    _status = status;
    _message = message;
    _data = data;
}

  GeneralSettingMainModel.fromJson(dynamic json) {
    _code = json['code'];
    _status = json['status'].toString();
    _message = json['message'] != null ? Message.fromJson(json['message']) : null;
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  int? _code;
  String? _status;
  Message? _message;
  Data? _data;

  int? get code => _code;
  String? get status => _status;
  Message? get message => _message;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['status'] = _status;
    if (_message != null) {
      map['message'] = _message?.toJson();
    }
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

  void setCode(int i) {
    _code=i;
  }

}

class Data {
  Data({
      GeneralSetting? generalSetting,}){
    _generalSetting = generalSetting;
}

  Data.fromJson(dynamic json) {
    _generalSetting = json['general_setting'] != null ? GeneralSetting.fromJson(json['general_setting']) : null;
  }
  GeneralSetting? _generalSetting;

  GeneralSetting? get generalSetting => _generalSetting;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_generalSetting != null) {
      map['general_setting'] = _generalSetting?.toJson();
    }
    return map;
  }

}

class GeneralSetting {
  GeneralSetting({
      int? id, 

      String? siteName,
      String? curText, 
      String? curSym, 

    String? securePassword,
    String? agree,
    String? registration,
      dynamic createdAt, 
      String? updatedAt,}){
    _id = id;
    _apiToken = apiToken;
    _siteName = siteName;
    _curText = curText;
    _curSym = curSym;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  GeneralSetting.fromJson(dynamic json) {
    _id = json['id'];
    _siteName = json['site_name'];
    _curText = json['cur_text'];
    _curSym = json['cur_sym'];
    _securePassword = json['secure_password'].toString();
    _agree = json['agree'].toString();
    _registration = json['registration'].toString();
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  dynamic _apiToken;
  String? _siteName;
  String? _curText;
  String? _curSym;
  String? _securePassword;
  String? _agree;
  String? _registration;
  dynamic _createdAt;
  String? _updatedAt;

  int? get id => _id;
  dynamic get apiToken => _apiToken;
  String? get siteName => _siteName;
  String? get curText => _curText;
  String? get curSym => _curSym;

  String? get securePassword => _securePassword;
 String? get agree => _agree;
  String? get registration => _registration;
  dynamic get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['api_token'] = _apiToken;
    map['sitename'] = _siteName;
    map['cur_text'] = _curText;
    map['cur_sym'] = _curSym;
    map['secure_password'] = _securePassword;
    map['agree'] = _agree;
    map['registration'] = _registration;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}

class SmsConfig {
  SmsConfig({
      String? messageBirdApiKey, 
      String? nexmoApiKey, 
      String? nexmoApiSecret, 
      String? accountSid, 
      String? authToken, 
      String? from,
      String? name,}){
    _messageBirdApiKey = messageBirdApiKey;
    _nexmoApiKey = nexmoApiKey;
    _nexmoApiSecret = nexmoApiSecret;
    _accountSid = accountSid;
    _authToken = authToken;
    _from = from;
    _name = name;
}

  SmsConfig.fromJson(dynamic json) {
    _messageBirdApiKey = json['message_bird_api_key'];
    _nexmoApiKey = json['nexmo_api_key'];
    _nexmoApiSecret = json['nexmo_api_secret'];
    _accountSid = json['account_sid'];
    _authToken = json['auth_token'];
    _from = json['from'];
    _name = json['name'];
  }
  String? _messageBirdApiKey;
  String? _nexmoApiKey;
  String? _nexmoApiSecret;
  String? _accountSid;
  String? _authToken;
  String? _from;
  String? _name;


  String? get messageBirdApiKey => _messageBirdApiKey;
  String? get nexmoApiKey => _nexmoApiKey;
  String? get nexmoApiSecret => _nexmoApiSecret;
  String? get accountSid => _accountSid;
  String? get authToken => _authToken;
  String? get from => _from;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message_bird_api_key'] = _messageBirdApiKey;
    map['nexmo_api_key'] = _nexmoApiKey;
    map['nexmo_api_secret'] = _nexmoApiSecret;
    map['account_sid'] = _accountSid;
    map['auth_token'] = _authToken;
    map['from'] = _from;
    map['name'] = _name;
    return map;
  }

}

class MailConfig {
  MailConfig({
      String? name,}){
    _name = name;
}

  MailConfig.fromJson(dynamic json) {
    _name = json['name'];
  }
  String? _name;

  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    return map;
  }

}

