// To parse this JSON data, do
//
//     final topAllServicesModel = topAllServicesModelFromJson(jsonString);

import 'dart:convert';

import 'package:qixer/view/utils/others_helper.dart';

import 'service_by_filter_model.dart';

TopAllServicesModel topAllServicesModelFromJson(String str) =>
    TopAllServicesModel.fromJson(json.decode(str));

String topAllServicesModelToJson(TopAllServicesModel data) =>
    json.encode(data.toJson());

class TopAllServicesModel {
  TopAllServicesModel({
    required this.topServices,
    required this.serviceImage,
    required this.reviewerImage,
  });

  TopServices topServices;
  List<Image> serviceImage;

  List<dynamic> reviewerImage;

  factory TopAllServicesModel.fromJson(Map<String, dynamic> json) =>
      TopAllServicesModel(
        topServices: TopServices.fromJson(json["top_services"]),
        serviceImage: List<Image>.from(
            json["service_image"].map((x) => Image.fromJson(x))),
        reviewerImage: List<dynamic>.from(json["reviewer_image"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "top_services": topServices.toJson(),
        "service_image":
            List<dynamic>.from(serviceImage.map((x) => x.toJson())),
        "reviewer_image": List<dynamic>.from(reviewerImage.map((x) => x)),
      };
}

class Image {
  Image({
    this.imageId,
    this.path,
    this.imgUrl,
    this.imgAlt,
  });

  int? imageId;
  String? path;
  String? imgUrl;
  dynamic imgAlt;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        imageId: json["image_id"].toString().tryToParse.toInt(),
        path: json["path"],
        imgUrl: json["img_url"],
        imgAlt: json["img_alt"],
      );

  Map<String, dynamic> toJson() => {
        "image_id": imageId,
        "path": path,
        "img_url": imgUrl,
        "img_alt": imgAlt,
      };
}

class TopServices {
  TopServices({
    this.currentPage,
    required this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.nextPageUrl,
    this.path,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  int? currentPage;
  List<Datum> data;
  String? firstPageUrl;
  dynamic from;
  dynamic lastPage;
  String? lastPageUrl;
  String? nextPageUrl;
  String? path;
  dynamic prevPageUrl;
  dynamic to;
  int? total;

  factory TopServices.fromJson(Map<String, dynamic> json) => TopServices(
        currentPage: json["current_page"].toString().tryToParse.toInt(),
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"].toString().tryToParse.toInt(),
        lastPage: json["last_page"].toString().tryToParse.toInt(),
        lastPageUrl: json["last_page_url"],
        nextPageUrl: json["next_page_url"],
        path: json["path"],
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
        "next_page_url": nextPageUrl,
        "path": path,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}
