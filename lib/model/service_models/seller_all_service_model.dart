// To parse this JSON data, do
//
//     final sellerAllServiceModel = sellerAllServiceModelFromJson(jsonString);

import 'dart:convert';

import 'package:qixer/helper/extension/string_extension.dart';

import '../service_by_filter_model.dart';

SellerAllServiceModel sellerAllServiceModelFromJson(String str) =>
    SellerAllServiceModel.fromJson(json.decode(str));

String sellerAllServiceModelToJson(SellerAllServiceModel data) =>
    json.encode(data.toJson());

class SellerAllServiceModel {
  SellerAllServiceModel({
    required this.services,
  });

  Services services;

  factory SellerAllServiceModel.fromJson(Map<String, dynamic> json) =>
      SellerAllServiceModel(
        services: Services.fromJson(json["services"]),
      );

  Map<String, dynamic> toJson() => {
        "services": services.toJson(),
      };
}

class Services {
  Services({
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

  factory Services.fromJson(Map<String, dynamic> json) => Services(
        currentPage: json["current_page"].toString().tryToParse.toInt(),
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"].toString().tryToParse.toInt(),
        lastPage: json["last_page"].toString().tryToParse.toInt(),
        lastPageUrl: json["last_page_url"],
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"].toString().tryToParse.toInt(),
        prevPageUrl: json["prev_page_url"],
        to: json["to"].toString().tryToParse.toInt(),
        total: json["total"].toString().tryToParse.toInt(),
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
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
      };
}
