// To parse this JSON data, do
//
//     final myordersListModel = profileModel(jsonString);

import 'dart:convert';

ProfileModel profileModel(String str) =>
    ProfileModel.fromJson(json.decode(str));

String myordersListModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  ProfileModel({
    this.userDetails,
    this.pendingOrder,
    this.activeOrder,
    this.completeOrder,
    this.totalOrder,
  });

  UserDetails? userDetails;
  int? pendingOrder;
  int? activeOrder;
  int? completeOrder;
  int? totalOrder;

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        userDetails: UserDetails.fromJson(json["user_details"]),
        pendingOrder: json["pending_order"],
        activeOrder: json["active_order"],
        completeOrder: json["complete_order"],
        totalOrder: json["total_order"],
      );

  Map<String, dynamic> toJson() => {
        "user_details": userDetails?.toJson(),
        "pending_order": pendingOrder,
        "active_order": activeOrder,
        "complete_order": completeOrder,
        "total_order": totalOrder,
      };
}

// "businessName": "surya Avon electronic",
// "businessGstNumber": "dfhhhh",
// "businessPhoneNumber": "8899788899",
// "businessEmail": "cfghbdf",
// "businessFullAddress": "dfhfsdtyhderyggfereeftrf",
// "businessDescription": "cfhffhfddefhhhffffrggh",

class UserDetails {
  UserDetails({
    this.id,
    this.name,
    this.email,
    this.username,
    this.phone,
    this.businessName,
    this.businessGstNumber,
    this.businessPhoneNumber,
    this.businessEmail,
    this.businessFullAddress,
    this.businessDescription,
    this.workingCategories,
    this.otpCode,
    this.otpVerified,
    this.image,
    this.profileBackground,
    this.serviceCity,
    this.serviceArea,
    this.userType,
    this.sellerType,
    this.isNew,
    this.userStatus,
    this.termsCondition,
    this.address,
    this.state,
    this.about,
    this.taxNumber,
    this.businessRegistration,
    this.postCode,
    this.countryId,
    this.emailVerified,
    this.emailVerifyToken,
    this.facebookId,
    this.appleId,
    this.googleId,
    this.countryCode,
    this.createdAt,
    this.updatedAt,
    this.passwordChangedAt,
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
    this.lastSeen,
    this.otpExpireAt,
    this.zoneId,
    this.latitude,
    this.longitude,
    this.sellerAddress,
    this.country,
    this.city,
    this.area,
  });

  int? id;
  String? name;
  String? email;
  String? username;
  String? phone;
  String? businessName;
  String? businessGstNumber;
  String? businessPhoneNumber;
  String? businessEmail;
  String? businessFullAddress;
  String? businessDescription;
  List<String>? workingCategories;
  String? otpCode;
  int? otpVerified;
  String? image;
  String? profileBackground;
  String? serviceCity;
  String? serviceArea;
  int? userType;
  int? sellerType;
  int? isNew;
  int? userStatus;
  int? termsCondition;
  String? address;
  String? state;
  String? about;
  String? taxNumber;
  String? businessRegistration;
  String? postCode;
  dynamic? countryId;
  int? emailVerified;
  String? emailVerifyToken;
  String? facebookId;
  String? appleId;
  String? googleId;
  String? countryCode;
  String? createdAt;
  String? updatedAt;
  String? passwordChangedAt;
  String? fbUrl;
  String? twUrl;
  String? goUrl;
  String? liUrl;
  String? yoUrl;
  String? inUrl;
  String? twiUrl;
  String? piUrl;
  String? drUrl;
  String? reUrl;
  String? lastSeen;
  String? otpExpireAt;
  String? zoneId;
  String? latitude;
  String? longitude;
  String? sellerAddress;
  Country? country;
  City? city;
  Area? area;

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        username: json["username"],
        phone: json["phone"],
        businessName: json["businessName"],
        businessGstNumber: json["businessGstNumber"],
        businessPhoneNumber: json["businessPhoneNumber"],
        businessEmail: json["businessEmail"],
        businessFullAddress: json["businessFullAddress"],
        businessDescription: json["businessDescription"],
        workingCategories: (json["working_categories"] != null)
            ? List<String>.from(jsonDecode(json["working_categories"]))
            : [],
        otpCode: json["otp_code"],
        otpVerified: json["otp_verified"],
        image: json["image"],
        profileBackground: json["profile_background"],
        serviceCity: json["service_city"],
        serviceArea: json["service_area"],
        userType: json["user_type"],
        sellerType: json["seller_type"],
        isNew: json["isNew"],
        userStatus: json["user_status"],
        termsCondition: json["terms_condition"],
        address: json["address"],
        state: json["state"],
        about: json["about"],
        taxNumber: json["tax_number"],
        businessRegistration: json["business_registration"],
        postCode: json["post_code"],
        countryId: json["country_id"] ?? '6',
        emailVerified: json["email_verified"],
        emailVerifyToken: json["email_verify_token"],
        facebookId: json["facebook_id"],
        appleId: json["apple_id"],
        googleId: json["google_id"],
        countryCode: json["country_code"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        passwordChangedAt: json["password_changed_at"],
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
        lastSeen: json["last_seen"],
        otpExpireAt: json["otp_expire_at"],
        zoneId: json["zone_id"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        sellerAddress: json["seller_address"],
        country:
            json["country"] != null && json["country"] is Map<String, dynamic>
                ? Country.fromJson(json["country"])
                : null,
        city: json["city"] != null && json["city"] is Map<String, dynamic>
            ? City.fromJson(json["city"])
            : null,
        area: json["area"] != null && json["area"] is Map<String, dynamic>
            ? Area.fromJson(json["area"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "username": username,
        "phone": phone,
        "businessName": businessName,
        "businessGstNumber": businessGstNumber,
        "businessPhoneNumber": businessPhoneNumber,
        "businessEmail": businessEmail,
        "businessFullAddress": businessFullAddress,
        "businessDescription": businessDescription,
        "working_categories":
            workingCategories != null ? jsonEncode(workingCategories) : "[]",
        "otp_code": otpCode,
        "otp_verified": otpVerified,
        "image": image,
        "profile_background": profileBackground,
        "service_city": serviceCity,
        "service_area": serviceArea,
        "user_type": userType,
        "seller_type": sellerType,
        "isNew": isNew,
        "user_status": userStatus,
        "terms_condition": termsCondition,
        "address": address,
        "state": state,
        "about": about,
        "tax_number": taxNumber,
        "business_registration": businessRegistration,
        "post_code": postCode,
        "country_id": countryId,
        "email_verified": emailVerified,
        "email_verify_token": emailVerifyToken,
        "facebook_id": facebookId,
        "apple_id": appleId,
        "google_id": googleId,
        "country_code": countryCode,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "password_changed_at": passwordChangedAt,
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
        "last_seen": lastSeen,
        "otp_expire_at": otpExpireAt,
        "zone_id": zoneId,
        "latitude": latitude,
        "longitude": longitude,
        "seller_address": sellerAddress,
        "country": country?.toJson(),
        "city": city?.toJson(),
        "area": area?.toJson(),
      };
}

class Area {
  Area({
    this.id,
    this.serviceArea,
    this.serviceCityId,
    this.countryId,
    this.status,
  });

  int? id;
  String? serviceArea;
  int? serviceCityId;
  int? countryId;
  int? status;

  factory Area.fromJson(Map<String?, dynamic>? json) => Area(
        id: json?["id"],
        serviceArea: json?["service_area"],
        serviceCityId: json?["service_city_id"],
        countryId: json?["country_id"],
        status: json?["status"],
      );

  Map<String?, dynamic>? toJson() => {
        "id": id,
        "service_area": serviceArea,
        "service_city_id": serviceCityId,
        "country_id": countryId,
        "status": status,
      };
}

class City {
  City({
    this.id,
    this.serviceCity,
    this.countryId,
    this.status,
  });

  int? id;
  String? serviceCity;
  int? countryId;
  int? status;

  factory City.fromJson(Map<String?, dynamic>? json) => City(
        id: json?["id"],
        serviceCity: json?["service_city"],
        countryId: json?["country_id"],
        status: json?["status"],
      );

  Map<String?, dynamic>? toJson() => {
        "id": id,
        "service_city": serviceCity,
        "country_id": countryId,
        "status": status,
      };
}

class Country {
  Country({
    this.id,
    this.country,
    this.status,
  });

  int? id;
  String? country;
  int? status;

  factory Country.fromJson(Map<String?, dynamic>? json) => Country(
        id: json?["id"],
        country: json?["country"],
        status: json?["status"],
      );

  Map<String?, dynamic>? toJson() => {
        "id": id,
        "country": country,
        "status": status,
      };
}
