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

    await prefs.setBool('shashaktnirman_is_logged_in', false);

    await prefs.remove('shashaktnirmanUserId');
    await prefs.remove('shashaktnirmanphone');
    await prefs.remove('shashaktnirmanemail');
    await prefs.remove('shashaktnirmanusertype');
    await prefs.remove('shashaktnirmanname');
    await prefs.remove('shashaktnirmanotpCode');
    await prefs.remove('shashaktnirmanotpVerified');
    await prefs.remove('shashaktnirmanimage');
    await prefs.remove('shashaktnirmanprofileBackground');
    await prefs.remove('shashaktnirmanserviceCity');
    await prefs.remove('shashaktnirmanserviceArea');
    await prefs.remove('shashaktnirmansellerType');
    await prefs.remove('shashaktnirmanuserStatus');
    await prefs.remove('shashaktnirmantermsCondition');
    await prefs.remove('shashaktnirmanaddress');
    await prefs.remove('shashaktnirmanstate');
    await prefs.remove('shashaktnirmanabout');
    await prefs.remove('shashaktnirmantaxNumber');
    await prefs.remove('shashaktnirmanbusinessRegistration');
    await prefs.remove('shashaktnirmanpostCode');
    await prefs.remove('shashaktnirmancountryId');
    await prefs.remove('shashaktnirmanemailVerified');
    await prefs.remove('shashaktnirmanemailVerifyToken');
    await prefs.remove('shashaktnirmanfacebookId');
    await prefs.remove('shashaktnirmanappleId');
    await prefs.remove('shashaktnirmangoogleId');
    await prefs.remove('shashaktnirmancountryCode');
    await prefs.remove('shashaktnirmancreatedAt');
    await prefs.remove('shashaktnirmanupdatedAt');
    await prefs.remove('shashaktnirmanpasswordChangedAt');
    await prefs.remove('shashaktnirmanfbUrl');
    await prefs.remove('shashaktnirmantwUrl');
    await prefs.remove('shashaktnirmangoUrl');
    await prefs.remove('shashaktnirmanliUrl');
    await prefs.remove('shashaktnirmanyoUrl');
    await prefs.remove('shashaktnirmaninUrl');
    await prefs.remove('shashaktnirmantwiUrl');
    await prefs.remove('shashaktnirmanpiUrl');
    await prefs.remove('shashaktnirmandrUrl');
    await prefs.remove('shashaktnirmanreUrl');
    await prefs.remove('shashaktnirmanlastSeen');
    await prefs.remove('shashaktnirmanotpExpireAt');
    await prefs.remove('shashaktnirmanzoneId');
    await prefs.remove('shashaktnirmanlatitude');
    await prefs.remove('shashaktnirmanlongitude');
    await prefs.remove('shashaktnirmansellerAddress');
    await prefs.remove('shashaktnirmanisNew');
    await prefs.remove('shashaktnirmantoken');
    prefs.remove('shashaktnirmanDeviceToken');
    print("User data removed from SharedPreferences.");
  }

  static Future<void> clearAllData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    print("All data cleared from SharedPreferences.");
  }
}
