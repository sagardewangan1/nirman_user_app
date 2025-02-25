/// data : [{"id":110,"service_area":"Raipur"},{"id":111,"service_area":"Shankar Nagar"},{"id":112,"service_area":"Gudhiyari"}]

class AllCitiesDataModel {
  AllCitiesDataModel({
    List<Data>? data,
  }) {
    _data = data;
  }

  AllCitiesDataModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  List<Data>? _data;
  AllCitiesDataModel copyWith({
    List<Data>? data,
  }) =>
      AllCitiesDataModel(
        data: data ?? _data,
      );
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 110
/// service_area : "Raipur"

class Data {
  Data({
    int? id,
    String? serviceArea,
    String? image,
  }) {
    _id = id;
    _serviceArea = serviceArea;
    _image = image;
  }

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _serviceArea = json['service_area'];
    _image = json['image'];
  }
  int? _id;
  String? _serviceArea;
  String? _image;
  Data copyWith({
    int? id,
    String? serviceArea,
    String? image,
  }) =>
      Data(
        id: id ?? _id,
        serviceArea: serviceArea ?? _serviceArea,
        image: image ?? _image,
      );
  int? get id => _id;
  String? get serviceArea => _serviceArea;
  String? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['service_area'] = _serviceArea;
    map['image'] = _image;
    return map;
  }
}
