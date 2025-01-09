// To parse this JSON data, do
//
//     final jobRequestModel = jobRequestModelFromJson(jsonString);

import 'dart:convert';

import 'package:qixer/view/utils/others_helper.dart';

JobRequestModel jobRequestModelFromJson(String str) =>
    JobRequestModel.fromJson(json.decode(str));

String jobRequestModelToJson(JobRequestModel data) =>
    json.encode(data.toJson());

class JobRequestModel {
  JobRequestModel({
    required this.allJobRequest,
  });

  AllJobRequest allJobRequest;

  factory JobRequestModel.fromJson(Map<String, dynamic> json) =>
      JobRequestModel(
        allJobRequest: AllJobRequest.fromJson(json["all_job_request"]),
      );

  Map<String, dynamic> toJson() => {
        "all_job_request": allJobRequest.toJson(),
      };
}

class AllJobRequest {
  AllJobRequest({
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

  factory AllJobRequest.fromJson(Map<String, dynamic> json) => AllJobRequest(
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
    this.jobImage,
    this.sellerId,
    this.sellerImage,
    this.sellerName,
    this.sellerCountry,
    this.sellerCity,
    this.sellerArea,
    this.completedOrder,
    this.orderCompletionRate,
    this.buyerId,
    this.jobPostId,
    this.isHired,
    this.expectedSalary,
    this.coverLetter,
    this.createdAt,
    this.updatedAt,
    this.job,
    this.seller,
  });

  int? id;
  String? jobImage;
  int? sellerId;
  int? buyerId;
  int? jobPostId;
  int? isHired;
  String? sellerImage;
  String? sellerName;
  int? expectedSalary;
  String? coverLetter;
  String? completedOrder;
  String? orderCompletionRate;
  String? sellerCountry;
  String? sellerCity;
  String? sellerArea;
  DateTime? createdAt;
  DateTime? updatedAt;
  Job? job;
  Seller? seller;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        jobImage: json["job_image"],
        sellerId: json["seller_id"],
        sellerImage: json['seller_image'],
        sellerCountry: json['seller_country'],
        sellerCity: json['seller_city'],
        sellerArea: json['seller_area'],
        sellerName: json['seller']?['name'],
        buyerId: json["buyer_id"],
        jobPostId: json["job_post_id"],
        isHired: json["is_hired"],
        expectedSalary: json["expected_salary"],
        coverLetter: json["cover_letter"],
        orderCompletionRate: json['seller_complete_order'].toString(),
        completedOrder: json['order_completion_rate'].toString(),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        job: json["job"] != null ? Job.fromJson(json["job"]) : null,
        seller: json["seller"] == null ? null : Seller.fromJson(json["seller"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "seller_id": sellerId,
        "buyer_id": buyerId,
        "job_post_id": jobPostId,
        "is_hired": isHired,
        "expected_salary": expectedSalary,
        "cover_letter": coverLetter,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "job": job?.toJson(),
      };
}

class Seller {
  Seller({
    this.id,
    this.name,
    this.email,
    this.username,
    this.phone,
    this.image,
    this.profileBackground,
    this.serviceCity,
    this.serviceArea,
    this.userType,
    this.userStatus,
    this.termsCondition,
    this.address,
    this.state,
    this.about,
    this.postCode,
    this.countryId,
    this.emailVerified,
    this.emailVerifyToken,
    this.facebookId,
    this.googleId,
    this.countryCode,
    this.createdAt,
    this.updatedAt,
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
  });

  final int? id;
  final String? name;
  final String? email;
  final String? username;
  final String? phone;
  final String? image;
  final dynamic profileBackground;
  final String? serviceCity;
  final String? serviceArea;
  final int? userType;
  final int? userStatus;
  final int? termsCondition;
  final String? address;
  final String? state;
  final String? about;
  final String? postCode;
  final int? countryId;
  final int? emailVerified;
  final String? emailVerifyToken;
  final dynamic facebookId;
  final dynamic googleId;
  final dynamic countryCode;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic fbUrl;
  final dynamic twUrl;
  final dynamic goUrl;
  final dynamic liUrl;
  final dynamic yoUrl;
  final dynamic inUrl;
  final dynamic twiUrl;
  final dynamic piUrl;
  final dynamic drUrl;
  final dynamic reUrl;

  factory Seller.fromJson(Map<String, dynamic> json) => Seller(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        username: json["username"],
        phone: json["phone"],
        image: json["image"],
        profileBackground: json["profile_background"],
        serviceCity: json["service_city"],
        serviceArea: json["service_area"],
        userType: json["user_type"],
        userStatus: json["user_status"],
        termsCondition: json["terms_condition"],
        address: json["address"],
        state: json["state"],
        about: json["about"],
        postCode: json["post_code"],
        countryId: json["country_id"],
        emailVerified: json["email_verified"],
        emailVerifyToken: json["email_verify_token"],
        facebookId: json["facebook_id"],
        googleId: json["google_id"],
        countryCode: json["country_code"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
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
      );
}

class Job {
  Job({
    this.id,
    this.categoryId,
    this.subcategoryId,
    this.buyerId,
    this.countryId,
    this.cityId,
    this.title,
    this.slug,
    this.description,
    this.image,
    this.status,
    this.isJobOn,
    this.isJobOnline,
    this.price,
    this.view,
    this.deadLine,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? categoryId;
  int? subcategoryId;
  int? buyerId;
  int? countryId;
  int? cityId;
  String? title;
  String? slug;
  String? description;
  String? image;
  int? status;
  int? isJobOn;
  int? isJobOnline;
  int? price;
  int? view;
  DateTime? deadLine;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Job.fromJson(Map<String, dynamic> json) => Job(
        id: json["id"],
        categoryId: json["category_id"],
        subcategoryId: json["subcategory_id"],
        buyerId: json["buyer_id"],
        countryId: json["country_id"],
        cityId: json["city_id"],
        title: json["title"],
        slug: json["slug"],
        description: json["description"],
        image: json["image"],
        status: json["status"],
        isJobOn: json["is_job_on"],
        isJobOnline: json["is_job_online"],
        price: json["price"],
        view: json["view"],
        deadLine: DateTime.parse(json["dead_line"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_id": categoryId,
        "subcategory_id": subcategoryId,
        "buyer_id": buyerId,
        "country_id": countryId,
        "city_id": cityId,
        "title": title,
        "slug": slug,
        "description": description,
        "image": image,
        "status": status,
        "is_job_on": isJobOn,
        "is_job_online": isJobOnline,
        "price": price,
        "view": view,
        "dead_line": deadLine?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
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
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
      };
}
