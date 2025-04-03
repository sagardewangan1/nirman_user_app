import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:phonepe_payment_sdk/phonepe_payment_sdk.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';
import '../../model/PaymentModal.dart';

// focusmedia.co.in
// Merchant ID :-  M22W8Q546PWLY
// Key Index :- 1
// API Key :- 2aae4b9e-e2db-49dc-9838-1867b84d9abe

class PhonePeService {
// ✅ Use "SANDBOX" for testing and "PRODUCTION" for live transactions
//   final String environment = "SANDBOX"; // Development
  final String environment = "PRODUCTION"; // Production
  final String appId = "";
  // final String merchantId = "PGTESTPAYUAT77"; // Development
  final String merchantId = "M227DQKVXSPAZ"; // Production
  String checkSum = "";
  bool enableLogging = true;
  // final String saltKey = "14fa5465-f8a7-443f-8477-f986b8fcfde9"; // Development
  final String saltKey = "fe2830c4-25d0-4078-8e3b-46de68781e28"; // Production
  final String saltIndex = "1";
  final String packageName = "com.shashaktnirmanuserapp";
  final String callBackUrl = "https://sashaktnirmaan.com/";
  final String apiEndPoint = "/pg/v1/pay";
  String flowId = Uuid().v4();
  Object? _result;
  Object? get reuslt => _result;

  setResult(dynamic value) {
    _result = value;
  }

  Future<void> initializePhonePe() async {
    try {
      bool isInitialized = await PhonePePaymentSdk.init(
        environment,
        merchantId,
        flowId,
        enableLogging,
      );
      if (isInitialized) {
        debugPrint("✅ PhonePe SDK Initialized Successfully");
      } else {
        debugPrint("❌ PhonePe SDK Initialization Failed");
      }
    } catch (error) {
      debugPrint("PhonePe Initialization Error: $error");
    }
  }

  Future<PaymentModal?> startTransaction(
      String merchantTransactionId, int amount) async {
    try {
      final response = await PhonePePaymentSdk.startTransaction(
        generateRequestBody(
            merchantTransactionId, amount), // This generates the request body
        appId,
        checkSum,
        packageName,
      );
      print("response transaction ---> $response");
      if (response != null && response['status'] == 'SUCCESS') {
        return checkStatus(merchantTransactionId);
      }
    } catch (error) {
      debugPrint("Transaction Error: $error");
    }
  }

// Helper function to generate request body
  String generateRequestBody(String merchantTransactionId, int amount) {
    final requestData = {
      "merchantId": merchantId,
      "merchantTransactionId": merchantTransactionId,
      "merchantUserId": "Admin",
      "amount": amount * 100,
      "callbackUrl": callBackUrl,
      "mobileNumber": "9981165924",
      "paymentInstrument": {"type": "PAY_PAGE"}
    };
    // return requestData;
    String base64Body = base64.encode(utf8.encode(json.encode(requestData)));
    checkSum =
        '${sha256.convert(utf8.encode(base64Body + apiEndPoint + saltKey)).toString()}###$saltIndex';
    return base64Body;
    // return base64.encode(utf8.encode(json.encode(requestData)));
  }

  // Map<String, dynamic> generateRequestBody(
  //     String merchantTransactionId, int amount) {
  //   Map<String, dynamic> requestData = {
  //     "merchantId": merchantId,
  //     "merchantTransactionId": merchantTransactionId,
  //     "merchantUserId": "user456",
  //     "amount": amount * 100,
  //     "callbackUrl": callBackUrl,
  //     "mobileNumber": "9999999999",
  //     "paymentInstrument": {"type": "PAY_PAGE"}
  //   };
  //   // return requestData;
  //   // String base64Body = base64.encode(utf8.encode(json.encode(requestData)));
  //   // checkSum =
  //   //     '${sha256.convert(utf8.encode(base64Body + apiEndPoint + sal`tKey)).toString()}###$saltIndex';
  //   // return base64Body;
  //   // return base64.encode(utf8.encode(json.encode(requestData)));
  //
  //   // Convert the request data to JSON and then to Base64
  //   String jsonString = json.encode(requestData);
  //   String base64Body = base64.encode(utf8.encode(jsonString));
  //
  //   // Generate the checksum
  //   String checksum =
  //       '${sha256.convert(utf8.encode(base64Body + apiEndPoint + saltKey)).toString()}###$saltIndex';
  //
  //   // Return the Base64 body and checksum
  //   return {"request": base64Body, "x-verify": checksum};
  // }

  Future<PaymentModal> checkStatus(String txnId) async {
    // final String url =
    //     "https://api-preprod.phonepe.com/apis/pg-sandbox/pg/v1/status/$merchantId/$txnId";
    final String url =
        "https://api.phonepe.com/apis/hermes/pg/v1/status/$merchantId/$txnId";
    String hash = sha256
        .convert(utf8.encode("/pg/v1/status/$merchantId/$txnId$saltKey"))
        .toString();
    String xVerify = "$hash###$saltIndex";

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "X-VERIFY": xVerify,
      "X-MERCHANT-ID": merchantId,
    };

    try {
      var response = await http.get(Uri.parse(url), headers: headers);
      print("PhonePe Body response=======> ${response.body}");
      var jsonResponse = jsonDecode(response.body);
      return PaymentModal.fromJson(jsonResponse);
    } catch (e) {
      debugPrint("Check Status Error: $e");
      return PaymentModal();
    }
  }
}
