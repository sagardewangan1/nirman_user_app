// To parse this JSON data, do
//
//     final serviceByFilterModel = serviceByFilterModelFromJson(jsonString);

import 'dart:convert';

import 'package:qixer/view/utils/others_helper.dart';

import 'service_search_model.dart';

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
  int? status;
  int? experienece;

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
  Datum(
      {this.id,
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
      this.status,
      this.experience,
      this.serviceAreas});

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
  int? status;
  String? experience;
  List<ServiceAreas>? serviceAreas;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"].toString().tryToParse.toInt(),
        sellerId: json["seller_id"].toString().tryToParse.toInt(),
        title: json["title"],
        status: json["status"],
        experience: json["experience"],
        imageUrl: json["image_url"],
        price: json["price"].toString().tryToParse.toDouble(),
        image: json["image"],
        isServiceOnline:
            json["is_service_online"].toString().tryToParse.toInt(),
        serviceCityId: json["service_city_id"].toString().tryToParse.toInt(),
        sellerForMobile: (json["seller_for_mobile"] != null &&
                json["seller_for_mobile"] is Map)
            ? SellerForMobile.fromJson(json["seller_for_mobile"])
            : null,
        serviceAreas: json["service_areas"] == null
            ? []
            : List<ServiceAreas>.from(
                json["service_areas"]!.map((x) => ServiceAreas.fromJson(x))),
        reviewsForMobile: List<ReviewsForMobile>.from(json["reviews_for_mobile"]
            .map((x) => ReviewsForMobile.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "seller_id": sellerId,
        "title": title,
        "status": status,
        "experience": experience,
        "price": price,
        "image": image,
        "is_service_online": isServiceOnline,
        "service_city_id": serviceCityId,
        "seller_for_mobile": sellerForMobile?.toJson(),
        "serviceAreas": serviceAreas == null
            ? []
            : List<dynamic>.from(serviceAreas!.map((x) => x.toJson())),
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

class SellerForMobile {
  SellerForMobile({
    this.id,
    this.name,
    this.image,
    this.countryId,
    this.phone,
    this.serviceCity,
    this.serviceArea,
    this.address,
    this.latitude,
    this.longitude,
    this.sellerAddress,
    this.postCode,
    this.username,
    this.businessName,
    this.businessGstNumber,
    this.businessPhoneNumber,
    this.businessEmail,
    this.businessFullAddress,
    this.businessDescription,
    this.sellerBusinessImg,
    this.workingCategories,
    this.userServiceArea,
  });

  int? id;
  String? name;
  String? image;
  dynamic countryId;
  String? phone;
  String? serviceCity;
  List<int>?
      serviceArea; // 🔥 Convert service_area from JSON string to List<int>
  String? address;
  double? latitude;
  double? longitude;
  String? sellerAddress;
  String? postCode;
  String? username;
  String? businessName;
  String? businessGstNumber;
  String? businessPhoneNumber;
  String? businessEmail;
  String? businessFullAddress;
  String? businessDescription;
  String? sellerBusinessImg;
  String? workingCategories;
  List<UserServiceArea>? userServiceArea; // ✅ New field for `user_service_area`

  factory SellerForMobile.fromJson(Map<String, dynamic> json) =>
      SellerForMobile(
        id: json["id"] as int?,
        name: json["name"],
        image: json["image"],
        countryId: json["country_id"],
        phone: json["phone"],
        serviceCity: json["service_city"],
        // ✅ Fix `service_area` parsing issue
        serviceArea: json["service_area"] != null
            ? (json["service_area"] is String
                ? (jsonDecode(json["service_area"]) is List<dynamic>
                    ? (jsonDecode(json["service_area"]) as List<dynamic>)
                        .map((e) => int.tryParse(e.toString()) ?? 0)
                        .toList()
                    : [
                        int.tryParse(json["service_area"]) ?? 0
                      ]) // If it's a single int in string form
                : (json["service_area"] is int
                    ? [
                        json["service_area"]
                      ] // If it's a single integer, wrap in a list
                    : (json["service_area"] as List<dynamic>)
                        .map((e) => int.tryParse(e.toString()) ?? 0)
                        .toList()))
            : [],
        address: json["address"],

        // ✅ Fix latitude/longitude conversion issues
        latitude:
            (json["latitude"] != null && json["latitude"].toString().isNotEmpty)
                ? double.tryParse(json["latitude"].toString())
                : null,
        longitude: (json["longitude"] != null &&
                json["longitude"].toString().isNotEmpty)
            ? double.tryParse(json["longitude"].toString())
            : null,

        sellerAddress: json["seller_address"],
        postCode: json["post_code"],
        username: json["username"],
        businessName: json["businessName"],
        businessGstNumber: json["businessGstNumber"],
        businessPhoneNumber: json["businessPhoneNumber"],
        businessEmail: json["businessEmail"],
        businessFullAddress: json["businessFullAddress"],
        businessDescription: json["businessDescription"],
        sellerBusinessImg: (json["seller_business_img"] != null &&
                json["seller_business_img"] is String &&
                json["seller_business_img"].isNotEmpty)
            ? json["seller_business_img"]
            : '',
        workingCategories: json["working_categories"] != null
            ? (json["working_categories"] is String
                ? jsonDecode(json["working_categories"])
                    .map((e) => e.toString())
                    .join(",")
                : json["working_categories"].toString())
            : null,

        // ✅ Fix `user_service_area` parsing issue
        userServiceArea: (json["user_service_area"] is List)
            ? (json["user_service_area"] as List)
                .map((e) => UserServiceArea.fromJson(e))
                .toList()
            : [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "country_id": countryId,
        "phone": phone,
        "service_city": serviceCity,
        "service_area": serviceArea,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "seller_address": sellerAddress,
        "post_code": postCode,
        "username": username,
        "businessName": businessName,
        "businessGstNumber": businessGstNumber,
        "businessPhoneNumber": businessPhoneNumber,
        "businessEmail": businessEmail,
        "businessFullAddress": businessFullAddress,
        "businessDescription": businessDescription,
        "seller_business_img": sellerBusinessImg,
        "working_categories": workingCategories,
        "user_service_area": userServiceArea?.map((e) => e.toJson()).toList(),
      };
}

class UserServiceArea {
  UserServiceArea({
    this.id,
    this.serviceArea,
    this.serviceCityId,
    this.countryId,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? serviceArea;
  int? serviceCityId;
  int? countryId;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory UserServiceArea.fromJson(Map<String, dynamic> json) =>
      UserServiceArea(
        id: json["id"] as int?,
        serviceArea: json["service_area"],
        serviceCityId: json["service_city_id"] as int?,
        countryId: json["country_id"] as int?,
        status: json["status"] as int?,
        createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"])
            : null,
        updatedAt: json["updated_at"] != null
            ? DateTime.parse(json["updated_at"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "service_area": serviceArea,
        "service_city_id": serviceCityId,
        "country_id": countryId,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
