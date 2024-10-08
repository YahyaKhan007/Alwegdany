import 'package:alwegdany/data/model/auth/registration_response_model.dart';

class ProfileResponseModel {
  ProfileResponseModel({
    String? remark,
    String? status,
    Message? message,
    Data? data,
  }) {
    _remark = remark;
    _status = status;
    _message = message;
    _data = data;
  }

  ProfileResponseModel.fromJson(dynamic json) {
    _remark = json['remark'];
    _status = json['status'].toString();
    _message =
        json['message'] != null ? Message.fromJson(json['message']) : null;
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? _remark;
  String? _status;
  Message? _message;
  Data? _data;

  String? get remark => _remark;
  String? get status => _status;
  Message? get message => _message;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['remark'] = _remark;
    map['status'] = _status;
    if (_message != null) {
      map['message'] = _message?.toJson();
    }
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

class Data {
  Data({
    User? user,
  }) {
    _user = user;
  }

  Data.fromJson(dynamic json) {
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  User? _user;

  User? get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    return map;
  }
}

class User {
  User({
    int? id,
    String? firstname,
    String? lastname,
    String? username,
    String? email,
    String? countryCode,
    String? mobile,
    String? balance,
    String? image,
    Address? address,
    String? status,
    dynamic kycData,
    String? kv,
    String? ev,
    String? sv,
    int? regStep,
    String? verCode,
    String? verCodeSendAt,
    String? ts,
    String? tv,
    String? telegramUsername,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _firstname = firstname;
    _lastname = lastname;
    _username = username;
    _email = email;
    _countryCode = countryCode;
    _mobile = mobile;
    _balance = balance;
    _image = image;
    _address = address;
    _status = status;
    _kycData = kycData;
    _verCode = verCode;
    _verCodeSendAt = verCodeSendAt;
    _banReason = banReason;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _telegramUsername = telegramUsername;
  }

  User.fromJson(dynamic json) {
    _id = json['id'];
    _firstname = json['firstname'];
    _lastname = json['lastname'];
    _username = json['username'];
    _email = json['email'];
    _countryCode = json['country_code'].toString();
    _mobile = json['mobile'].toString();
    _balance = json['balance'] != null ? json['balance'].toString() : '0';
    _image = json['image'];
    _address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
    _status = json['status'].toString();
    _verCode = json['ver_code'].toString();
    _verCodeSendAt = json['ver_code_send_at'].toString();
    _banReason = json['ban_reason'].toString();
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _telegramUsername = json['telegram_username'] ?? '';
  }
  int? _id;
  String? _firstname;
  String? _lastname;
  String? _username;
  String? _email;
  String? _countryCode;
  String? _mobile;
  String? _balance;
  String? _image;
  Address? _address;
  String? _status;
  dynamic _kycData;
  String? _verCode;
  String? _verCodeSendAt;
  dynamic _banReason;
  String? _createdAt;
  String? _updatedAt;
  String? _telegramUsername;

  int? get id => _id;
  String? get firstname => _firstname;
  String? get lastname => _lastname;
  String? get username => _username;
  String? get email => _email;
  String? get countryCode => _countryCode;
  String? get mobile => _mobile;
  String? get balance => _balance;
  String? get image => _image;
  Address? get address => _address;
  String? get status => _status;
  dynamic get kycData => _kycData;
  String? get verCode => _verCode;
  String? get verCodeSendAt => _verCodeSendAt;
  dynamic get banReason => _banReason;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get telegramUsername => _telegramUsername;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['firstname'] = _firstname;
    map['lastname'] = _lastname;
    map['username'] = _username;
    map['email'] = _email;
    map['country_code'] = _countryCode;
    map['mobile'] = _mobile;
    map['balance'] = _balance;
    map['image'] = _image;
    if (_address != null) {
      map['address'] = _address?.toJson();
    }
    map['status'] = _status;
    map['kyc_data'] = _kycData;
    map['ver_code'] = _verCode;
    map['ver_code_send_at'] = _verCodeSendAt;
    map['ban_reason'] = _banReason;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['telegram_username'] = _telegramUsername;
    return map;
  }
}

class Address {
  Address({
    String? country,
    String? address,
    String? state,
    String? zip,
    String? city,
  }) {
    _country = country;
    _address = address;
    _state = state;
    _zip = zip;
    _city = city;
  }

  Address.fromJson(dynamic json) {
    _country = json['country'] ?? '';
    _address = json['address'];
    _state = json['state'] != null ? json['state'].toString() : '';
    _zip = json['zip'] != null ? json['zip'].toString() : '';
    _city = json['city'] ?? '';
  }
  String? _country;
  String? _address;
  String? _state;
  String? _zip;
  String? _city;

  String? get country => _country;
  String? get address => _address;
  String? get state => _state;
  String? get zip => _zip;
  String? get city => _city;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['country'] = _country;
    map['address'] = _address;
    map['state'] = _state;
    map['zip'] = _zip;
    map['city'] = _city;
    return map;
  }
}
