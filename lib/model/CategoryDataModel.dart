/// categories : [{"id":1,"name":"Electronics","subcategories":[{"id":1,"name":"Auto Mobile"},{"id":3,"name":"Ac Repair"},{"id":8,"name":"Repair"},{"id":21,"name":"Food Service"},{"id":22,"name":"Book Service"},{"id":23,"name":"Car Service"},{"id":26,"name":"Design & Development"}]},{"id":2,"name":"Cleaning","subcategories":[{"id":9,"name":"Car Cleaning"},{"id":11,"name":"House Cleaning"}]},{"id":3,"name":"Home Move","subcategories":[{"id":2,"name":"House Repair"}]},{"id":4,"name":"Painting","subcategories":[{"id":18,"name":"3D Painting"},{"id":19,"name":"Digital Painting"},{"id":27,"name":"Cool Painting"}]},{"id":5,"name":"Salon & Spa","subcategories":[{"id":7,"name":"Body Message"},{"id":10,"name":"Hair Cutting"},{"id":12,"name":"Beauty Care"}]},{"id":6,"name":"Helping","subcategories":[]},{"id":7,"name":"Digital Marketing","subcategories":[{"id":13,"name":"Profile Build"}]},{"id":8,"name":"Computers & IT","subcategories":[{"id":30,"name":"IT Support"},{"id":31,"name":"Software Help"}]},{"id":9,"name":"Business","subcategories":[{"id":29,"name":"Business Advisory"}]},{"id":10,"name":"EarthMovers","subcategories":[]}]
library;

class CategoryDataModel {
  CategoryDataModel({
    List<Categories>? categories,
  }) {
    _categories = categories;
  }

  CategoryDataModel.fromJson(dynamic json) {
    if (json['categories'] != null) {
      _categories = [];
      json['categories'].forEach((v) {
        _categories?.add(Categories.fromJson(v));
      });
    } else {
      _categories = [];
    }
  }
  List<Categories>? _categories;
  CategoryDataModel copyWith({
    List<Categories>? categories,
  }) =>
      CategoryDataModel(
        categories: categories ?? _categories,
      );
  List<Categories>? get categories => _categories;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_categories != null) {
      map['categories'] = _categories?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 1
/// name : "Electronics"
/// subcategories : [{"id":1,"name":"Auto Mobile"},{"id":3,"name":"Ac Repair"},{"id":8,"name":"Repair"},{"id":21,"name":"Food Service"},{"id":22,"name":"Book Service"},{"id":23,"name":"Car Service"},{"id":26,"name":"Design & Development"}]

class Categories {
  Categories({
    int? id,
    String? name,
    String? icon,
    String? mobileIcon,
    List<Subcategories>? subcategories,
  }) {
    _id = id;
    _name = name;
    _icon = icon;
    _mobileIcon = mobileIcon;
    _subcategories = subcategories;
  }

  Categories.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'] ?? '';
    _icon = json['icon'] ?? '';
    _mobileIcon = json['mobile_icon'] ?? '';
    if (json['subcategories'] != null) {
      _subcategories = [];
      json['subcategories'].forEach((v) {
        _subcategories?.add(Subcategories.fromJson(v));
      });
    }
  }
  int? _id;
  String? _name;
  String? _icon;
  String? _mobileIcon;
  List<Subcategories>? _subcategories;
  Categories copyWith({
    int? id,
    String? name,
    String? icon,
    String? mobileIcon,
    List<Subcategories>? subcategories,
  }) =>
      Categories(
        id: id ?? _id,
        name: name ?? _name,
        icon: icon ?? _icon,
        mobileIcon: mobileIcon ?? _mobileIcon,
        subcategories: subcategories ?? _subcategories,
      );
  int? get id => _id;
  String? get name => _name;
  String? get icon => _icon;
  String? get mobileIcon => _mobileIcon;
  List<Subcategories>? get subcategories => _subcategories;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name ?? '';
    map['icon'] = _name ?? '';
    map['mobile_icon'] = _name ?? '';
    if (_subcategories != null) {
      map['subcategories'] = _subcategories?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 1
/// name : "Auto Mobile"

class Subcategories {
  Subcategories({
    int? id,
    String? name,
    String? image,
  }) {
    _id = id;
    _name = name;
    _image = image;
  }

  Subcategories.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'] ?? '';
    _image = json['image'] ?? '';
  }
  int? _id;
  String? _name;
  String? _image;
  Subcategories copyWith({
    int? id,
    String? name,
    String? image,
  }) =>
      Subcategories(
        id: id ?? _id,
        name: name ?? _name,
        image: image ?? _image,
      );
  int? get id => _id;
  String? get name => _name;
  String? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['image'] = _image;
    return map;
  }
}
