// To parse this JSON data, do
//
//     final recentServiceModel = recentServiceModelFromJson(jsonString);

import 'dart:convert';

import 'package:qixer/helper/extension/string_extension.dart';
import 'package:qixer/model/service_search_model.dart';

RecentServiceModel recentServiceModelFromJson(String str) =>
    RecentServiceModel.fromJson(json.decode(str));

String recentServiceModelToJson(RecentServiceModel data) =>
    json.encode(data.toJson());

class RecentServiceModel {
  RecentServiceModel({
    required this.latestServices,
    required this.serviceImage,
    required this.reviewerImage,
  });

  List<LatestService> latestServices;
  List<Image?> serviceImage;
  List<dynamic> reviewerImage;

  factory RecentServiceModel.fromJson(Map<String, dynamic> json) =>
      RecentServiceModel(
        latestServices: List<LatestService>.from(
            json["latest_services"].map((x) => LatestService.fromJson(x))),
        serviceImage: List<Image?>.from(json["service_image"].map((x) {
          if (x is List) {
            return null;
          } else {
            return Image?.fromJson(x);
          }
        })),
        reviewerImage: List<dynamic>.from(json["reviewer_image"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "latest_services":
            List<dynamic>.from(latestServices.map((x) => x.toJson())),
        "service_image":
            List<dynamic>.from(serviceImage.map((x) => x?.toJson())),
        "reviewer_image": List<dynamic>.from(reviewerImage.map((x) => x)),
      };
}

class LatestService {
  LatestService({
    this.id,
    this.title,
    this.image,
    this.price,
    this.sellerId,
    this.status,
    this.experience,
    required this.reviewsForMobile,
    required this.serviceAreas,
    required this.sellerForMobile,
  });

  int? id;
  String? title;
  String? image;
  var price;
  int? sellerId;
  int? status;
  String? experience;
  List<ReviewsForMobile> reviewsForMobile;
  List<ServiceAreas>? serviceAreas;
  SellerForMobile? sellerForMobile;

  factory LatestService.fromJson(Map<String, dynamic> json) => LatestService(
        id: json["id"].toString().tryToParse.toInt(),
        title: json["title"],
        image: json["image"],
        price: json["price"],
        sellerId: json["seller_id"].toString().tryToParse.toInt(),
        status: json["status"].toString().tryToParse.toInt(),
        experience: json["experience"].toString(),
        reviewsForMobile: List<ReviewsForMobile>.from(json["reviews_for_mobile"]
            .map((x) => ReviewsForMobile.fromJson(x))),
        serviceAreas: json["service_areas"] == null
            ? []
            : List<ServiceAreas>.from(
                json["service_areas"]!.map((x) => ServiceAreas.fromJson(x))),
        sellerForMobile: json["seller_for_mobile"] == null
            ? null
            : SellerForMobile.fromJson(json["seller_for_mobile"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image": image,
        "price": price,
        "seller_id": sellerId,
        "status": status,
        "String": experience,
        "reviews_for_mobile":
            List<dynamic>.from(reviewsForMobile.map((x) => x.toJson())),
        "serviceAreas": serviceAreas == null
            ? []
            : List<dynamic>.from(serviceAreas!.map((x) => x.toJson())),
        "seller_for_mobile": sellerForMobile?.toJson(),
      };
}

class ReviewsForMobile {
  ReviewsForMobile({
    this.id,
    this.serviceId,
    this.rating,
    this.message,
    this.buyerId,
    required this.buyerForMobile,
  });

  int? id;
  int? serviceId;
  int? rating;
  String? message;
  int? buyerId;
  BuyerForMobile? buyerForMobile;

  factory ReviewsForMobile.fromJson(Map<String, dynamic>? json) =>
      ReviewsForMobile(
        id: json?["id"].toString().tryToParse.toInt(),
        serviceId: json?["service_id"].toString().tryToParse.toInt(),
        rating: json?["rating"].toString().tryToParse.toInt(),
        message: json?["message"],
        buyerId: json?["buyer_id"].toString().tryToParse.toInt(),
        buyerForMobile: BuyerForMobile.fromJson(json?["buyer_for_mobile"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "service_id": serviceId,
        "rating": rating,
        "message": message,
        "buyer_id": buyerId,
        "buyer_for_mobile": buyerForMobile?.toJson(),
      };
}

class BuyerForMobile {
  BuyerForMobile({
    this.id,
    this.image,
  });

  int? id;
  String? image;

  factory BuyerForMobile.fromJson(Map<String, dynamic>? json) => BuyerForMobile(
        id: json?["id"].toString().tryToParse.toInt(),
        image: json?["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
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
  int? countryId;
  String? phone;
  String? serviceCity;
  List<dynamic>? serviceArea;
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
  List<UserServiceArea>? userServiceArea;

  factory SellerForMobile.fromJson(Map<String, dynamic> json) =>
      SellerForMobile(
        id: json["id"] as int?,
        name: json["name"],
        image: json["image"],
        countryId: json["country_id"] as int?,
        phone: json["phone"],
        serviceCity: json["service_city"],
        serviceArea: () {
          if (json["service_area"] == null || json["service_area"] == "") {
            return [];
          } else if (json["service_area"] is String) {
            String serviceAreaStr = json["service_area"].toString().trim();

            // Case: Direct number as string (e.g., "684")
            if (RegExp(r'^\d+$').hasMatch(serviceAreaStr)) {
              return [int.tryParse(serviceAreaStr) ?? 0];
            }

            // Case: JSON-encoded list as a string (e.g., '["684", "685"]')
            try {
              var decodedList = jsonDecode(serviceAreaStr);
              if (decodedList is List) {
                return decodedList
                    .map((e) => int.tryParse(e.toString()) ?? 0)
                    .toList();
              }
            } catch (e) {
              return [];
            }
          }
          // Case: Already a List (e.g., ["684", "685"])
          else if (json["service_area"] is List) {
            return (json["service_area"] as List<dynamic>)
                .map((e) => int.tryParse(e.toString()) ?? 0)
                .toList();
          }

          return [];
        }(),

        address: json["address"],
        latitude: json["latitude"] != null
            ? double.tryParse(json["latitude"].toString())
            : null,
        longitude: json["longitude"] != null
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
        workingCategories: json["working_categories"],
        userServiceArea: json["user_service_area"] != null
            ? (json["user_service_area"] as List)
                .map((e) => UserServiceArea.fromJson(e))
                .toList()
            : [], // ✅ Convert user_service_area JSON array to List<UserServiceArea>
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "country_id": countryId,
        "phone": phone,
        "service_city": serviceCity,
        "service_area":
            jsonEncode(serviceArea), // ✅ Convert List<int> back to JSON string
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

  factory Image.fromJson(Map<String, dynamic>? json) => Image(
        imageId: json?["image_id"].toString().tryToParse.toInt(),
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
