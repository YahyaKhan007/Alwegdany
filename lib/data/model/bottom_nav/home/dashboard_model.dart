import '../../auth/registration_response_model.dart';

class DashboardModel {
  DashboardModel({
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

  DashboardModel.fromJson(dynamic json) {
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
    String? referralLink,
    String? totalTrx,
    String? totalSignal,
    String? totalReferral,
    String? totalDeposit,
    List<LatestSignals>? latestSignals,
  }) {
    _user = user;
    _referralLink = referralLink;
    _totalTrx = totalTrx;
    _totalSignal = totalSignal;
    _totalReferral = totalReferral;
    _totalDeposit = totalDeposit;
    _latestSignals = latestSignals;
  }

  Data.fromJson(dynamic json) {
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    _referralLink = json['referral_link'];
    _totalTrx = json['total_trx'].toString();
    _totalSignal = json['total_signal'].toString();
    _totalReferral = json['total_referral'].toString();
    _totalDeposit = json['total_deposit'].toString();
    if (json['latest_signals'] != null) {
      _latestSignals = [];
      json['latest_signals'].forEach((v) {
        _latestSignals?.add(LatestSignals.fromJson(v));
      });
    }
  }
  User? _user;
  String? _referralLink;
  String? _totalTrx;
  String? _totalSignal;
  String? _totalReferral;
  String? _totalDeposit;
  List<LatestSignals>? _latestSignals;

  User? get user => _user;
  String? get referralLink => _referralLink;
  String? get totalTrx => _totalTrx;
  String? get totalSignal => _totalSignal;
  String? get totalReferral => _totalReferral;
  String? get totalDeposit => _totalDeposit;
  List<LatestSignals>? get latestSignals => _latestSignals;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    map['referral_link'] = _referralLink;
    map['total_trx'] = _totalTrx;
    map['total_signal'] = _totalSignal;
    map['total_referral'] = _totalReferral;
    map['total_deposit'] = _totalDeposit;
    if (_latestSignals != null) {
      map['latest_signals'] = _latestSignals?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class LatestSignals {
  LatestSignals({
    int? id,
    String? userId,
    String? signalId,
    String? createdAt,
    String? updatedAt,
    Signal? signal,
  }) {
    _id = id;
    _userId = userId;
    _signalId = signalId;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _signal = signal;
  }

  LatestSignals.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'].toString();
    _signalId = json['signal_id'].toString();
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _signal = json['signal'] != null ? Signal.fromJson(json['signal']) : null;
  }
  int? _id;
  String? _userId;
  String? _signalId;
  String? _createdAt;
  String? _updatedAt;
  Signal? _signal;

  int? get id => _id;
  String? get userId => _userId;
  String? get signalId => _signalId;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  Signal? get signal => _signal;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['signal_id'] = _signalId;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_signal != null) {
      map['signal'] = _signal?.toJson();
    }
    return map;
  }
}

class Signal {
  Signal({
    int? id,
    List<String>? packageId,
    List<String>? sendVia,
    String? name,
    String? signal,
    String? minute,
    String? send,
    String? status,
    String? sendSignalAt,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _packageId = packageId;
    _sendVia = sendVia;
    _name = name;
    _signal = signal;
    _minute = minute;
    _send = send;
    _status = status;
    _sendSignalAt = sendSignalAt;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Signal.fromJson(dynamic json) {
    print(json);
    if (json is List) return;

    _id = json['id'];
    _packageId =
        json['package_id'] != null ? json['package_id'].cast<String>() : [];
    _sendVia = json['send_via'] != null ? json['send_via'].cast<String>() : [];
    _name = json['name'].toString();
    _signal = json['signal'].toString();
    _minute = json['minute'].toString();
    _send = json['send'].toString();
    _status = json['status'].toString();
    _sendSignalAt = json['send_signal_at'].toString();
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  List<String>? _packageId;
  List<String>? _sendVia;
  String? _name;
  String? _signal;
  String? _minute;
  String? _send;
  String? _status;
  String? _sendSignalAt;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  List<String>? get packageId => _packageId;
  List<String>? get sendVia => _sendVia;
  String? get name => _name;
  String? get signal => _signal;
  String? get minute => _minute;
  String? get send => _send;
  String? get status => _status;
  String? get sendSignalAt => _sendSignalAt;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['package_id'] = _packageId;
    map['send_via'] = _sendVia;
    map['name'] = _name;
    map['signal'] = _signal;
    map['minute'] = _minute;
    map['send'] = _send;
    map['status'] = _status;
    map['send_signal_at'] = _sendSignalAt;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
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
    String? updatedAt,
    Package? package,
  }) {
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
    _package = package;
  }

  User.fromJson(dynamic json) {
    _id = json['id'];
    _packageId = json['package_id'].toString();
    _validity = json['validity'] != null ? json['validity'].toString() : '';
    _telegramUsername = json['telegram_username'];
    _firstname = json['firstname'];
    _lastname = json['lastname'];
    _username = json['username'];
    _email = json['email'];
    _countryCode = json['country_code'];
    _mobile = json['mobile'].toString();
    _balance = json['balance'] != null ? json['balance'].toString() : '0.0';
    _image = json['image'];
    _address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
    _package =
        json['package'] != null ? Package.fromJson(json['package']) : null;
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
  Package? _package;

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
  Package? get package => _package;

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
    if (_package != null) {
      map['package'] = _package?.toJson();
    }
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
    _country = json['country'];
    _address = json['address'];
    _state = json['state'].toString();
    _zip = json['zip'].toString();
    _city = json['city'].toString();
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

class Package {
  Package({
    int? id,
    String? name,
    String? price,
    String? validity,
    List<String>? features,
    String? status,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _name = name;
    _price = price;
    _validity = validity;
    _features = features;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Package.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _price = json['price'].toString();
    _validity = json['validity'].toString();
    _features = json['features'] != null ? json['features'].cast<String>() : [];
    _status = json['status'].toString();
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  String? _name;
  String? _price;
  String? _validity;
  List<String>? _features;
  String? _status;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get name => _name;
  String? get price => _price;
  String? get validity => _validity;
  List<String>? get features => _features;
  String? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['price'] = _price;
    map['validity'] = _validity;
    map['features'] = _features;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}
