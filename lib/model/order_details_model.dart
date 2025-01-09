// To parse this JSON data, do
//
//     final orderDetailsModel = orderDetailsModelFromJson(jsonString);

import 'dart:convert';

OrderDetailsModel orderDetailsModelFromJson(String str) =>
    OrderDetailsModel.fromJson(json.decode(str));

String orderDetailsModelToJson(OrderDetailsModel data) =>
    json.encode(data.toJson());

class OrderDetailsModel {
  OrderDetailsModel({
    required this.orderInfo,
  });

  OrderInfo orderInfo;

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) =>
      OrderDetailsModel(
        orderInfo: OrderInfo.fromJson(json["orderInfo"]),
      );

  Map<String, dynamic> toJson() => {
        "orderInfo": orderInfo.toJson(),
      };
}

class OrderInfo {
  OrderInfo({
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
    this.createdAt,
    this.updatedAt,
    this.manualPaymentImage,
    this.sellerDetails,
    this.seller,
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
  String? packageFee;
  String? extraService;
  String? subTotal;
  String? tax;
  String? total;
  dynamic couponCode;
  String? couponType;
  var couponAmount;
  String? commissionType;
  int? commissionCharge;
  double? commissionAmount;
  String? paymentGateway;
  String? paymentStatus;
  int? status;
  int? isOrderOnline;
  int? orderCompleteRequest;
  int? cancelOrderMoneyReturn;
  dynamic transactionId;
  dynamic orderNote;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic manualPaymentImage;
  Seller? sellerDetails;
  Seller? seller;

  factory OrderInfo.fromJson(Map<String, dynamic>? json) => OrderInfo(
        id: int.tryParse((["id"].toString())),
        serviceId: int.tryParse((json?["service_id"]).toString()),
        sellerId: int.tryParse((json?["seller_id"]).toString()),
        buyerId: int.tryParse((json?["buyer_id"]).toString()),
        name: json?["name"],
        email: json?["email"],
        phone: json?["phone"],
        postCode: json?["post_code"],
        address: json?["address"],
        city: int.tryParse((json?["city"]).toString()),
        area: int.tryParse((json?["area"]).toString()),
        country: int.tryParse((json?["country"]).toString()),
        date: json?["date"] == null ? null : DateTime.parse(json?["date"]),
        schedule: json?["schedule"],
        packageFee: json?["package_fee"],
        extraService: json?["extra_service"],
        subTotal: json?["sub_total"],
        tax: json?["tax"],
        total: json?["total"],
        couponCode: json?["coupon_code"],
        couponType: json?["coupon_type"],
        couponAmount: num.tryParse((json?["coupon_amount"]).toString()),
        commissionType: json?["commission_type"],
        commissionCharge:
            num.tryParse((json?["commission_charge"]).toString())?.toInt(),
        commissionAmount:
            num.tryParse((json?["commission_amount"]).toString())?.toDouble(),
        paymentGateway: json?["payment_gateway"],
        paymentStatus: json?["payment_status"],
        status: int.tryParse((json?["status"]).toString()),
        isOrderOnline: int.tryParse((json?["is_order_online"]).toString()),
        orderCompleteRequest:
            int.tryParse((json?["order_complete_request"]).toString()),
        cancelOrderMoneyReturn:
            int.tryParse((json?["cancel_order_money_return"]).toString()),
        transactionId: json?["transaction_id"],
        orderNote: json?["order_note"],
        createdAt: DateTime.parse(json?["created_at"]),
        updatedAt: DateTime.parse(json?["updated_at"]),
        manualPaymentImage: json?["manual_payment_image"],
        sellerDetails: json?["seller_details"] != null
            ? Seller.fromJson(json?["seller_details"])
            : null,
        seller: Seller.fromJson(json?["seller"]),
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
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "manual_payment_image": manualPaymentImage,
        "seller_details": sellerDetails?.toJson(),
        "seller": seller?.toJson(),
      };
}

class Seller {
  Seller({
    this.id,
    this.name,
    this.email,
    this.username,
    this.phone,
    this.image,
    this.profileBackground,
    this.serviceCity,
    this.serviceArea,
    this.userType,
    this.userStatus,
    this.termsCondition,
    this.address,
    this.state,
    this.about,
    this.postCode,
    this.countryId,
    this.emailVerified,
    this.emailVerifyToken,
    this.facebookId,
    this.googleId,
    this.countryCode,
    this.createdAt,
    this.updatedAt,
    this.fbUrl,
    this.twUrl,
    this.goUrl,
    this.liUrl,
    this.yoUrl,
    this.inUrl,
    this.twiUrl,
    this.piUrl,
    this.drUrl,
    this.reUrl,
  });

  int? id;
  String? name;
  String? email;
  String? username;
  String? phone;
  String? image;
  String? profileBackground;
  String? serviceCity;
  String? serviceArea;
  int? userType;
  int? userStatus;
  int? termsCondition;
  String? address;
  dynamic state;
  String? about;
  String? postCode;
  int? countryId;
  int? emailVerified;
  String? emailVerifyToken;
  dynamic facebookId;
  dynamic googleId;
  dynamic countryCode;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? fbUrl;
  String? twUrl;
  dynamic goUrl;
  dynamic liUrl;
  String? yoUrl;
  String? inUrl;
  dynamic twiUrl;
  dynamic piUrl;
  dynamic drUrl;
  dynamic reUrl;

  factory Seller.fromJson(Map<String, dynamic>? json) => Seller(
        id: int.tryParse((json?["id"]).toString()),
        name: json?["name"],
        email: json?["email"],
        username: json?["username"],
        phone: json?["phone"],
        image: json?["image"],
        profileBackground: json?["profile_background"],
        serviceCity: json?["service_city"],
        serviceArea: json?["service_area"],
        address: json?["address"],
        state: json?["state"],
        about: json?["about"],
        postCode: json?["post_code"],
        countryId: int.tryParse((json?["country_id"]).toString()),
        emailVerifyToken: json?["email_verify_token"],
        facebookId: json?["facebook_id"],
        googleId: json?["google_id"],
        countryCode: json?["country_code"],
        createdAt: json?["created_at"] != null
            ? DateTime.parse(json?["created_at"])
            : null,
        updatedAt: json?["updated_at"] != null
            ? DateTime.parse(json?["updated_at"])
            : null,
        fbUrl: json?["fb_url"],
        twUrl: json?["tw_url"],
        goUrl: json?["go_url"],
        liUrl: json?["li_url"],
        yoUrl: json?["yo_url"],
        inUrl: json?["in_url"],
        twiUrl: json?["twi_url"],
        piUrl: json?["pi_url"],
        drUrl: json?["dr_url"],
        reUrl: json?["re_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "username": username,
        "phone": phone,
        "image": image,
        "profile_background": profileBackground,
        "service_city": serviceCity,
        "service_area": serviceArea,
        "user_type": userType,
        "user_status": userStatus,
        "terms_condition": termsCondition,
        "address": address,
        "state": state,
        "about": about,
        "post_code": postCode,
        "country_id": countryId,
        "email_verified": emailVerified,
        "email_verify_token": emailVerifyToken,
        "facebook_id": facebookId,
        "google_id": googleId,
        "country_code": countryCode,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "fb_url": fbUrl,
        "tw_url": twUrl,
        "go_url": goUrl,
        "li_url": liUrl,
        "yo_url": yoUrl,
        "in_url": inUrl,
        "twi_url": twiUrl,
        "pi_url": piUrl,
        "dr_url": drUrl,
        "re_url": reUrl,
      };
}
