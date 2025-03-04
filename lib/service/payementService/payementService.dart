import 'package:flutter/cupertino.dart';

class PaymentService extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // Future<String> checkOutApi(var data) async {
  //   _isLoading = true;
  //   try {
  //     final apiService = NetworkApiServices();
  //     final response = await apiService.getPostApiResponse(
  //         false, AppUrl.baseUrl + AppUrl.authEndPoints.checkoutApi, data);
  //     _isLoading = false;
  //     print("Checkout response:  $response");
  //     print("Checkout response status :  ${response["status"]}");
  //     notifyListeners();
  //     return response["status"];
  //   } catch (e) {
  //     _isLoading = false;
  //     notifyListeners();
  //     throw e;
  //   } finally {
  //     _isLoading = false;
  //   }
  // }

  bool _isCOD = false;
  bool get isCOD => _isCOD;

  void setCOD(bool value) {
    _isCOD = value;
    notifyListeners();
  }

  bool _isReturn = false;
  bool get isReturn => _isReturn;

  void setReturn(bool value) {
    _isReturn = value;
    notifyListeners();
  }

  // String environment = "SANDBOX";
  String environment = "PRODUCTION"; // Production
  String appId = "";
  // String merchantId = "PGTESTPAYUAT";
  String merchantId = "M22N55MM5A1MM"; // Production
  bool enableLogging = true;
  String checkSum = "";
  String pkgName = "com.uniquesolution";
  // String saltkey = "099eb0cd-02cf-4e2a-8aca-3e6c6aff0399";
  String saltkey = "d8814597-b930-486b-9846-0105b62bfb7e"; // Production
  String saltIndex = "1";
  String callBackUrl = "http://uniquesolution.info/";
  String body = "";
  Object? _result;
  Object? get reuslt => _result;

  setResult(dynamic value) {
    _result = value;
  }

  String? _merchantTransactionID;
  String? get merchantTransactionID => _merchantTransactionID;

  setMerchantTransactionID(String mId) {
    _merchantTransactionID = mId;
    notifyListeners();
  }

  String apiEndPoint = "/pg/v1/pay";
}
