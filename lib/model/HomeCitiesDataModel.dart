/// homeCities : [{"id":619,"service_area":"Charoda","service_area_image":null,"mobile_icon":null},{"id":609,"service_area":"Bhanpuri","service_area_image":null,"mobile_icon":null},{"id":685,"service_area":"Rajgamar","service_area_image":null,"mobile_icon":null},{"id":618,"service_area":"Charcha","service_area_image":null,"mobile_icon":null},{"id":628,"service_area":"Doman Hill Colliery","service_area_image":null,"mobile_icon":null},{"id":640,"service_area":"Gogaon","service_area_image":null,"mobile_icon":null},{"id":638,"service_area":"Gidam","service_area_image":null,"mobile_icon":null},{"id":667,"service_area":"Lormi","service_area_image":null,"mobile_icon":null},{"id":644,"service_area":"Jashpurnagar","service_area_image":null,"mobile_icon":null},{"id":684,"service_area":"Raipur","service_area_image":null,"mobile_icon":null}]

class HomeCitiesDataModel {
  HomeCitiesDataModel({
    List<HomeCities>? homeCities,
  }) {
    _homeCities = homeCities;
  }

  HomeCitiesDataModel.fromJson(dynamic json) {
    if (json['homeCities'] != null) {
      _homeCities = [];
      json['homeCities'].forEach((v) {
        _homeCities?.add(HomeCities.fromJson(v));
      });
    }
  }
  List<HomeCities>? _homeCities;
  HomeCitiesDataModel copyWith({
    List<HomeCities>? homeCities,
  }) =>
      HomeCitiesDataModel(
        homeCities: homeCities ?? _homeCities,
      );
  List<HomeCities>? get homeCities => _homeCities;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_homeCities != null) {
      map['homeCities'] = _homeCities?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 619
/// service_area : "Charoda"
/// service_area_image : null
/// mobile_icon : null

class HomeCities {
  HomeCities({
    num? id,
    String? serviceArea,
    dynamic serviceAreaImage,
    dynamic mobileIcon,
  }) {
    _id = id;
    _serviceArea = serviceArea;
    _serviceAreaImage = serviceAreaImage;
    _mobileIcon = mobileIcon;
  }

  HomeCities.fromJson(dynamic json) {
    _id = json['id'];
    _serviceArea = json['service_area'];
    _serviceAreaImage = json['service_area_image'];
    _mobileIcon = json['mobile_icon'];
  }
  num? _id;
  String? _serviceArea;
  dynamic _serviceAreaImage;
  dynamic _mobileIcon;
  HomeCities copyWith({
    num? id,
    String? serviceArea,
    dynamic serviceAreaImage,
    dynamic mobileIcon,
  }) =>
      HomeCities(
        id: id ?? _id,
        serviceArea: serviceArea ?? _serviceArea,
        serviceAreaImage: serviceAreaImage ?? _serviceAreaImage,
        mobileIcon: mobileIcon ?? _mobileIcon,
      );
  num? get id => _id;
  String? get serviceArea => _serviceArea;
  dynamic get serviceAreaImage => _serviceAreaImage;
  dynamic get mobileIcon => _mobileIcon;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['service_area'] = _serviceArea;
    map['service_area_image'] = _serviceAreaImage;
    map['mobile_icon'] = _mobileIcon;
    return map;
  }
}
