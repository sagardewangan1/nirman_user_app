// To parse this JSON data, do
//
//     final statesDropdownModel = statesDropdownModelFromJson(jsondynamic);

import 'dart:convert';

import 'package:qixer/helper/extension/string_extension.dart';

StatesDropdownModel statesDropdownModelFromJson(dynamic str) =>
    StatesDropdownModel.fromJson(json.decode(str));

dynamic statesDropdownModelToJson(StatesDropdownModel data) =>
    json.encode(data.toJson());

class StatesDropdownModel {
  StatesDropdownModel({
    required this.serviceCities,
  });

  ServiceCities serviceCities;

  factory StatesDropdownModel.fromJson(Map<dynamic, dynamic> json) =>
      StatesDropdownModel(
        serviceCities: ServiceCities.fromJson(json['service_cities']),
      );

  Map<dynamic, dynamic> toJson() => {
        "service_cities": serviceCities.toJson(),
      };
}

class ServiceCities {
  ServiceCities({
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

  dynamic currentPage;
  List<Datum> data;
  dynamic firstPageUrl;
  dynamic from;
  dynamic lastPage;
  dynamic lastPageUrl;
  List<Link> links;
  dynamic nextPageUrl;
  dynamic path;
  dynamic perPage;
  dynamic prevPageUrl;
  dynamic to;
  dynamic total;

  factory ServiceCities.fromJson(Map<dynamic, dynamic> json) => ServiceCities(
        currentPage: json["current_page"].toString().tryToParse.toInt(),
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"].toString().tryToParse.toInt(),
        lastPage: json["last_page"].toString().tryToParse.toInt(),
        lastPageUrl: json["last_page_url"],
        links: [],
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"].toString().tryToParse.toInt(),
        prevPageUrl: json["prev_page_url"],
        to: json["to"].toString().tryToParse.toInt(),
        total: json["total"].toString().tryToParse.toInt(),
      );

  Map<dynamic, dynamic> toJson() => {
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
    this.serviceCity,
  });

  dynamic id;
  dynamic serviceCity;

  factory Datum.fromJson(Map<dynamic, dynamic> json) => Datum(
        id: json["id"],
        serviceCity: json["service_city"],
      );

  Map<dynamic, dynamic> toJson() => {
        "id": id,
        "service_city": serviceCity,
      };
}

class Link {
  Link({
    this.url,
    this.label,
    this.active,
  });

  dynamic url;
  dynamic label;
  bool? active;

  factory Link.fromJson(Map<dynamic, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<dynamic, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
      };
}
