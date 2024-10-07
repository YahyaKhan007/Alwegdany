import '../auth/registration_response_model.dart';

class TransactionResponseModel {
  TransactionResponseModel({
      String? remark, 
      String? status, 
      Message? message,
      MainData? data,}){
    _remark = remark;
    _status = status;
    _message = message;
    _data = data;
}

  TransactionResponseModel.fromJson(dynamic json) {
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
      Transactions? transactions, 
      List<Remarks>? remarks,}){
    _transactions = transactions;
    _remarks = remarks;
}

  MainData.fromJson(dynamic json) {
    _transactions = json['transactions'] != null ? Transactions.fromJson(json['transactions']) : null;
    if (json['remarks'] != null) {
      _remarks = [];
      json['remarks'].forEach((v) {
        _remarks?.add(Remarks.fromJson(v));
      });
    }
  }
  Transactions? _transactions;
  List<Remarks>? _remarks;

  Transactions? get transactions => _transactions;
  List<Remarks>? get remarks => _remarks;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_transactions != null) {
      map['transactions'] = _transactions?.toJson();
    }
    if (_remarks != null) {
      map['remarks'] = _remarks?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Remarks {
  Remarks({
      String? remark,}){
    _remark = remark;
}

  Remarks.fromJson(dynamic json) {
    _remark = json['remark'];
  }
  String? _remark;

  String? get remark => _remark;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['remark'] = _remark;
    return map;
  }

}

class Transactions {
  Transactions({
      int? currentPage, 
      List<Data>? data, 
      String? firstPageUrl, 
      int? from, 
      int? lastPage, 
      String? lastPageUrl, 
      List<Links>? links, 
      dynamic nextPageUrl, 
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

  Transactions.fromJson(dynamic json) {
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
  dynamic _nextPageUrl;
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
  dynamic get nextPageUrl => _nextPageUrl;
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
      String? amount, 
      String? charge, 
      String? postBalance, 
      String? trxType, 
      String? trx, 
      String? details, 
      String? remark, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _userId = userId;
    _amount = amount;
    _charge = charge;
    _postBalance = postBalance;
    _trxType = trxType;
    _trx = trx;
    _details = details;
    _remark = remark;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'].toString();
    _amount = json['amount'].toString();
    _charge = json['charge'].toString();
    _postBalance = json['post_balance'].toString();
    _trxType = json['trx_type'];
    _trx = json['trx'];
    _details = json['details'];
    _remark = json['remark'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  String? _userId;
  String? _amount;
  String? _charge;
  String? _postBalance;
  String? _trxType;
  String? _trx;
  String? _details;
  String? _remark;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get userId => _userId;
  String? get amount => _amount;
  String? get charge => _charge;
  String? get postBalance => _postBalance;
  String? get trxType => _trxType;
  String? get trx => _trx;
  String? get details => _details;
  String? get remark => _remark;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['amount'] = _amount;
    map['charge'] = _charge;
    map['post_balance'] = _postBalance;
    map['trx_type'] = _trxType;
    map['trx'] = _trx;
    map['details'] = _details;
    map['remark'] = _remark;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}