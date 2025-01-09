// To parse this JSON data, do
//
//     final jobDetailsModel = jobDetailsModelFromJson(jsonString);

import 'dart:convert';

JobDetailsModel jobDetailsModelFromJson(String str) =>
    JobDetailsModel.fromJson(json.decode(str));

String jobDetailsModelToJson(JobDetailsModel data) =>
    json.encode(data.toJson());

class JobDetailsModel {
  JobDetailsModel({
    this.jobDetails,
    required this.sameBuyerJobs,
    required this.similarJobs,
    this.isJobHired,
  });

  JobDetails? jobDetails;
  List<JobDetails> sameBuyerJobs;
  List<JobDetails> similarJobs;
  int? isJobHired;

  factory JobDetailsModel.fromJson(Map<String, dynamic> json) =>
      JobDetailsModel(
        jobDetails: JobDetails.fromJson(json["job_details"]),
        sameBuyerJobs: List<JobDetails>.from(
            json["same_buyer_jobs"].map((x) => JobDetails.fromJson(x))),
        similarJobs: List<JobDetails>.from(
            json["similar_jobs"].map((x) => JobDetails.fromJson(x))),
        isJobHired: json["is_job_hired"],
      );

  Map<String, dynamic> toJson() => {
        "job_details": jobDetails?.toJson(),
        "same_buyer_jobs":
            List<dynamic>.from(sameBuyerJobs.map((x) => x.toJson())),
        "similar_jobs": List<dynamic>.from(similarJobs.map((x) => x.toJson())),
        "is_job_hired": isJobHired,
      };
}

class JobDetails {
  JobDetails({
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
    this.jobRequest,
    this.buyer,
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
  List<JobRequest>? jobRequest;
  Buyer? buyer;

  factory JobDetails.fromJson(Map<String, dynamic> json) => JobDetails(
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
        jobRequest: json["job_request"] == null
            ? null
            : List<JobRequest>.from(
                json["job_request"].map((x) => JobRequest.fromJson(x))),
        buyer: json["buyer"] == null ? null : Buyer.fromJson(json["buyer"]),
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
        "job_request": jobRequest == null
            ? null
            : List<dynamic>.from(jobRequest!.map((x) => x.toJson())),
        "buyer": buyer == null ? null : buyer?.toJson(),
      };
}

class Buyer {
  Buyer({
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

  int? id;
  String? name;
  String? email;
  String? username;
  String? phone;
  String? image;
  String? profileBackground;
  String? serviceCity;
  String? serviceArea;
  int? userType;
  int? userStatus;
  int? termsCondition;
  String? address;
  String? state;
  dynamic about;
  String? postCode;
  int? countryId;
  int? emailVerified;
  String? emailVerifyToken;
  dynamic facebookId;
  dynamic googleId;
  String? countryCode;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic fbUrl;
  dynamic twUrl;
  dynamic goUrl;
  dynamic liUrl;
  dynamic yoUrl;
  dynamic inUrl;
  dynamic twiUrl;
  dynamic piUrl;
  dynamic drUrl;
  dynamic reUrl;

  factory Buyer.fromJson(Map<String, dynamic> json) => Buyer(
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
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
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

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "username": username,
        "phone": phone,
        "image": image,
        "profile_background": profileBackground,
        "service_city": serviceCity,
        "service_area": serviceArea,
        "user_type": userType,
        "user_status": userStatus,
        "terms_condition": termsCondition,
        "address": address,
        "state": state,
        "about": about,
        "post_code": postCode,
        "country_id": countryId,
        "email_verified": emailVerified,
        "email_verify_token": emailVerifyToken,
        "facebook_id": facebookId,
        "google_id": googleId,
        "country_code": countryCode,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
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
      };
}

class JobRequest {
  JobRequest({
    this.id,
    this.sellerId,
    this.buyerId,
    this.jobPostId,
    this.isHired,
    this.expectedSalary,
    this.coverLetter,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? sellerId;
  int? buyerId;
  int? jobPostId;
  int? isHired;
  int? expectedSalary;
  String? coverLetter;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory JobRequest.fromJson(Map<String, dynamic> json) => JobRequest(
        id: json["id"],
        sellerId: json["seller_id"],
        buyerId: json["buyer_id"],
        jobPostId: json["job_post_id"],
        isHired: json["is_hired"],
        expectedSalary: json["expected_salary"],
        coverLetter: json["cover_letter"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
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
      };
}
