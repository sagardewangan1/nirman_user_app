// To parse this JSON data, do
//
//     final serviceByFilterModel = serviceByFilterModelFromJson(jsonString);

import 'dart:convert';

import 'package:qixer/view/utils/others_helper.dart';

import 'recent_service_model.dart';

ServiceByFilterModel serviceByFilterModelFromJson(String str) =>
    ServiceByFilterModel.fromJson(json.decode(str));

String serviceByFilterModelToJson(ServiceByFilterModel data) =>
    json.encode(data.toJson());

class ServiceByFilterModel {
  ServiceByFilterModel({
    required this.allServices,
    required this.serviceImage,
  });

  AllServices allServices;
  List<ServiceImage?> serviceImage;

  factory ServiceByFilterModel.fromJson(Map<String, dynamic>? json) =>
      ServiceByFilterModel(
        allServices: AllServices.fromJson(json?["all_services"]),
        serviceImage: List<ServiceImage?>.from(json?["service_image"].map((x) {
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

  factory AllServices.fromJson(Map<String, dynamic> json) => AllServices(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        lastPage: json["last_page"].toString().tryToParse.toInt(),
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
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

class Datum {
  Datum({
    this.id,
    this.sellerId,
    this.title,
    this.imageUrl,
    this.sellerName,
    this.price,
    this.image,
    this.isServiceOnline,
    this.serviceCityId,
    required this.sellerForMobile,
    required this.reviewsForMobile,
  });

  int? id;
  int? sellerId;
  String? imageUrl;
  String? title;
  String? sellerName;
  double? price;
  String? image;
  int? isServiceOnline;
  int? serviceCityId;
  SellerForMobile? sellerForMobile;
  List<ReviewsForMobile> reviewsForMobile;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"].toString().tryToParse.toInt(),
        sellerId: json["seller_id"].toString().tryToParse.toInt(),
        title: json["title"],
        sellerName: json["seller_name"],
        imageUrl: json["image_url"],
        price: json["price"].toString().tryToParse.toDouble(),
        image: json["image"],
        isServiceOnline:
            json["is_service_online"].toString().tryToParse.toInt(),
        serviceCityId: json["service_city_id"].toString().tryToParse.toInt(),
        sellerForMobile: json["seller_for_mobile"] == null
            ? null
            : SellerForMobile.fromJson(json["seller_for_mobile"]),
        reviewsForMobile: List<ReviewsForMobile>.from(json["reviews_for_mobile"]
            .map((x) => ReviewsForMobile.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "seller_id": sellerId,
        "title": title,
        "price": price,
        "image": image,
        "is_service_online": isServiceOnline,
        "service_city_id": serviceCityId,
        "seller_for_mobile": sellerForMobile?.toJson(),
        "reviews_for_mobile":
            List<dynamic>.from(reviewsForMobile.map((x) => x.toJson())),
      };
}

class Countryy {
  Countryy({
    this.id,
    this.country,
    this.status,
  });

  int? id;
  String? country;
  int? status;

  factory Countryy.fromJson(Map<String, dynamic> json) => Countryy(
        id: json["id"].toString().tryToParse.toInt(),
        country: json["country"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "country": country,
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
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
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

  Map<String, dynamic>? toJson() => {
        "image_id": imageId,
        "path": path,
        "img_url": imgUrl,
        "img_alt": imgAlt,
      };
}
