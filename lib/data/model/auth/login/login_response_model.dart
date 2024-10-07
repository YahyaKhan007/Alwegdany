import '../registration_response_model.dart';


class LoginResponseModel {
  LoginResponseModel({
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

  LoginResponseModel.fromJson(dynamic json) {
    _remark = json['remark'];
    _status = json['status'];
    _message =
        json['message'] != null ? Message.fromJson(json['message']) : null;
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  String? _remark;
  String? _status;
  Message? _message;
  Data? _data;

  LoginResponseModel copyWith({
    String? remark,
    String? status,
    Message? message,
    Data? data,
  }) =>
      LoginResponseModel(
        remark: remark ?? _remark,
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );

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
    String? accessToken,
    String? tokenType,}){
    _user = user;
    _accessToken = accessToken;
    _tokenType = tokenType;
  }

  Data.fromJson(dynamic json) {
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    _accessToken = json['access_token'];
    _tokenType = json['token_type'];
  }
  User? _user;
  String? _accessToken;
  String? _tokenType;
  Data copyWith({  User? user,
    String? accessToken,
    String? tokenType,
  }) => Data(  user: user ?? _user,
    accessToken: accessToken ?? _accessToken,
    tokenType: tokenType ?? _tokenType,
  );
  User? get user => _user;
  String? get accessToken => _accessToken;
  String? get tokenType => _tokenType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    map['access_token'] = _accessToken;
    map['token_type'] = _tokenType;
    return map;
  }

}

class User {
  User({
    int? id,
    String? packageId,
    String? validity,
    String? telegramUsername,
    String? firstname,
    String? lastname,
    String? username,
    String? email,
    String? countryCode,
    String? mobile,
    String? refBy,
    String? balance,
    String? image,
    Address? address,
    String? status,
    String? kv,
    String? ev,
    String? sv,
    String? regStep,
    String? verCode,
    String? verCodeSendAt,
    String? ts,
    String? tv,

    String? createdAt,
    String? updatedAt,}){
    _id = id;
    _packageId = packageId;
    _validity = validity;
    _telegramUsername = telegramUsername;
    _firstname = firstname;
    _lastname = lastname;
    _username = username;
    _email = email;
    _countryCode = countryCode;
    _mobile = mobile;
    _refBy = refBy;
    _balance = balance;
    _image = image;
    _address = address;
    _status = status;
    _kv = kv;
    _ev = ev;
    _sv = sv;
    _regStep = regStep;
    _verCode = verCode;
    _verCodeSendAt = verCodeSendAt;
    _ts = ts;
    _tv = tv;

    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  User.fromJson(dynamic json) {
    _id = json['id'];
    _packageId = json['package_id'].toString();
    _validity = json['validity'].toString();
    _telegramUsername = json['telegram_username'];
    _firstname = json['firstname'];
    _lastname = json['lastname'];
    _username = json['username'];
    _email = json['email'];
    _countryCode = json['country_code'].toString();
    _mobile = json['mobile'].toString();
    _refBy = json['ref_by'].toString();
    _balance = json['balance'].toString();
    _image = json['image'];
    _address = json['address'] != null ? Address.fromJson(json['address']) : null;
    _status = json['status'].toString();
    _kv = json['kv'].toString();
    _ev = json['ev'].toString();
    _sv = json['sv'].toString();
    _regStep = json['reg_step'].toString();
    _verCode = json['ver_code'].toString();
    _verCodeSendAt = json['ver_code_send_at'];
    _ts = json['ts'].toString();
    _tv = json['tv'].toString();

    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  String? _packageId;
  String? _validity;
  String? _telegramUsername;
  String? _firstname;
  String? _lastname;
  String? _username;
  String? _email;
  String? _countryCode;
  String? _mobile;
  String? _refBy;
  String? _balance;
  String? _image;
  Address? _address;
  String? _status;
  String? _kv;
  String? _ev;
  String? _sv;
  String? _regStep;
  String? _verCode;
  String? _verCodeSendAt;
  String? _ts;
  String? _tv;

  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get packageId => _packageId;
  String? get validity => _validity;
  String? get telegramUsername => _telegramUsername;
  String? get firstname => _firstname;
  String? get lastname => _lastname;
  String? get username => _username;
  String? get email => _email;
  String? get countryCode => _countryCode;
  String? get mobile => _mobile;
  String? get refBy => _refBy;
  String? get balance => _balance;
  String? get image => _image;
  Address? get address => _address;
  String? get status => _status;
  String? get kv => _kv;
  String? get ev => _ev;
  String? get sv => _sv;
  String? get regStep => _regStep;
  String? get verCode => _verCode;
  String? get verCodeSendAt => _verCodeSendAt;
  String? get ts => _ts;
  String? get tv => _tv;

  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['package_id'] = _packageId;
    map['validity'] = _validity;
    map['telegram_username'] = _telegramUsername;
    map['firstname'] = _firstname;
    map['lastname'] = _lastname;
    map['username'] = _username;
    map['email'] = _email;
    map['country_code'] = _countryCode;
    map['mobile'] = _mobile;
    map['ref_by'] = _refBy;
    map['balance'] = _balance;
    map['image'] = _image;
    if (_address != null) {
      map['address'] = _address?.toJson();
    }
    map['status'] = _status;
    map['kv'] = _kv;
    map['ev'] = _ev;
    map['sv'] = _sv;
    map['reg_step'] = _regStep;
    map['ver_code'] = _verCode;
    map['ver_code_send_at'] = _verCodeSendAt;
    map['ts'] = _ts;
    map['tv'] = _tv;

    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}

class Address {
  Address({
    String? address,
    String? state,
    String? zip,
    String? country,
    String? city,}){
    _address = address;
    _state = state;
    _zip = zip;
    _country = country;
    _city = city;
  }

  Address.fromJson(dynamic json) {
    _address = json['address'];
    _state = json['state'].toString();
    _zip = json['zip'].toString();
    _country = json['country'].toString();
    _city = json['city'].toString();
  }
  String? _address;
  String? _state;
  String? _zip;
  String? _country;
  String? _city;
  Address copyWith({  String? address,
    String? state,
    String? zip,
    String? country,
    String? city,
  }) => Address(  address: address ?? _address,
    state: state ?? _state,
    zip: zip ?? _zip,
    country: country ?? _country,
    city: city ?? _city,
  );
  String? get address => _address;
  String? get state => _state;
  String? get zip => _zip;
  String? get country => _country;
  String? get city => _city;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['address'] = _address;
    map['state'] = _state;
    map['zip'] = _zip;
    map['country'] = _country;
    map['city'] = _city;
    return map;
  }

}
