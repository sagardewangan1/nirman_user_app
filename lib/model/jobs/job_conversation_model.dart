// To parse this JSON data, do
//
//     final jobConversationModel = jobConversationModelFromJson(jsonString);

import 'dart:convert';

JobConversationModel jobConversationModelFromJson(String str) =>
    JobConversationModel.fromJson(json.decode(str));

String jobConversationModelToJson(JobConversationModel data) =>
    json.encode(data.toJson());

class JobConversationModel {
  JobConversationModel({
    this.requestDetails,
    required this.allMessages,
    this.q,
  });

  RequestDetails? requestDetails;
  List<AllMessage> allMessages;
  String? q;

  factory JobConversationModel.fromJson(Map<String, dynamic> json) =>
      JobConversationModel(
        requestDetails: RequestDetails.fromJson(json["request_details"]),
        allMessages: List<AllMessage>.from(
            json["all_messages"].map((x) => AllMessage.fromJson(x))),
        q: json["q"],
      );

  Map<String, dynamic> toJson() => {
        "request_details": requestDetails?.toJson(),
        "all_messages": List<dynamic>.from(allMessages.map((x) => x.toJson())),
        "q": q,
      };
}

class AllMessage {
  AllMessage({
    this.id,
    this.message,
    this.notify,
    this.attachment,
    this.type,
    this.jobRequestId,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? message;
  String? notify;
  String? attachment;
  String? type;
  int? jobRequestId;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory AllMessage.fromJson(Map<String, dynamic> json) => AllMessage(
        id: json["id"],
        message: json["message"],
        notify: json["notify"],
        attachment: json["attachment"] ?? null,
        type: json["type"],
        jobRequestId: json["job_request_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "message": message,
        "notify": notify,
        "attachment": attachment ?? null,
        "type": type,
        "job_request_id": jobRequestId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class RequestDetails {
  RequestDetails({
    this.id,
    this.sellerId,
    this.buyerId,
    this.jobPostId,
    this.isHired,
    this.expectedSalary,
    this.coverLetter,
    this.createdAt,
    this.updatedAt,
    this.job,
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
  Job? job;

  factory RequestDetails.fromJson(Map<String, dynamic> json) => RequestDetails(
        id: json["id"],
        sellerId: json["seller_id"],
        buyerId: json["buyer_id"],
        jobPostId: json["job_post_id"],
        isHired: json["is_hired"],
        expectedSalary: json["expected_salary"],
        coverLetter: json["cover_letter"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        job: Job.fromJson(json["job"]),
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
