import 'dart:convert';

/// success : true
/// code : "PAYMENT_SUCCESS"
/// message : "Your request has been successfully completed."
/// data : {"merchantId":"PGTESTPAYUAT","merchantTransactionId":"MT7850590068188104","transactionId":"T2111221437456190170379","amount":100,"state":"COMPLETED","responseCode":"SUCCESS","paymentInstrument":{"type":"UPI","utr":"206378866112"}}

PaymentModal paymentModalFromJson(String str) =>
    PaymentModal.fromJson(json.decode(str));
String paymentModalToJson(PaymentModal data) => json.encode(data.toJson());

class PaymentModal {
  PaymentModal({
    bool? success,
    String? code,
    String? message,
    Data? data,
  }) {
    _success = success;
    _code = code;
    _message = message;
    _data = data;
  }

  PaymentModal.fromJson(dynamic json) {
    _success = json['success'];
    _code = json['code'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? _success;
  String? _code;
  String? _message;
  Data? _data;
  PaymentModal copyWith({
    bool? success,
    String? code,
    String? message,
    Data? data,
  }) =>
      PaymentModal(
        success: success ?? _success,
        code: code ?? _code,
        message: message ?? _message,
        data: data ?? _data,
      );
  bool? get success => _success;
  String? get code => _code;
  String? get message => _message;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['code'] = _code;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

/// merchantId : "PGTESTPAYUAT"
/// merchantTransactionId : "MT7850590068188104"
/// transactionId : "T2111221437456190170379"
/// amount : 100
/// state : "COMPLETED"
/// responseCode : "SUCCESS"
/// paymentInstrument : {"type":"UPI","utr":"206378866112"}

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    String? merchantId,
    String? merchantTransactionId,
    String? transactionId,
    int? amount,
    String? state,
    String? responseCode,
    PaymentInstrument? paymentInstrument,
  }) {
    _merchantId = merchantId;
    _merchantTransactionId = merchantTransactionId;
    _transactionId = transactionId;
    _amount = amount;
    _state = state;
    _responseCode = responseCode;
    _paymentInstrument = paymentInstrument;
  }

  Data.fromJson(dynamic json) {
    _merchantId = json['merchantId'];
    _merchantTransactionId = json['merchantTransactionId'];
    _transactionId = json['transactionId'];
    _amount = json['amount'];
    _state = json['state'];
    _responseCode = json['responseCode'];
    _paymentInstrument = json['paymentInstrument'] != null
        ? PaymentInstrument.fromJson(json['paymentInstrument'])
        : null;
  }
  String? _merchantId;
  String? _merchantTransactionId;
  String? _transactionId;
  int? _amount;
  String? _state;
  String? _responseCode;
  PaymentInstrument? _paymentInstrument;
  Data copyWith({
    String? merchantId,
    String? merchantTransactionId,
    String? transactionId,
    int? amount,
    String? state,
    String? responseCode,
    PaymentInstrument? paymentInstrument,
  }) =>
      Data(
        merchantId: merchantId ?? _merchantId,
        merchantTransactionId: merchantTransactionId ?? _merchantTransactionId,
        transactionId: transactionId ?? _transactionId,
        amount: amount ?? _amount,
        state: state ?? _state,
        responseCode: responseCode ?? _responseCode,
        paymentInstrument: paymentInstrument ?? _paymentInstrument,
      );
  String? get merchantId => _merchantId;
  String? get merchantTransactionId => _merchantTransactionId;
  String? get transactionId => _transactionId;
  int? get amount => _amount;
  String? get state => _state;
  String? get responseCode => _responseCode;
  PaymentInstrument? get paymentInstrument => _paymentInstrument;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['merchantId'] = _merchantId;
    map['merchantTransactionId'] = _merchantTransactionId;
    map['transactionId'] = _transactionId;
    map['amount'] = _amount;
    map['state'] = _state;
    map['responseCode'] = _responseCode;
    if (_paymentInstrument != null) {
      map['paymentInstrument'] = _paymentInstrument?.toJson();
    }
    return map;
  }
}

/// type : "UPI"
/// utr : "206378866112"

PaymentInstrument paymentInstrumentFromJson(String str) =>
    PaymentInstrument.fromJson(json.decode(str));
String paymentInstrumentToJson(PaymentInstrument data) =>
    json.encode(data.toJson());

class PaymentInstrument {
  PaymentInstrument({
    String? type,
    String? utr,
  }) {
    _type = type;
    _utr = utr;
  }

  PaymentInstrument.fromJson(dynamic json) {
    _type = json['type'];
    _utr = json['utr'];
  }
  String? _type;
  String? _utr;
  PaymentInstrument copyWith({
    String? type,
    String? utr,
  }) =>
      PaymentInstrument(
        type: type ?? _type,
        utr: utr ?? _utr,
      );
  String? get type => _type;
  String? get utr => _utr;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = _type;
    map['utr'] = _utr;
    return map;
  }
}
