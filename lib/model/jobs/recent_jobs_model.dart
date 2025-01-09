// To parse this JSON data, do
//
//     final recentJobsModel = recentJobsModelFromJson(jsonString);

import 'dart:convert';

RecentJobsModel? recentJobsModelFromJson(String str) =>
    RecentJobsModel.fromJson(json.decode(str));

String recentJobsModelToJson(RecentJobsModel? data) =>
    json.encode(data!.toJson());

class RecentJobsModel {
  RecentJobsModel({
    this.recent10Jobs,
    this.jobsImage,
  });

  List<Recent10Job?>? recent10Jobs;
  List<JobsImage?>? jobsImage;

  factory RecentJobsModel.fromJson(Map<String, dynamic> json) =>
      RecentJobsModel(
        recent10Jobs: json["recent_10_jobs"] == null
            ? []
            : List<Recent10Job?>.from(
                json["recent_10_jobs"]!.map((x) => Recent10Job.fromJson(x))),
        jobsImage: json["jobs_image"] == null
            ? []
            : List<JobsImage?>.from(
                json["jobs_image"]!.map((x) => JobsImage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "recent_10_jobs": recent10Jobs == null
            ? []
            : List<dynamic>.from(recent10Jobs!.map((x) => x!.toJson())),
        "jobs_image": jobsImage == null
            ? []
            : List<dynamic>.from(jobsImage!.map((x) => x!.toJson())),
      };
}

class JobsImage {
  JobsImage({
    this.imageId,
    this.path,
    this.imgUrl,
    this.imgAlt,
  });

  int? imageId;
  String? path;
  String? imgUrl;
  dynamic imgAlt;

  factory JobsImage.fromJson(Map<String, dynamic> json) => JobsImage(
        imageId: json["image_id"],
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

class Recent10Job {
  Recent10Job({
    this.id,
    this.categoryId,
    this.subcategoryId,
    this.childCategoryId,
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
  dynamic childCategoryId;
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

  factory Recent10Job.fromJson(Map<String, dynamic> json) => Recent10Job(
        id: json["id"],
        categoryId: json["category_id"],
        subcategoryId: json["subcategory_id"],
        childCategoryId: json["child_category_id"],
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
        "child_category_id": childCategoryId,
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
