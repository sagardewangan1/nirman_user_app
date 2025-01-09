// To parse this JSON data, do
//
//     final servicebyCategoryModel = servicebyCategoryModelFromJson(jsonString);

import 'dart:convert';

import 'package:qixer/view/utils/others_helper.dart';

import 'service_by_filter_model.dart';

ServicebyCategoryModel servicebyCategoryModelFromJson(String str) =>
    ServicebyCategoryModel.fromJson(json.decode(str));

String servicebyCategoryModelToJson(ServicebyCategoryModel data) =>
    json.encode(data.toJson());

class ServicebyCategoryModel {
  ServicebyCategoryModel({
    required this.allServices,
    required this.serviceImage,
  });

  AllServices allServices;
  List<ServiceImage?> serviceImage;

  factory ServicebyCategoryModel.fromJson(Map<String, dynamic> json) =>
      ServicebyCategoryModel(
        allServices: AllServices.fromJson(json["all_services"]),
        serviceImage: List<ServiceImage?>.from(json["service_image"].map((x) {
          if (x is List) {
            return null;
          } else {
            return ServiceImage.fromJson(x);
          }
        })),
      );

  Map<String, dynamic> toJson() => {
        "all_services": allServices.toJson(),
        "service_image":
            List<dynamic>.from(serviceImage.map((x) => x?.toJson())),
      };
}

class AllServices {
  AllServices({
    this.currentPage,
    required this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
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
  List? links;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  factory AllServices.fromJson(Map<String, dynamic> json) => AllServices(
        currentPage: json["current_page"].toString().tryToParse.toInt(),
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        lastPage: json["last_page"].toString().tryToParse.toInt(),
        total: json["total"].toString().tryToParse.toInt(),
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class ServiceImage {
  ServiceImage({
    this.imageId,
    this.path,
    this.imgUrl,
    this.imgAlt,
  });

  int? imageId;
  String? path;
  String? imgUrl;
  dynamic imgAlt;

  factory ServiceImage.fromJson(Map<String, dynamic>? json) => ServiceImage(
        imageId: json?["image_id"],
        path: json?["path"],
        imgUrl: json?["img_url"],
        imgAlt: json?["img_alt"],
      );

  Map<String, dynamic> toJson() => {
        "image_id": imageId,
        "path": path,
        "img_url": imgUrl,
        "img_alt": imgAlt,
      };
}
