/// user : {"id":1935,"name":"New User","email":null,"username":"user_1735","phone":"1234567890","otp_code":"838181","otp_verified":0,"image":null,"profile_background":null,"service_city":null,"service_area":null,"user_type":1,"seller_type":0,"user_status":1,"terms_condition":1,"address":null,"state":null,"about":null,"tax_dynamicber":null,"business_registration":null,"post_code":null,"country_id":null,"email_verified":null,"email_verify_token":null,"facebook_id":null,"apple_id":null,"google_id":null,"country_code":null,"created_at":"2025-01-17T12:08:02.000000Z","updated_at":"2025-01-17T12:58:41.000000Z","password_changed_at":null,"fb_url":null,"tw_url":null,"go_url":null,"li_url":null,"yo_url":null,"in_url":null,"twi_url":null,"pi_url":null,"dr_url":null,"re_url":null,"last_seen":null,"otp_expire_at":"2025-01-17 18:33:41","zone_id":null,"latitude":null,"longitude":null,"seller_address":null}
/// token : "20|KEdtblwzCZImrKDaPHEuSWKxojgrRsGMTW4h1t7Bb7d46a61"
library;

class OtpResponseModel {
  OtpResponseModel({
    bool? status,
    User? user,
    String? token,
  }) {
    _status = status;
    _user = user;
    _token = token;
  }

  OtpResponseModel.fromJson(dynamic json) {
    _status = json['status'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    _token = json['token'];
  }
  bool? _status;
  User? _user;
  String? _token;
  OtpResponseModel copyWith({
    bool? status,
    User? user,
    String? token,
  }) =>
      OtpResponseModel(
        status: status ?? _status,
        user: user ?? _user,
        token: token ?? _token,
      );
  bool? get status => _status;
  User? get user => _user;
  String? get token => _token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    map['token'] = _token;
    return map;
  }
}

/// id : 1935
/// name : "New User"
/// email : null
/// username : "user_1735"
/// phone : "1234567890"
/// otp_code : "838181"
/// otp_verified : 0
/// image : null
/// profile_background : null
/// service_city : null
/// service_area : null
/// user_type : 1
/// seller_type : 0
/// user_status : 1
/// terms_condition : 1
/// address : null
/// state : null
/// about : null
/// tax_dynamicber : null
/// business_registration : null
/// post_code : null
/// country_id : null
/// email_verified : null
/// email_verify_token : null
/// facebook_id : null
/// apple_id : null
/// google_id : null
/// country_code : null
/// created_at : "2025-01-17T12:08:02.000000Z"
/// updated_at : "2025-01-17T12:58:41.000000Z"
/// password_changed_at : null
/// fb_url : null
/// tw_url : null
/// go_url : null
/// li_url : null
/// yo_url : null
/// in_url : null
/// twi_url : null
/// pi_url : null
/// dr_url : null
/// re_url : null
/// last_seen : null
/// otp_expire_at : "2025-01-17 18:33:41"
/// zone_id : null
/// latitude : null
/// longitude : null
/// seller_address : null

class User {
  User({
    dynamic id,
    String? name,
    dynamic email,
    String? username,
    String? phone,
    String? otpCode,
    dynamic otpVerified,
    dynamic image,
    dynamic profileBackground,
    dynamic serviceCity,
    dynamic serviceArea,
    dynamic userType,
    dynamic sellerType,
    dynamic userStatus,
    dynamic termsCondition,
    dynamic address,
    dynamic state,
    dynamic about,
    dynamic taxdynamicber,
    dynamic businessRegistration,
    dynamic postCode,
    dynamic countryId,
    dynamic emailVerified,
    dynamic emailVerifyToken,
    dynamic facebookId,
    dynamic appleId,
    dynamic googleId,
    dynamic countryCode,
    String? createdAt,
    String? updatedAt,
    dynamic passwordChangedAt,
    dynamic fbUrl,
    dynamic twUrl,
    dynamic goUrl,
    dynamic liUrl,
    dynamic yoUrl,
    dynamic inUrl,
    dynamic twiUrl,
    dynamic piUrl,
    dynamic drUrl,
    dynamic reUrl,
    dynamic lastSeen,
    String? otpExpireAt,
    dynamic zoneId,
    dynamic latitude,
    dynamic longitude,
    dynamic sellerAddress,
    int? isNew,
  }) {
    _id = id;
    _name = name;
    _email = email;
    _username = username;
    _phone = phone;
    _otpCode = otpCode;
    _otpVerified = otpVerified;
    _image = image;
    _profileBackground = profileBackground;
    _serviceCity = serviceCity;
    _serviceArea = serviceArea;
    _userType = userType;
    _sellerType = sellerType;
    _userStatus = userStatus;
    _termsCondition = termsCondition;
    _address = address;
    _state = state;
    _about = about;
    _taxdynamicber = taxdynamicber;
    _businessRegistration = businessRegistration;
    _postCode = postCode;
    _countryId = countryId;
    _emailVerified = emailVerified;
    _emailVerifyToken = emailVerifyToken;
    _facebookId = facebookId;
    _appleId = appleId;
    _googleId = googleId;
    _countryCode = countryCode;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _passwordChangedAt = passwordChangedAt;
    _fbUrl = fbUrl;
    _twUrl = twUrl;
    _goUrl = goUrl;
    _liUrl = liUrl;
    _yoUrl = yoUrl;
    _inUrl = inUrl;
    _twiUrl = twiUrl;
    _piUrl = piUrl;
    _drUrl = drUrl;
    _reUrl = reUrl;
    _lastSeen = lastSeen;
    _otpExpireAt = otpExpireAt;
    _zoneId = zoneId;
    _latitude = latitude;
    _longitude = longitude;
    _sellerAddress = sellerAddress;
    _isNew = isNew;
  }

  User.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _email = json['email'];
    _username = json['username'];
    _phone = json['phone'];
    _otpCode = json['otp_code'];
    _otpVerified = json['otp_verified'];
    _image = json['image'];
    _profileBackground = json['profile_background'];
    _serviceCity = json['service_city'];
    _serviceArea = json['service_area'];
    _userType = json['user_type'];
    _sellerType = json['seller_type'];
    _userStatus = json['user_status'];
    _termsCondition = json['terms_condition'];
    _address = json['address'];
    _state = json['state'];
    _about = json['about'];
    _taxdynamicber = json['tax_dynamicber'];
    _businessRegistration = json['business_registration'];
    _postCode = json['post_code'];
    _countryId = json['country_id'];
    _emailVerified = json['email_verified'];
    _emailVerifyToken = json['email_verify_token'];
    _facebookId = json['facebook_id'];
    _appleId = json['apple_id'];
    _googleId = json['google_id'];
    _countryCode = json['country_code'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _passwordChangedAt = json['password_changed_at'];
    _fbUrl = json['fb_url'];
    _twUrl = json['tw_url'];
    _goUrl = json['go_url'];
    _liUrl = json['li_url'];
    _yoUrl = json['yo_url'];
    _inUrl = json['in_url'];
    _twiUrl = json['twi_url'];
    _piUrl = json['pi_url'];
    _drUrl = json['dr_url'];
    _reUrl = json['re_url'];
    _lastSeen = json['last_seen'];
    _otpExpireAt = json['otp_expire_at'];
    _zoneId = json['zone_id'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _sellerAddress = json['seller_address'];
    _isNew = json['isNew'];
  }
  dynamic _id;
  String? _name;
  dynamic _email;
  String? _username;
  String? _phone;
  String? _otpCode;
  dynamic _otpVerified;
  dynamic _image;
  dynamic _profileBackground;
  dynamic _serviceCity;
  dynamic _serviceArea;
  dynamic _userType;
  dynamic _sellerType;
  dynamic _userStatus;
  dynamic _termsCondition;
  dynamic _address;
  dynamic _state;
  dynamic _about;
  dynamic _taxdynamicber;
  dynamic _businessRegistration;
  dynamic _postCode;
  dynamic _countryId;
  dynamic _emailVerified;
  dynamic _emailVerifyToken;
  dynamic _facebookId;
  dynamic _appleId;
  dynamic _googleId;
  dynamic _countryCode;
  String? _createdAt;
  String? _updatedAt;
  dynamic _passwordChangedAt;
  dynamic _fbUrl;
  dynamic _twUrl;
  dynamic _goUrl;
  dynamic _liUrl;
  dynamic _yoUrl;
  dynamic _inUrl;
  dynamic _twiUrl;
  dynamic _piUrl;
  dynamic _drUrl;
  dynamic _reUrl;
  dynamic _lastSeen;
  String? _otpExpireAt;
  dynamic _zoneId;
  dynamic _latitude;
  dynamic _longitude;
  dynamic _sellerAddress;
  int? _isNew;
  User copyWith({
    dynamic id,
    String? name,
    dynamic email,
    String? username,
    String? phone,
    String? otpCode,
    dynamic otpVerified,
    dynamic image,
    dynamic profileBackground,
    dynamic serviceCity,
    dynamic serviceArea,
    dynamic userType,
    dynamic sellerType,
    dynamic userStatus,
    dynamic termsCondition,
    dynamic address,
    dynamic state,
    dynamic about,
    dynamic taxdynamicber,
    dynamic businessRegistration,
    dynamic postCode,
    dynamic countryId,
    dynamic emailVerified,
    dynamic emailVerifyToken,
    dynamic facebookId,
    dynamic appleId,
    dynamic googleId,
    dynamic countryCode,
    String? createdAt,
    String? updatedAt,
    dynamic passwordChangedAt,
    dynamic fbUrl,
    dynamic twUrl,
    dynamic goUrl,
    dynamic liUrl,
    dynamic yoUrl,
    dynamic inUrl,
    dynamic twiUrl,
    dynamic piUrl,
    dynamic drUrl,
    dynamic reUrl,
    dynamic lastSeen,
    String? otpExpireAt,
    dynamic zoneId,
    dynamic latitude,
    dynamic longitude,
    dynamic sellerAddress,
    int? isNew,
  }) =>
      User(
        id: id ?? _id,
        name: name ?? _name,
        email: email ?? _email,
        username: username ?? _username,
        phone: phone ?? _phone,
        otpCode: otpCode ?? _otpCode,
        otpVerified: otpVerified ?? _otpVerified,
        image: image ?? _image,
        profileBackground: profileBackground ?? _profileBackground,
        serviceCity: serviceCity ?? _serviceCity,
        serviceArea: serviceArea ?? _serviceArea,
        userType: userType ?? _userType,
        sellerType: sellerType ?? _sellerType,
        userStatus: userStatus ?? _userStatus,
        termsCondition: termsCondition ?? _termsCondition,
        address: address ?? _address,
        state: state ?? _state,
        about: about ?? _about,
        taxdynamicber: taxdynamicber ?? _taxdynamicber,
        businessRegistration: businessRegistration ?? _businessRegistration,
        postCode: postCode ?? _postCode,
        countryId: countryId ?? _countryId,
        emailVerified: emailVerified ?? _emailVerified,
        emailVerifyToken: emailVerifyToken ?? _emailVerifyToken,
        facebookId: facebookId ?? _facebookId,
        appleId: appleId ?? _appleId,
        googleId: googleId ?? _googleId,
        countryCode: countryCode ?? _countryCode,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        passwordChangedAt: passwordChangedAt ?? _passwordChangedAt,
        fbUrl: fbUrl ?? _fbUrl,
        twUrl: twUrl ?? _twUrl,
        goUrl: goUrl ?? _goUrl,
        liUrl: liUrl ?? _liUrl,
        yoUrl: yoUrl ?? _yoUrl,
        inUrl: inUrl ?? _inUrl,
        twiUrl: twiUrl ?? _twiUrl,
        piUrl: piUrl ?? _piUrl,
        drUrl: drUrl ?? _drUrl,
        reUrl: reUrl ?? _reUrl,
        lastSeen: lastSeen ?? _lastSeen,
        otpExpireAt: otpExpireAt ?? _otpExpireAt,
        zoneId: zoneId ?? _zoneId,
        latitude: latitude ?? _latitude,
        longitude: longitude ?? _longitude,
        sellerAddress: sellerAddress ?? _sellerAddress,
        isNew: isNew ?? _isNew,
      );
  dynamic get id => _id;
  String? get name => _name;
  dynamic get email => _email;
  String? get username => _username;
  String? get phone => _phone;
  String? get otpCode => _otpCode;
  dynamic get otpVerified => _otpVerified;
  dynamic get image => _image;
  dynamic get profileBackground => _profileBackground;
  dynamic get serviceCity => _serviceCity;
  dynamic get serviceArea => _serviceArea;
  dynamic get userType => _userType;
  dynamic get sellerType => _sellerType;
  dynamic get userStatus => _userStatus;
  dynamic get termsCondition => _termsCondition;
  dynamic get address => _address;
  dynamic get state => _state;
  dynamic get about => _about;
  dynamic get taxdynamicber => _taxdynamicber;
  dynamic get businessRegistration => _businessRegistration;
  dynamic get postCode => _postCode;
  dynamic get countryId => _countryId;
  dynamic get emailVerified => _emailVerified;
  dynamic get emailVerifyToken => _emailVerifyToken;
  dynamic get facebookId => _facebookId;
  dynamic get appleId => _appleId;
  dynamic get googleId => _googleId;
  dynamic get countryCode => _countryCode;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  dynamic get passwordChangedAt => _passwordChangedAt;
  dynamic get fbUrl => _fbUrl;
  dynamic get twUrl => _twUrl;
  dynamic get goUrl => _goUrl;
  dynamic get liUrl => _liUrl;
  dynamic get yoUrl => _yoUrl;
  dynamic get inUrl => _inUrl;
  dynamic get twiUrl => _twiUrl;
  dynamic get piUrl => _piUrl;
  dynamic get drUrl => _drUrl;
  dynamic get reUrl => _reUrl;
  dynamic get lastSeen => _lastSeen;
  String? get otpExpireAt => _otpExpireAt;
  dynamic get zoneId => _zoneId;
  dynamic get latitude => _latitude;
  dynamic get longitude => _longitude;
  dynamic get sellerAddress => _sellerAddress;
  dynamic get isNew => _isNew;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['email'] = _email;
    map['username'] = _username;
    map['phone'] = _phone;
    map['otp_code'] = _otpCode;
    map['otp_verified'] = _otpVerified;
    map['image'] = _image;
    map['profile_background'] = _profileBackground;
    map['service_city'] = _serviceCity;
    map['service_area'] = _serviceArea;
    map['user_type'] = _userType;
    map['seller_type'] = _sellerType;
    map['user_status'] = _userStatus;
    map['terms_condition'] = _termsCondition;
    map['address'] = _address;
    map['state'] = _state;
    map['about'] = _about;
    map['tax_dynamicber'] = _taxdynamicber;
    map['business_registration'] = _businessRegistration;
    map['post_code'] = _postCode;
    map['country_id'] = _countryId;
    map['email_verified'] = _emailVerified;
    map['email_verify_token'] = _emailVerifyToken;
    map['facebook_id'] = _facebookId;
    map['apple_id'] = _appleId;
    map['google_id'] = _googleId;
    map['country_code'] = _countryCode;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['password_changed_at'] = _passwordChangedAt;
    map['fb_url'] = _fbUrl;
    map['tw_url'] = _twUrl;
    map['go_url'] = _goUrl;
    map['li_url'] = _liUrl;
    map['yo_url'] = _yoUrl;
    map['in_url'] = _inUrl;
    map['twi_url'] = _twiUrl;
    map['pi_url'] = _piUrl;
    map['dr_url'] = _drUrl;
    map['re_url'] = _reUrl;
    map['last_seen'] = _lastSeen;
    map['otp_expire_at'] = _otpExpireAt;
    map['zone_id'] = _zoneId;
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    map['seller_address'] = _sellerAddress;
    map['isNew'] = _isNew;
    return map;
  }
}
