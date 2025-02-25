import 'package:flutter/foundation.dart';
import 'package:qixer/model/OTPResponseModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  // Set user data after OTP verification
  static Future<void> setData(OtpResponseModel loginResponseDataModel) async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setBool('shashaktnirman_is_logged_in', true);
    prefs.setString('shashaktnirmanUserId',
        loginResponseDataModel.user?.id?.toString() ?? "");
    prefs.setString(
        'shashaktnirmanphone', loginResponseDataModel.user?.phone ?? "");
    prefs.setString(
        'shashaktnirmanemail', loginResponseDataModel.user?.email ?? "");
    prefs.setString('shashaktnirmanusertype',
        loginResponseDataModel.user?.userType.toString() ?? "");
    prefs.setString(
        'shashaktnirmanname', loginResponseDataModel.user?.name ?? "");
    prefs.setString('shashaktnirmanotpCode',
        loginResponseDataModel.user?.otpCode?.toString() ?? "");
    prefs.setString('shashaktnirmanotpVerified',
        loginResponseDataModel.user?.otpVerified?.toString() ?? "");
    prefs.setString(
        'shashaktnirmanimage', loginResponseDataModel.user?.image ?? "");
    prefs.setString('shashaktnirmanprofileBackground',
        loginResponseDataModel.user?.profileBackground ?? "");
    prefs.setString('shashaktnirmanserviceCity',
        loginResponseDataModel.user?.serviceCity ?? "");
    prefs.setString('shashaktnirmanserviceArea',
        loginResponseDataModel.user?.serviceArea ?? "");
    prefs.setString('shashaktnirmansellerType',
        loginResponseDataModel.user?.sellerType?.toString() ?? "");
    prefs.setString('shashaktnirmanuserStatus',
        loginResponseDataModel.user?.userStatus?.toString() ?? "");
    prefs.setString('shashaktnirmantermsCondition',
        loginResponseDataModel.user?.termsCondition?.toString() ?? "");
    prefs.setString(
        'shashaktnirmanaddress', loginResponseDataModel.user?.address ?? "");
    prefs.setString(
        'shashaktnirmanstate', loginResponseDataModel.user?.state ?? "");
    prefs.setString(
        'shashaktnirmanabout', loginResponseDataModel.user?.about ?? "");
    prefs.setString('shashaktnirmantaxNumber',
        loginResponseDataModel.user?.taxdynamicber ?? "");
    prefs.setString('shashaktnirmanbusinessRegistration',
        loginResponseDataModel.user?.businessRegistration ?? "");
    prefs.setString(
        'shashaktnirmanpostCode', loginResponseDataModel.user?.postCode ?? "");
    prefs.setString('shashaktnirmancountryId',
        loginResponseDataModel.user?.countryId?.toString() ?? "");
    prefs.setString('shashaktnirmanemailVerified',
        loginResponseDataModel.user?.emailVerified?.toString() ?? "");
    prefs.setString('shashaktnirmanemailVerifyToken',
        loginResponseDataModel.user?.emailVerifyToken ?? "");
    prefs.setString('shashaktnirmanfacebookId',
        loginResponseDataModel.user?.facebookId ?? "");
    prefs.setString(
        'shashaktnirmanappleId', loginResponseDataModel.user?.appleId ?? "");
    prefs.setString(
        'shashaktnirmangoogleId', loginResponseDataModel.user?.googleId ?? "");
    prefs.setString('shashaktnirmancountryCode',
        loginResponseDataModel.user?.countryCode ?? "");
    prefs.setString('shashaktnirmancreatedAt',
        loginResponseDataModel.user?.createdAt ?? "");
    prefs.setString('shashaktnirmanupdatedAt',
        loginResponseDataModel.user?.updatedAt ?? "");
    prefs.setString('shashaktnirmanpasswordChangedAt',
        loginResponseDataModel.user?.passwordChangedAt ?? "");
    prefs.setString(
        'shashaktnirmanfbUrl', loginResponseDataModel.user?.fbUrl ?? "");
    prefs.setString(
        'shashaktnirmantwUrl', loginResponseDataModel.user?.twUrl ?? "");
    prefs.setString(
        'shashaktnirmangoUrl', loginResponseDataModel.user?.goUrl ?? "");
    prefs.setString(
        'shashaktnirmanliUrl', loginResponseDataModel.user?.liUrl ?? "");
    prefs.setString(
        'shashaktnirmanyoUrl', loginResponseDataModel.user?.yoUrl ?? "");
    prefs.setString(
        'shashaktnirmaninUrl', loginResponseDataModel.user?.inUrl ?? "");
    prefs.setString(
        'shashaktnirmantwiUrl', loginResponseDataModel.user?.twiUrl ?? "");
    prefs.setString(
        'shashaktnirmanpiUrl', loginResponseDataModel.user?.piUrl ?? "");
    prefs.setString(
        'shashaktnirmandrUrl', loginResponseDataModel.user?.drUrl ?? "");
    prefs.setString(
        'shashaktnirmanreUrl', loginResponseDataModel.user?.reUrl ?? "");
    prefs.setString(
        'shashaktnirmanlastSeen', loginResponseDataModel.user?.lastSeen ?? "");
    prefs.setString('shashaktnirmanotpExpireAt',
        loginResponseDataModel.user?.otpExpireAt ?? "");
    prefs.setString('shashaktnirmanzoneId',
        loginResponseDataModel.user?.zoneId?.toString() ?? "");
    prefs.setString('shashaktnirmanlatitude',
        loginResponseDataModel.user?.latitude?.toString() ?? "");
    prefs.setString('shashaktnirmanlongitude',
        loginResponseDataModel.user?.longitude?.toString() ?? "");
    prefs.setString('shashaktnirmansellerAddress',
        loginResponseDataModel.user?.sellerAddress?.toString() ?? "");
    prefs.setString('shashaktnirmanisNew',
        loginResponseDataModel.user?.isNew?.toString() ?? "");
    prefs.setString(
        'shashaktnirmantoken', loginResponseDataModel.token?.toString() ?? "");

    if (kDebugMode) {
      print("User data successfully saved in SharedPreferences.");
      print("-----------------------------------------------------");
      print("Stored values:");
      prefs.getKeys().forEach((key) {
        print("$key: ${prefs.get(key)}");
      });
    }
  }

  static Future<void> clearData() async {
    final prefs = await SharedPreferences.getInstance();

    // Set default values instead of removing
    await prefs.setBool('shashaktnirman_is_logged_in', false);

    await prefs.setString('shashaktnirmanUserId', "");
    await prefs.setString('shashaktnirmanphone', "");
    await prefs.setString('shashaktnirmanemail', "");
    await prefs.setString('shashaktnirmanusertype', "");
    await prefs.setString('shashaktnirmanname', "");
    await prefs.setString('shashaktnirmanotpCode', "");
    await prefs.setString('shashaktnirmanotpVerified', "");
    await prefs.setString('shashaktnirmanimage', "");
    await prefs.setString('shashaktnirmanprofileBackground', "");
    await prefs.setString('shashaktnirmanserviceCity', "");
    await prefs.setString('shashaktnirmanserviceArea', "");
    await prefs.setString('shashaktnirmansellerType', "");
    await prefs.setString('shashaktnirmanuserStatus', "");
    await prefs.setString('shashaktnirmantermsCondition', "");
    await prefs.setString('shashaktnirmanaddress', "");
    await prefs.setString('shashaktnirmanstate', "");
    await prefs.setString('shashaktnirmanabout', "");
    await prefs.setString('shashaktnirmantaxNumber', "");
    await prefs.setString('shashaktnirmanbusinessRegistration', "");
    await prefs.setString('shashaktnirmanpostCode', "");
    await prefs.setString('shashaktnirmancountryId', "");
    await prefs.setString('shashaktnirmanemailVerified', "");
    await prefs.setString('shashaktnirmanemailVerifyToken', "");
    await prefs.setString('shashaktnirmanfacebookId', "");
    await prefs.setString('shashaktnirmanappleId', "");
    await prefs.setString('shashaktnirmangoogleId', "");
    await prefs.setString('shashaktnirmancountryCode', "");
    await prefs.setString('shashaktnirmancreatedAt', "");
    await prefs.setString('shashaktnirmanupdatedAt', "");
    await prefs.setString('shashaktnirmanpasswordChangedAt', "");
    await prefs.setString('shashaktnirmanfbUrl', "");
    await prefs.setString('shashaktnirmantwUrl', "");
    await prefs.setString('shashaktnirmangoUrl', "");
    await prefs.setString('shashaktnirmanliUrl', "");
    await prefs.setString('shashaktnirmanyoUrl', "");
    await prefs.setString('shashaktnirmaninUrl', "");
    await prefs.setString('shashaktnirmantwiUrl', "");
    await prefs.setString('shashaktnirmanpiUrl', "");
    await prefs.setString('shashaktnirmandrUrl', "");
    await prefs.setString('shashaktnirmanreUrl', "");
    await prefs.setString('shashaktnirmanlastSeen', "");
    await prefs.setString('shashaktnirmanotpExpireAt', "");
    await prefs.setString('shashaktnirmanzoneId', "");
    await prefs.setString('shashaktnirmanlatitude', "");
    await prefs.setString('shashaktnirmanlongitude', "");
    await prefs.setString('shashaktnirmansellerAddress', "");
    await prefs.setString('shashaktnirmanisNew', "");
    await prefs.setString('shashaktnirmantoken', "");

    print("User data reset in SharedPreferences.");
  }

  static Future<void> clearAllData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    print("All data cleared from SharedPreferences.");
  }
}
