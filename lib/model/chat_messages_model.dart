// To parse this JSON data, do
//
//     final chatMessagesModel = chatMessagesModelFromJson(jsonString);

import 'dart:convert';

ChatMessagesModel chatMessagesModelFromJson(String str) =>
    ChatMessagesModel.fromJson(json.decode(str));

String chatMessagesModelToJson(ChatMessagesModel data) =>
    json.encode(data.toJson());

class ChatMessagesModel {
  ChatMessagesModel({
    required this.messages,
  });

  Messages messages;

  factory ChatMessagesModel.fromJson(Map<String, dynamic> json) =>
      ChatMessagesModel(
        messages: Messages.fromJson(json["messages"]),
      );

  Map<String, dynamic> toJson() => {
        "messages": messages.toJson(),
      };
}

class Messages {
  Messages({
    this.currentPage,
    required this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    required this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  int? currentPage;
  List<Datum> data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link> links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  factory Messages.fromJson(Map<String, dynamic> json) => Messages(
        currentPage: int.tryParse((json["current_page"]).toString()),
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        lastPage: int.tryParse((json["last_page"]).toString()),
        links: [],
        total: int.tryParse((json["total"]).toString()),
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": List<dynamic>.from(links.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class Datum {
  Datum({
    this.id,
    this.fromUser,
    this.toUser,
    this.sellerId,
    this.buyerId,
    this.message,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.dateTimeStr,
    this.dateHumanReadable,
    this.imageUrl,
    this.senderProfileImage,
  });

  int? id;
  int? fromUser;
  int? toUser;
  int? sellerId;
  int? buyerId;
  String? message;
  String? image;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? dateTimeStr;
  String? dateHumanReadable;
  String? imageUrl;
  String? senderProfileImage;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: int.tryParse((json["id"]).toString()),
        fromUser: int.tryParse((json["from_user"]).toString()),
        toUser: int.tryParse((json["to_user"]).toString()),
        sellerId: int.tryParse((json["seller_id"]).toString()),
        buyerId: int.tryParse((json["buyer_id"]).toString()),
        message: json["message"],
        image: json["image"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        dateTimeStr: json["date_time_str"],
        dateHumanReadable: json["date_human_readable"],
        imageUrl: json["image_url"],
        senderProfileImage: json["sender_profile_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "from_user": fromUser,
        "to_user": toUser,
        "seller_id": sellerId,
        "buyer_id": buyerId,
        "message": message,
        "image": image,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "date_time_str": dateTimeStr,
        "date_human_readable": dateHumanReadable,
        "image_url": imageUrl,
        "sender_profile_image": senderProfileImage,
      };
}

class Link {
  Link({
    this.url,
    this.label,
    this.active,
  });

  String? url;
  String? label;
  bool? active;

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
      };
}
