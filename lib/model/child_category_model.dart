// To parse this JSON data, do
//
//     final childCategoryModel = childCategoryModelFromJson(jsonString);

import 'dart:convert';

ChildCategoryModel childCategoryModelFromJson(String str) =>
    ChildCategoryModel.fromJson(json.decode(str));

String childCategoryModelToJson(ChildCategoryModel data) =>
    json.encode(data.toJson());

class ChildCategoryModel {
  ChildCategoryModel({
    required this.childCategory,
  });

  List<ChildCategory> childCategory;

  factory ChildCategoryModel.fromJson(Map json) => ChildCategoryModel(
        childCategory: List<ChildCategory>.from(
            json["child_category"].map((x) => ChildCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "child_category":
            List<dynamic>.from(childCategory.map((x) => x.toJson())),
      };
}

class ChildCategory {
  ChildCategory({
    this.id,
    this.categoryId,
    this.subCategoryId,
    this.name,
    this.slug,
    this.image,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  dynamic id;
  dynamic categoryId;
  dynamic subCategoryId;
  String? name;
  String? slug;
  String? image;
  dynamic status;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory ChildCategory.fromJson(Map<String, dynamic> json) => ChildCategory(
        id: json["id"],
        categoryId: json["category_id"],
        subCategoryId: json["sub_category_id"],
        name: json["name"],
        slug: json["slug"],
        image: json["image"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_id": categoryId,
        "sub_category_id": subCategoryId,
        "name": name,
        "slug": slug,
        "image": image,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
