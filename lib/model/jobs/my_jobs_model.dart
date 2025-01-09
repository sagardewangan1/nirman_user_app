// To parse this JSON data, do
//
//     final myJobsModel = myJobsModelFromJson(jsonString);

import 'dart:convert';

import 'package:qixer/helper/extension/string_extension.dart';

MyJobsModel myJobsModelFromJson(String str) =>
    MyJobsModel.fromJson(json.decode(str));

String myJobsModelToJson(MyJobsModel data) => json.encode(data.toJson());

class MyJobsModel {
  MyJobsModel({
    required this.jobLists,
    required this.jobImage,
  });

  JobLists jobLists;
  List<JobImage?> jobImage;

  factory MyJobsModel.fromJson(Map<String, dynamic>? json) => MyJobsModel(
        jobLists: JobLists.fromJson(json?["job_lists"]),
        jobImage: List<JobImage?>.from(json?["job_image"].map((x) {
          if (x is List) {
            return null;
          } else {
            return x == null ? null : JobImage.fromJson(x);
          }
        })),
      );

  Map<String, dynamic> toJson() => {
        "job_lists": jobLists.toJson(),
        "job_image": List<dynamic>.from(jobImage.map((x) => x?.toJson())),
      };
}

class JobImage {
  JobImage({
    this.imageId,
    this.path,
    this.imgUrl,
    this.imgAlt,
  });

  int? imageId;
  String? path;
  String? imgUrl;
  dynamic imgAlt;

  factory JobImage.fromJson(Map<String, dynamic> json) => JobImage(
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

class JobLists {
  JobLists({
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
  String? nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  factory JobLists.fromJson(Map<String, dynamic> json) => JobLists(
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

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
