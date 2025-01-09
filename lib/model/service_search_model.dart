// To parse this JSON data, do
//
//     final serviceSearchModel = serviceSearchModelFromJson(jsonString);

import 'dart:convert';

import 'package:qixer/helper/extension/string_extension.dart';

ServiceSearchModel serviceSearchModelFromJson(String str) =>
    ServiceSearchModel.fromJson(json.decode(str));

String serviceSearchModelToJson(ServiceSearchModel data) =>
    json.encode(data.toJson());

class ServiceSearchModel {
  List<MainService>? mainServices;
  int? maxPrice;
  String? googleMapStatus;

  ServiceSearchModel({
    this.mainServices,
    this.maxPrice,
    this.googleMapStatus,
  });

  factory ServiceSearchModel.fromJson(Map json) => ServiceSearchModel(
        mainServices: json["main_services"] == null
            ? []
            : List<MainService>.from(
                json["main_services"]!.map((x) => MainService.fromJson(x))),
        maxPrice: json["max_price"],
        googleMapStatus: json["google_map_status"],
      );

  Map<String, dynamic> toJson() => {
        "main_services": mainServices == null
            ? []
            : List<dynamic>.from(mainServices!.map((x) => x.toJson())),
        "max_price": maxPrice,
        "google_map_status": googleMapStatus,
      };
}

class MainService {
  Service? service;
  String? imageUrl;

  MainService({
    this.service,
    this.imageUrl,
  });

  factory MainService.fromJson(Map<String, dynamic> json) => MainService(
        service:
            json["service"] == null ? null : Service.fromJson(json["service"]),
        imageUrl: json["image_url"],
      );

  Map<String, dynamic> toJson() => {
        "service": service?.toJson(),
        "image_url": imageUrl,
      };
}

class Service {
  dynamic id;
  dynamic categoryId;
  dynamic subcategoryId;
  dynamic childCategoryId;
  dynamic sellerId;
  dynamic serviceCityId;
  dynamic serviceAreaId;
  String? title;
  String? slug;
  String? description;
  String? image;
  String? imageGallery;
  String? video;
  dynamic status;
  dynamic isServiceOn;
  num price;
  dynamic onlineServicePrice;
  dynamic deliveryDays;
  dynamic revision;
  dynamic isServiceOnline;
  dynamic isServiceAllCities;
  dynamic tax;
  dynamic view;
  dynamic soldCount;
  dynamic featured;
  dynamic adminId;
  dynamic guardName;
  DateTime? createdAt;
  DateTime? updatedAt;
  SellerForMobile? sellerForMobile;
  List<ReviewsForMobile>? reviewsForMobile;
  ServiceCity? serviceCity;

  Service({
    this.id,
    this.categoryId,
    this.subcategoryId,
    this.childCategoryId,
    this.sellerId,
    this.serviceCityId,
    this.serviceAreaId,
    this.title,
    this.slug,
    this.description,
    this.image,
    this.imageGallery,
    this.video,
    this.status,
    this.isServiceOn,
    required this.price,
    this.onlineServicePrice,
    this.deliveryDays,
    this.revision,
    this.isServiceOnline,
    this.isServiceAllCities,
    this.tax,
    this.view,
    this.soldCount,
    this.featured,
    this.adminId,
    this.guardName,
    this.createdAt,
    this.updatedAt,
    this.sellerForMobile,
    this.reviewsForMobile,
    this.serviceCity,
  });

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        id: json["id"],
        categoryId: json["category_id"],
        subcategoryId: json["subcategory_id"],
        childCategoryId: json["child_category_id"],
        sellerId: json["seller_id"],
        serviceCityId: json["service_city_id"],
        serviceAreaId: json["service_area_id"],
        title: json["title"],
        slug: json["slug"],
        description: json["description"],
        image: json["image"],
        imageGallery: json["image_gallery"],
        video: json["video"],
        status: json["status"],
        isServiceOn: json["is_service_on"],
        price: json["price"].toString().tryToParse,
        onlineServicePrice: json["online_service_price"],
        deliveryDays: json["delivery_days"],
        revision: json["revision"],
        isServiceOnline: json["is_service_online"].toString().tryToParse,
        isServiceAllCities: json["is_service_all_cities"],
        tax: json["tax"].toString().tryToParse,
        view: json["view"].toString().tryToParse,
        soldCount: json["sold_count"].toString().tryToParse,
        featured: json["featured"],
        adminId: json["admin_id"],
        guardName: json["guard_name"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        sellerForMobile: json["seller_for_mobile"] == null
            ? null
            : SellerForMobile.fromJson(json["seller_for_mobile"]),
        reviewsForMobile: json["reviews_for_mobile"] == null
            ? []
            : List<ReviewsForMobile>.from(json["reviews_for_mobile"]!
                .map((x) => ReviewsForMobile.fromJson(x))),
        serviceCity: json["service_city"] == null
            ? null
            : ServiceCity.fromJson(json["service_city"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_id": categoryId,
        "subcategory_id": subcategoryId,
        "child_category_id": childCategoryId,
        "seller_id": sellerId,
        "service_city_id": serviceCityId,
        "service_area_id": serviceAreaId,
        "title": title,
        "slug": slug,
        "description": description,
        "image": image,
        "image_gallery": imageGallery,
        "video": video,
        "status": status,
        "is_service_on": isServiceOn,
        "price": price,
        "online_service_price": onlineServicePrice,
        "delivery_days": deliveryDays,
        "revision": revision,
        "is_service_online": isServiceOnline,
        "is_service_all_cities": isServiceAllCities,
        "tax": tax,
        "view": view,
        "sold_count": soldCount,
        "featured": featured,
        "admin_id": adminId,
        "guard_name": guardName,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "seller_for_mobile": sellerForMobile?.toJson(),
        "reviews_for_mobile": reviewsForMobile == null
            ? []
            : List<dynamic>.from(reviewsForMobile!.map((x) => x.toJson())),
        "service_city": serviceCity?.toJson(),
      };
}

class ReviewsForMobile {
  dynamic id;
  dynamic serviceId;
  num rating;
  String? message;
  dynamic buyerId;

  ReviewsForMobile({
    this.id,
    this.serviceId,
    required this.rating,
    this.message,
    this.buyerId,
  });

  factory ReviewsForMobile.fromJson(Map<String, dynamic> json) =>
      ReviewsForMobile(
        id: json["id"],
        serviceId: json["service_id"],
        rating: json["rating"].toString().tryToParse,
        message: json["message"],
        buyerId: json["buyer_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "service_id": serviceId,
        "rating": rating,
        "message": message,
        "buyer_id": buyerId,
      };
}

class SellerForMobile {
  dynamic id;
  String? name;
  String? image;
  dynamic countryId;
  double lat;
  double lng;

  SellerForMobile({
    this.id,
    this.name,
    this.image,
    this.countryId,
    required this.lat,
    required this.lng,
  });

  factory SellerForMobile.fromJson(Map<String, dynamic> json) =>
      SellerForMobile(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        lat: json["latitude"].toString().tryToParse.toDouble(),
        lng: json["longitude"].toString().tryToParse.toDouble(),
        countryId: json["country_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "country_id": countryId,
      };
}

class ServiceCity {
  dynamic id;
  String? serviceCity;
  dynamic countryId;
  dynamic status;
  DateTime? createdAt;
  DateTime? updatedAt;

  ServiceCity({
    this.id,
    this.serviceCity,
    this.countryId,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory ServiceCity.fromJson(Map<String, dynamic> json) => ServiceCity(
        id: json["id"],
        serviceCity: json["service_city"],
        countryId: json["country_id"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "service_city": serviceCity,
        "country_id": countryId,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
