// To parse this JSON data, do
//
//     final myordersListModel = myordersListModelFromJson(jsonString);

import 'dart:convert';

MyordersListModel myordersListModelFromJson(String str) =>
    MyordersListModel.fromJson(json.decode(str));

String myordersListModelToJson(MyordersListModel data) =>
    json.encode(data.toJson());

class MyordersListModel {
  MyordersListModel({
    required this.myOrders,
    required this.userId,
    this.nextPage,
  });

  List<MyOrder> myOrders;
  int userId;
  String? nextPage;

  factory MyordersListModel.fromJson(Map<String, dynamic> json) =>
      MyordersListModel(
          myOrders: List<MyOrder>.from(
              json["my_orders"]['data'].map((x) => MyOrder.fromJson(x))),
          userId: json["user_id"],
          nextPage: json['my_orders']['next_page_url']);

  Map<String, dynamic> toJson() => {
        "my_orders": List<dynamic>.from(myOrders.map((x) => x.toJson())),
        "user_id": userId,
      };
}

class MyOrder {
  MyOrder({
    this.id,
    this.serviceId,
    this.sellerId,
    this.buyerId,
    this.name,
    this.email,
    this.phone,
    this.postCode,
    this.address,
    this.city,
    this.area,
    this.country,
    this.date,
    this.schedule,
    this.packageFee,
    this.extraService,
    this.subTotal,
    this.tax,
    this.total,
    this.couponCode,
    this.couponType,
    this.couponAmount,
    this.commissionType,
    this.commissionCharge,
    this.commissionAmount,
    this.paymentGateway,
    this.paymentStatus,
    this.status,
    this.isOrderOnline,
    this.orderCompleteRequest,
    this.cancelOrderMoneyReturn,
    this.transactionId,
    this.orderNote,
    this.manualPaymentImage,
  });

  int? id;
  int? serviceId;
  int? sellerId;
  int? buyerId;
  String? name;
  String? email;
  String? phone;
  String? postCode;
  String? address;
  int? city;
  int? area;
  int? country;
  DateTime? date;
  String? schedule;
  var packageFee;
  var extraService;
  var subTotal;
  double? tax;
  double? total;
  dynamic couponCode;
  String? couponType;
  var couponAmount;
  String? commissionType;
  int? commissionCharge;
  var commissionAmount;
  String? paymentGateway;
  String? paymentStatus;
  int? status;
  int? isOrderOnline;
  int? orderCompleteRequest;
  int? cancelOrderMoneyReturn;
  dynamic transactionId;
  dynamic orderNote;

  dynamic manualPaymentImage;

  factory MyOrder.fromJson(Map<String, dynamic> json) => MyOrder(
        id: int.tryParse((json["id"].toString())),
        serviceId: int.tryParse((json["service_id"]).toString()),
        sellerId: int.tryParse((json["seller_id"]).toString()),
        buyerId: int.tryParse((json["buyer_id"]).toString()),
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        postCode: json["post_code"],
        address: json["address"],
        city: int.tryParse((json["city"]).toString()),
        area: int.tryParse((json["area"]).toString()),
        country: int.tryParse((json["country"]).toString()),
        date: json["date"] == null ? null : DateTime.parse(json['date']),
        schedule: json["schedule"],
        packageFee: num.tryParse((json["package_fee"]).toString()),
        extraService: json["extra_service"],
        subTotal: num.tryParse((json["sub_total"]).toString()),
        tax: num.tryParse((json["tax"]).toString())?.toDouble(),
        total: num.tryParse((json["total"]).toString())?.toDouble(),
        couponCode: json["coupon_code"],
        couponType: json["coupon_type"],
        couponAmount: num.tryParse((json["coupon_amount"]).toString()),
        commissionType: json["commission_type"],
        commissionCharge:
            num.tryParse((json["commission_charge"]).toString())?.toInt(),
        commissionAmount: num.tryParse((json["commission_amount"]).toString()),
        paymentGateway: json["payment_gateway"],
        paymentStatus: json["payment_status"],
        status: int.tryParse((json["status"]).toString()),
        isOrderOnline: int.tryParse((json["is_order_online"]).toString()),
        orderCompleteRequest:
            int.tryParse((json["order_complete_request"]).toString()),
        cancelOrderMoneyReturn:
            int.tryParse((json["cancel_order_money_return"]).toString()),
        transactionId: json["transaction_id"],
        orderNote: json["order_note"],
        manualPaymentImage: json["manual_payment_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "service_id": serviceId,
        "seller_id": sellerId,
        "buyer_id": buyerId,
        "name": name,
        "email": email,
        "phone": phone,
        "post_code": postCode,
        "address": address,
        "city": city,
        "area": area,
        "country": country,
        "date": date,
        "schedule": schedule,
        "package_fee": packageFee,
        "extra_service": extraService,
        "sub_total": subTotal,
        "tax": tax,
        "total": total,
        "coupon_code": couponCode,
        "coupon_type": couponType,
        "coupon_amount": couponAmount,
        "commission_type": commissionType,
        "commission_charge": commissionCharge,
        "commission_amount": commissionAmount,
        "payment_gateway": paymentGateway,
        "payment_status": paymentStatus,
        "status": status,
        "is_order_online": isOrderOnline,
        "order_complete_request": orderCompleteRequest,
        "cancel_order_money_return": cancelOrderMoneyReturn,
        "transaction_id": transactionId,
        "order_note": orderNote,
        "manual_payment_image": manualPaymentImage,
      };
}
