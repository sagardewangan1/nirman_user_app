// To parse this JSON data, do
//
//     final chatListModel = chatListModelFromJson(jsonString);

import 'dart:convert';

ChatListModel chatListModelFromJson(String str) =>
    ChatListModel.fromJson(json.decode(str));

String chatListModelToJson(ChatListModel data) => json.encode(data.toJson());

class ChatListModel {
  ChatListModel({
    required this.chatSellerLists,
  });

  List<ChatSellerList> chatSellerLists;

  factory ChatListModel.fromJson(Map<String, dynamic> json) => ChatListModel(
        chatSellerLists: List<ChatSellerList>.from(
            json["chat_seller_lists"].map((x) => ChatSellerList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "chat_seller_lists":
            List<dynamic>.from(chatSellerLists.map((x) => x.toJson())),
      };
}

class ChatSellerList {
  ChatSellerList({
    this.sellerId,
    this.dateTimeStr,
    this.dateHumanReadable,
    this.imageUrl,
    this.senderProfileImage,
    this.sellerList,
  });

  dynamic sellerId;
  String? dateTimeStr;
  dynamic dateHumanReadable;
  String? imageUrl;
  dynamic senderProfileImage;
  SellerList? sellerList;

  factory ChatSellerList.fromJson(Map<String, dynamic> json) => ChatSellerList(
        sellerId: json["seller_id"],
        dateTimeStr: json["date_time_str"],
        dateHumanReadable: json["date_human_readable"],
        imageUrl: json["seller_image"]?["image_url"],
        senderProfileImage: json["sender_profile_image"],
        sellerList: json["seller_list"] == null
            ? null
            : SellerList.fromJson(json["seller_list"]),
      );

  Map<String, dynamic> toJson() => {
        "seller_id": sellerId,
        "date_time_str": dateTimeStr,
        "date_human_readable": dateHumanReadable,
        "image_url": imageUrl,
        "sender_profile_image": senderProfileImage,
        "seller_list": sellerList?.toJson(),
      };
}

class SellerList {
  SellerList({
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

  dynamic id;
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
  dynamic termsCondition;
  String? address;
  String? state;
  String? about;
  String? postCode;
  dynamic countryId;
  dynamic emailVerified;
  String? emailVerifyToken;
  dynamic facebookId;
  dynamic googleId;
  String? countryCode;
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

  factory SellerList.fromJson(Map<String, dynamic> json) => SellerList(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        username: json["username"],
        phone: json["phone"],
        image: json["image"],
        profileBackground: json["profile_background"],
        serviceCity: json["service_city"],
        serviceArea: json["service_area"],
        userType: json["user_type"],
        userStatus: json["user_status"],
        termsCondition: json["terms_condition"],
        address: json["address"],
        state: json["state"],
        about: json["about"],
        postCode: json["post_code"],
        countryId: json["country_id"],
        emailVerified: json["email_verified"],
        emailVerifyToken: json["email_verify_token"],
        facebookId: json["facebook_id"],
        googleId: json["google_id"],
        countryCode: json["country_code"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        fbUrl: json["fb_url"],
        twUrl: json["tw_url"],
        goUrl: json["go_url"],
        liUrl: json["li_url"],
        yoUrl: json["yo_url"],
        inUrl: json["in_url"],
        twiUrl: json["twi_url"],
        piUrl: json["pi_url"],
        drUrl: json["dr_url"],
        reUrl: json["re_url"],
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
