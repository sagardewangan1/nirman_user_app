// To parse this JSON data, do
//
//     final serviceDetailsModel = serviceDetailsModelFromJson(jsonString);

import 'dart:convert';

import 'package:qixer/model/MyServiceListDataModel.dart';

ServiceDetailsModel serviceDetailsModelFromJson(String str) =>
    ServiceDetailsModel.fromJson(json.decode(str));

String serviceDetailsModelToJson(ServiceDetailsModel data) =>
    json.encode(data.toJson());

class ServiceDetailsModel {
  ServiceDetailsModel(
      {required this.serviceDetails,
      required this.serviceImage,
      this.serviceSellerName,
      required this.serviceSellerImage,
      this.sellerCompleteOrder,
      this.sellerRating,
      this.orderCompletionRate,
      this.sellerFrom,
      required this.sellerSince,
      required this.serviceIncludes,
      required this.serviceBenifits,
      required this.serviceReviews,
      required this.reviewerImage,
      this.videoUrl});

  ServiceDetails serviceDetails;
  Image? serviceImage;
  String? serviceSellerName;
  Image? serviceSellerImage;
  int? sellerCompleteOrder;
  int? sellerRating;
  int? orderCompletionRate;
  String? sellerFrom;
  SellerSince sellerSince;
  List<ServiceInclude> serviceIncludes;
  List<ServiceBenifit> serviceBenifits;
  List<ServiceReview> serviceReviews;
  List<dynamic> reviewerImage;
  String? videoUrl;

  factory ServiceDetailsModel.fromJson(Map<String?, dynamic>? json) =>
      ServiceDetailsModel(
        serviceDetails: ServiceDetails.fromJson(json?["service_details"]),
        serviceImage: json?["service_image"] is List
            ? null
            : Image.fromJson(json?["service_image"]),
        serviceSellerName: json?["service_seller_name"],
        serviceSellerImage: Image.fromJson(json?["service_seller_image"]),
        sellerCompleteOrder: json?["seller_complete_order"],
        sellerRating: json?["seller_rating"],
        orderCompletionRate: json?["order_completion_rate"],
        sellerFrom: json?["seller_from"],
        sellerSince: SellerSince.fromJson(json?["seller_since"]),
        serviceIncludes: List<ServiceInclude>.from(
            json?["service_includes"].map((x) => ServiceInclude.fromJson(x))),
        serviceBenifits: List<ServiceBenifit>.from(
            json?["service_benifits"].map((x) => ServiceBenifit.fromJson(x))),
        serviceReviews: List<ServiceReview>.from(
            json?["service_reviews"].map((x) => ServiceReview.fromJson(x))),
        reviewerImage:
            List<dynamic>.from(json?["reviewer_image"].map((x) => x)),
        videoUrl: json?["video_url"] is bool ? null : json?["video_url"],
      );

  Map<String, dynamic> toJson() => {
        "service_details": serviceDetails.toJson(),
        "service_image": serviceImage?.toJson(),
        "service_seller_name": serviceSellerName,
        "service_seller_image": serviceSellerImage?.toJson(),
        "seller_complete_order": sellerCompleteOrder,
        "seller_rating": sellerRating,
        "order_completion_rate": orderCompletionRate,
        "seller_from": sellerFrom,
        "seller_since": sellerSince.toJson(),
        "service_includes":
            List<dynamic>.from(serviceIncludes.map((x) => x.toJson())),
        "service_benifits":
            List<dynamic>.from(serviceBenifits.map((x) => x.toJson())),
        "service_reviews":
            List<dynamic>.from(serviceReviews.map((x) => x.toJson())),
        "reviewer_image": List<dynamic>.from(reviewerImage.map((x) => x)),
        "video_url": videoUrl,
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

class SellerSince {
  SellerSince({
    required this.createdAt,
  });

  DateTime createdAt;

  factory SellerSince.fromJson(Map<String, dynamic> json) => SellerSince(
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "created_at": createdAt.toIso8601String(),
      };
}

class ServiceBenifit {
  ServiceBenifit({
    this.id,
    this.serviceId,
    this.benifits,
  });

  int? id;
  int? serviceId;
  String? benifits;

  factory ServiceBenifit.fromJson(Map<String, dynamic> json) => ServiceBenifit(
        id: json["id"],
        serviceId: json["service_id"],
        benifits: json["benifits"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "service_id": serviceId,
        "benifits": benifits,
      };
}

class ServiceDetails {
  ServiceDetails({
    this.id,
    this.categoryId,
    this.subcategoryId,
    this.sellerId,
    this.serviceCityId,
    this.title,
    this.slug,
    this.description,
    this.image,
    this.video,
    this.status,
    this.experience,
    this.isServiceOn,
    this.price,
    this.tax,
    this.view,
    this.soldCount,
    this.featured,
    required this.sellerForMobile,
    required this.seller,
    required this.category,
    required this.subcategory,
    required this.reviewsForMobile,
    required this.serviceFaq,
  });

  int? id;
  int? categoryId;
  dynamic subcategoryId;
  int? sellerId;
  int? serviceCityId;
  String? title;
  String? slug;
  String? description;
  String? image;
  String? video;
  int? status;
  String? experience;
  int? isServiceOn;
  var price;
  var tax;
  int? view;
  int? soldCount;
  int? featured;
  SellerForMobile sellerForMobile;
  Seller seller;
  Category category;
  Subcategory subcategory;
  List<ServiceReview> reviewsForMobile;
  List<ServiceFaq> serviceFaq;

  factory ServiceDetails.fromJson(Map<String, dynamic> json) => ServiceDetails(
        id: json["id"],
        categoryId: json["category_id"],
        subcategoryId: json["subcategory_id"],
        sellerId: json["seller_id"],
        serviceCityId: json["service_city_id"],
        title: json["title"],
        slug: json["slug"],
        description: json["description"],
        image: json["image"],
        video: json["video"],
        status: json["status"],
        experience: json["experience"],
        isServiceOn: json["is_service_on"],
        price: json["price"],
        tax: json["tax"],
        view: json["view"],
        soldCount: json["sold_count"],
        featured: json["featured"],
        sellerForMobile: SellerForMobile.fromJson(json["seller_for_mobile"]),
        seller: Seller.fromJson(json["seller"]),
        category: Category.fromJson(json["category"]),
        subcategory: Subcategory.fromJson(json["subcategory"]),
        reviewsForMobile: List<ServiceReview>.from(
            json["reviews_for_mobile"].map((x) => ServiceReview.fromJson(x))),
        serviceFaq: List<ServiceFaq>.from(
            json["service_faq"].map((x) => ServiceFaq.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_id": categoryId,
        "subcategory_id": subcategoryId,
        "seller_id": sellerId,
        "service_city_id": serviceCityId,
        "title": title,
        "slug": slug,
        "description": description,
        "image": image,
        "video": video,
        "status": status,
        "experience": experience,
        "is_service_on": isServiceOn,
        "price": price,
        "tax": tax,
        "view": view,
        "sold_count": soldCount,
        "featured": featured,
        "seller_for_mobile": sellerForMobile.toJson(),
        "seller": seller.toJson(),
        "category": category.toJson(),
        "subcategory": subcategory.toJson(),
        "reviews_for_mobile":
            List<dynamic>.from(reviewsForMobile.map((x) => x.toJson())),
      };
}

class ServiceReview {
  ServiceReview({
    this.id,
    this.serviceId,
    this.rating,
    this.message,
    this.buyerName,
    this.buyerId,
    required this.buyerForMobile,
  });

  int? id;
  int? serviceId;
  int? rating;
  String? message;
  String? buyerName;
  int? buyerId;
  BuyerForMobile? buyerForMobile;

  factory ServiceReview.fromJson(Map<String, dynamic>? json) => ServiceReview(
        id: json?["id"],
        serviceId: json?["service_id"],
        rating: json?["rating"],
        message: json?["message"],
        buyerName: json?["buyer_name"],
        buyerId: json?["buyer_id"],
        buyerForMobile: BuyerForMobile.fromJson(json?["buyer_for_mobile"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "service_id": serviceId,
        "rating": rating,
        "message": message,
        "buyerName": buyerName,
        "buyer_id": buyerId,
        "buyer_for_mobile": buyerForMobile?.toJson(),
      };
}

class ServiceFaq {
  ServiceFaq({
    this.id,
    this.serviceId,
    this.sellerId,
    this.title,
    this.description,
  });

  int? id;
  int? serviceId;
  int? sellerId;
  String? title;
  String? description;

  factory ServiceFaq.fromJson(Map<String, dynamic> json) => ServiceFaq(
        id: json["id"],
        serviceId: json["service_id"],
        sellerId: json["seller_id"],
        title: json["title"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "service_id": serviceId,
        "seller_id": sellerId,
        "title": title,
        "description": description,
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
        id: json?["id"],
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
    required this.country,
  });

  int? id;
  String? name;
  String? image;
  int? countryId;
  Country? country;

  factory SellerForMobile.fromJson(Map<String, dynamic> json) =>
      SellerForMobile(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        countryId: json["country_id"],
        country:
            json["country"] == null ? null : Country.fromJson(json["country"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "country_id": countryId,
        "country": country?.toJson(),
      };
}

class Country {
  Country({
    this.id,
    this.country,
    this.status,
  });

  int? id;
  String? country;
  int? status;

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        id: json["id"],
        country: json["country"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "country": country,
        "status": status,
      };
}

class ServiceInclude {
  ServiceInclude({
    this.id,
    this.serviceId,
    this.includeServiceTitle,
  });

  int? id;
  int? serviceId;
  String? includeServiceTitle;

  factory ServiceInclude.fromJson(Map<String, dynamic> json) => ServiceInclude(
        id: json["id"],
        serviceId: json["service_id"],
        includeServiceTitle: json["include_service_title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "service_id": serviceId,
        "include_service_title": includeServiceTitle,
      };
}

class Seller {
  Seller({
    this.id,
    this.name,
    this.email,
    this.username,
    this.phone,
    this.businessName,
    this.businessGstNumber,
    this.businessPhoneNumber,
    this.businessEmail,
    this.businessFullAddress,
    this.businessDescription,
    this.workingCategories,
    this.otpCode,
    this.otpVerified,
    this.image,
    this.profileBackground,
    this.serviceCity,
    this.serviceArea,
    this.userType,
    this.sellerType,
    this.isNew,
    this.userStatus,
    this.termsCondition,
    this.address,
    this.state,
    this.about,
    this.taxNumber,
    this.businessRegistration,
    this.postCode,
    this.countryId,
    this.emailVerified,
    this.emailVerifyToken,
    this.facebookId,
    this.appleId,
    this.googleId,
    this.countryCode,
    this.createdAt,
    this.updatedAt,
    this.passwordChangedAt,
    this.fbUrl,
    this.twUrl,
    this.goUrl,
    this.liUrl,
    this.yoUrl,
    this.inUrl,
    this.twiUrl,
    this.piUrl,
    this.drUrl,
    this.reUrl,
    this.lastSeen,
    this.otpExpireAt,
    this.zoneId,
    this.latitude,
    this.longitude,
    this.sellerAddress,
  });

  int? id;
  String? name;
  String? email;
  String? username;
  String? phone;
  String? businessName;
  String? businessGstNumber;
  String? businessPhoneNumber;
  String? businessEmail;
  String? businessFullAddress;
  String? businessDescription;
  List<String>? workingCategories;
  String? otpCode;
  int? otpVerified;
  String? image;
  String? profileBackground;
  String? serviceCity;
  String? serviceArea;
  int? userType;
  int? sellerType;
  int? isNew;
  int? userStatus;
  int? termsCondition;
  String? address;
  String? state;
  String? about;
  String? taxNumber;
  String? businessRegistration;
  String? postCode;
  int? countryId;
  int? emailVerified;
  String? emailVerifyToken;
  String? facebookId;
  String? appleId;
  String? googleId;
  String? countryCode;
  String? createdAt;
  String? updatedAt;
  String? passwordChangedAt;
  String? fbUrl;
  String? twUrl;
  String? goUrl;
  String? liUrl;
  String? yoUrl;
  String? inUrl;
  String? twiUrl;
  String? piUrl;
  String? drUrl;
  String? reUrl;
  String? lastSeen;
  String? otpExpireAt;
  String? zoneId;
  double? latitude;
  double? longitude;
  String? sellerAddress;

  factory Seller.fromJson(Map<String, dynamic> json) => Seller(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        username: json["username"],
        phone: json["phone"],
        businessName: json["businessName"],
        businessGstNumber: json["businessGstNumber"],
        businessPhoneNumber: json["businessPhoneNumber"],
        businessEmail: json["businessEmail"],
        businessFullAddress: json["businessFullAddress"],
        businessDescription: json["businessDescription"],
        workingCategories: json["working_categories"] != null
            ? List<String>.from(jsonDecode(json["working_categories"]))
            : [],
        otpCode: json["otp_code"],
        otpVerified: json["otp_verified"],
        image: json["image"],
        profileBackground: json["profile_background"],
        serviceCity: json["service_city"],
        serviceArea: json["service_area"],
        userType: json["user_type"],
        sellerType: json["seller_type"],
        isNew: json["isNew"],
        userStatus: json["user_status"],
        termsCondition: json["terms_condition"],
        address: json["address"],
        state: json["state"],
        about: json["about"],
        taxNumber: json["tax_number"],
        businessRegistration: json["business_registration"],
        postCode: json["post_code"],
        countryId: json["country_id"],
        emailVerified: json["email_verified"],
        emailVerifyToken: json["email_verify_token"],
        facebookId: json["facebook_id"],
        appleId: json["apple_id"],
        googleId: json["google_id"],
        countryCode: json["country_code"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        passwordChangedAt: json["password_changed_at"],
        fbUrl: json["fb_url"],
        twUrl: json["tw_url"],
        goUrl: json["go_url"],
        liUrl: json["li_url"],
        yoUrl: json["yo_url"],
        inUrl: json["in_url"],
        twiUrl: json["twi_url"],
        piUrl: json["pi_url"],
        drUrl: json["dr_url"],
        reUrl: json["re_url"],
        lastSeen: json["last_seen"],
        otpExpireAt: json["otp_expire_at"],
        zoneId: json["zone_id"],
        latitude: json["latitude"] != null
            ? double.tryParse(json["latitude"].toString())
            : null,
        longitude: json["longitude"] != null
            ? double.tryParse(json["longitude"].toString())
            : null,
        sellerAddress: json["seller_address"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "username": username,
        "phone": phone,
        "businessName": businessName,
        "businessGstNumber": businessGstNumber,
        "businessPhoneNumber": businessPhoneNumber,
        "businessEmail": businessEmail,
        "businessFullAddress": businessFullAddress,
        "businessDescription": businessDescription,
        "working_categories":
            workingCategories != null ? jsonEncode(workingCategories) : null,
        "otp_code": otpCode,
        "otp_verified": otpVerified,
        "image": image,
        "profile_background": profileBackground,
        "service_city": serviceCity,
        "service_area": serviceArea,
        "user_type": userType,
        "seller_type": sellerType,
        "isNew": isNew,
        "user_status": userStatus,
        "terms_condition": termsCondition,
        "address": address,
        "state": state,
        "about": about,
        "tax_number": taxNumber,
        "business_registration": businessRegistration,
        "post_code": postCode,
        "country_id": countryId,
        "email_verified": emailVerified,
        "email_verify_token": emailVerifyToken,
        "facebook_id": facebookId,
        "apple_id": appleId,
        "google_id": googleId,
        "country_code": countryCode,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "password_changed_at": passwordChangedAt,
        "fb_url": fbUrl,
        "tw_url": twUrl,
        "go_url": goUrl,
        "li_url": liUrl,
        "yo_url": yoUrl,
        "in_url": inUrl,
        "twi_url": twiUrl,
        "pi_url": piUrl,
        "dr_url": drUrl,
        "re_url": reUrl,
        "last_seen": lastSeen,
        "otp_expire_at": otpExpireAt,
        "zone_id": zoneId,
        "latitude": latitude,
        "longitude": longitude,
        "seller_address": sellerAddress,
      };
}
