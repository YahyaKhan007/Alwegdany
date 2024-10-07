import '../auth/registration_response_model.dart';

class SignalModel {
  SignalModel({
      String? remark, 
      String? status, 
      Message? message,
      MainData? data,}){
    _remark = remark;
    _status = status;
    _message = message;
    _data = data;
}

  SignalModel.fromJson(dynamic json) {
    _remark = json['remark'];
    _status = json['status'];
    _message = json['message'] != null ? Message.fromJson(json['message']) : null;
    _data = json['data'] != null ? MainData.fromJson(json['data']) : null;
  }
  String? _remark;
  String? _status;
  Message? _message;
  MainData? _data;

  String? get remark => _remark;
  String? get status => _status;
  Message? get message => _message;
  MainData? get data => _data;

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

class MainData {
  MainData({
      Signals? signals,}){
    _signals = signals;
}

  MainData.fromJson(dynamic json) {
    _signals = json['signals'] != null ? Signals.fromJson(json['signals']) : null;
  }
  Signals? _signals;

  Signals? get signals => _signals;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_signals != null) {
      map['signals'] = _signals?.toJson();
    }
    return map;
  }

}

class Signals {
  Signals({
      int? currentPage, 
      List<Data>? data, 
      String? firstPageUrl, 
      int? from, 
      int? lastPage, 
      String? lastPageUrl, 
      List<Links>? links, 
      String? nextPageUrl, 
      String? path, 
      int? perPage, 
      dynamic prevPageUrl, 
      int? to, 
      int? total,}){
    _currentPage = currentPage;
    _data = data;
    _firstPageUrl = firstPageUrl;
    _from = from;
    _lastPage = lastPage;
    _lastPageUrl = lastPageUrl;
    _links = links;
    _nextPageUrl = nextPageUrl;
    _path = path;
    _perPage = perPage;
    _prevPageUrl = prevPageUrl;
    _to = to;
    _total = total;
}

  Signals.fromJson(dynamic json) {
    _currentPage = json['current_page'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    _firstPageUrl = json['first_page_url'];
    _from = json['from'];
    _lastPage = json['last_page'];
    _lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      _links = [];
      json['links'].forEach((v) {
        _links?.add(Links.fromJson(v));
      });
    }
    _nextPageUrl = json['next_page_url'];
    _path = json['path'];
    _perPage = json['per_page'];
    _prevPageUrl = json['prev_page_url'];
    _to = json['to'];
    _total = json['total'];
  }
  int? _currentPage;
  List<Data>? _data;
  String? _firstPageUrl;
  int? _from;
  int? _lastPage;
  String? _lastPageUrl;
  List<Links>? _links;
  String? _nextPageUrl;
  String? _path;
  int? _perPage;
  dynamic _prevPageUrl;
  int? _to;
  int? _total;

  int? get currentPage => _currentPage;
  List<Data>? get data => _data;
  String? get firstPageUrl => _firstPageUrl;
  int? get from => _from;
  int? get lastPage => _lastPage;
  String? get lastPageUrl => _lastPageUrl;
  List<Links>? get links => _links;
  String? get nextPageUrl => _nextPageUrl;
  String? get path => _path;
  int? get perPage => _perPage;
  dynamic get prevPageUrl => _prevPageUrl;
  int? get to => _to;
  int? get total => _total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['current_page'] = _currentPage;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['first_page_url'] = _firstPageUrl;
    map['from'] = _from;
    map['last_page'] = _lastPage;
    map['last_page_url'] = _lastPageUrl;
    if (_links != null) {
      map['links'] = _links?.map((v) => v.toJson()).toList();
    }
    map['next_page_url'] = _nextPageUrl;
    map['path'] = _path;
    map['per_page'] = _perPage;
    map['prev_page_url'] = _prevPageUrl;
    map['to'] = _to;
    map['total'] = _total;
    return map;
  }

}

class Links {
  Links({
      dynamic url, 
      String? label, 
      bool? active,}){
    _url = url;
    _label = label;
    _active = active;
}

  Links.fromJson(dynamic json) {
    _url = json['url'];
    _label = json['label'];
    _active = json['active'];
  }
  dynamic _url;
  String? _label;
  bool? _active;

  dynamic get url => _url;
  String? get label => _label;
  bool? get active => _active;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = _url;
    map['label'] = _label;
    map['active'] = _active;
    return map;
  }

}

class Data {
  Data({
      int? id, 
      String? userId, 
      String? signalId, 
      String? createdAt, 
      String? updatedAt, 
      Signal? signal,}){
    _id = id;
    _userId = userId;
    _signalId = signalId;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _signal = signal;
}

  Data.fromJson(dynamic json) {
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
      String? updatedAt,}){
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
    _id = json['id'];
    _packageId = json['package_id'] != null ? json['package_id'].cast<String>() : [];
    _sendVia = json['send_via'] != null ? json['send_via'].cast<String>() : [];
    _name = json['name'];
    _signal = json['signal'].toString();
    _minute = json['minute'].toString();
    _send = json['send'].toString();
    _status = json['status'].toString();
    _sendSignalAt = json['send_signal_at'];
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