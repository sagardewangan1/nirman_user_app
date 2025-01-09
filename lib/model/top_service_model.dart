// To parse this JSON data, do
//
//     final topServiceModel = topServiceModelFromJson(jsonString);

import 'dart:convert';

import 'package:qixer/view/utils/others_helper.dart';

import 'recent_service_model.dart';

TopServiceModel topServiceModelFromJson(String str) =>
    TopServiceModel.fromJson(json.decode(str));

String topServiceModelToJson(TopServiceModel data) =>
    json.encode(data.toJson());

class TopServiceModel {
  TopServiceModel({
    required this.topServices,
    required this.serviceImage,
    required this.reviewerImage,
  });

  List<TopService> topServices;
  List<Image?> serviceImage;
  List<dynamic> reviewerImage;

  factory TopServiceModel.fromJson(Map<String, dynamic> json) =>
      TopServiceModel(
        topServices: List<TopService>.from(
            json["top_services"].map((x) => TopService.fromJson(x))),
        serviceImage: List<Image?>.from(json["service_image"].map((x) {
          if (x is List) {
            return null;
          } else {
            return Image.fromJson(x);
          }
        })),
        reviewerImage: List<dynamic>.from(json["reviewer_image"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "top_services": List<dynamic>.from(topServices.map((x) => x.toJson())),
        "service_image":
            List<dynamic>.from(serviceImage.map((x) => x?.toJson())),
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

class TopService {
  TopService({
    this.id,
    this.title,
    this.image,
    this.price,
    this.sellerId,
    required this.reviewsForMobile,
    required this.sellerForMobile,
  });

  int? id;
  String? title;
  String? image;
  var price;
  int? sellerId;
  List<ReviewsForMobile> reviewsForMobile;
  SellerForMobile sellerForMobile;

  factory TopService.fromJson(Map<String, dynamic> json) => TopService(
        id: json["id"].toString().tryToParse.toInt(),
        title: json["title"],
        image: json["image"],
        price: json["price"],
        sellerId: json["seller_id"].toString().tryToParse.toInt(),
        reviewsForMobile: List<ReviewsForMobile>.from(json["reviews_for_mobile"]
            .map((x) => ReviewsForMobile.fromJson(x))),
        sellerForMobile: SellerForMobile.fromJson(json["seller_for_mobile"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image": image,
        "price": price,
        "seller_id": sellerId,
        "reviews_for_mobile":
            List<dynamic>.from(reviewsForMobile.map((x) => x.toJson())),
        "seller_for_mobile": sellerForMobile.toJson(),
      };
}
