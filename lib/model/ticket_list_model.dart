// To parse this JSON data, do
//
//     final ticketListModel = ticketListModelFromJson(jsonString);

import 'dart:convert';

TicketListModel ticketListModelFromJson(String str) =>
    TicketListModel.fromJson(json.decode(str));

String ticketListModelToJson(TicketListModel data) =>
    json.encode(data.toJson());

class TicketListModel {
  TicketListModel({
    this.buyerId,
    required this.tickets,
  });

  int? buyerId;
  Tickets tickets;

  factory TicketListModel.fromJson(Map<String, dynamic> json) =>
      TicketListModel(
        buyerId: json["buyer_id"],
        tickets: Tickets.fromJson(json["tickets"]),
      );

  Map<String, dynamic> toJson() => {
        "buyer_id": buyerId,
        "tickets": tickets.toJson(),
      };
}

class Tickets {
  Tickets({
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
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  factory Tickets.fromJson(Map<String, dynamic> json) => Tickets(
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
    this.title,
    this.description,
    this.subject,
    this.priority,
    this.status,
  });

  int? id;
  String? title;
  dynamic description;
  String? subject;
  String? priority;
  String? status;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: int.tryParse(json["id"].toString()),
        title: json["title"],
        description: json["description"],
        subject: json["subject"],
        priority: json["priority"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "subject": subject,
        "priority": priority,
        "status": status,
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
