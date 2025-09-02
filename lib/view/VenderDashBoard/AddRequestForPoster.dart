import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:qixer/service/app_string_service.dart';
import 'package:qixer/service/getImageController.dart';
import 'package:qixer/service/payementService/PhonePeService.dart';
import 'package:qixer/service/vendorDashboardService/vendorDashboardService.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:qixer/generated/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/PaymentModal.dart';

class AddRequestForPosterAdd extends StatefulWidget {
  const AddRequestForPosterAdd({super.key});

  @override
  State<AddRequestForPosterAdd> createState() => _AddRequestForPosterAddState();
}

class _AddRequestForPosterAddState extends State<AddRequestForPosterAdd> {
  ConstantColors cc = ConstantColors();

  final PhonePeService phonePeService = PhonePeService();
  @override
  void initState() {
    super.initState();
    firstLoad();
    phonePeService.initializePhonePe();
  }

  String userId = '';

  firstLoad() async {
    if (mounted) {
      final vendorController =
          Provider.of<VendorDashboardService>(context, listen: false);
      await vendorController.getSubscriptions(type: "banner");
      final pref = await SharedPreferences.getInstance();
      userId = pref.getString("shashaktnirmanUserId") ?? '';
    }
  }

  void startPhonePePayment({int? payAmount, String? subscriptionId}) async {
    String transactionId =
        "TXN${DateTime.now().millisecondsSinceEpoch}"; // Generate unique txn ID
    int amount = payAmount ?? 0; // ₹500

    PaymentModal? result =
        await phonePeService.startTransaction(transactionId, amount);
    if (result != null && result.success == true) {
      final vendorProvider =
          Provider.of<VendorDashboardService>(context, listen: false);
      var body = {
        ''
            'subscription_id': subscriptionId,
        'payment_gateway': 'PhonePe',
        'transaction_id': result.data?.transactionId.toString(),
        'payment_status': result.success.toString(),
      };
      await vendorProvider.buySubscriptions(body).then((value) {
        if (value) {
          firstLoad();
        } else {
          OthersHelper().showToast(
              AppLocalizations.of(context)!.subscriptionFailedMsg,
              cc.errorColor);
        }
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Payment Successful!")));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Payment Failed!")));
    }
  }

  void handlePayment(
      {int? payAmount, String? subscriptionId, String? selectedPaymentMethod}) {
    if (selectedPaymentMethod == "PhonePe") {
      startPhonePePayment(payAmount: payAmount, subscriptionId: subscriptionId);
      // } else if (selectedPaymentMethod == "COD") {
      //   ScaffoldMessenger.of(context)
      //       .showSnackBar(SnackBar(content: Text("COD Selected")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please select a payment method!")));
    }
  }

  @override
  Widget build(BuildContext context) {
    final getImageController = Provider.of<GetImageController>(context);
    return Consumer<VendorDashboardService>(
      builder: (context, vendorProvider, child) {
        return WillPopScope(
          onWillPop: () async {
            getImageController.removeBannerImages();
            return true;
          },
          child: Scaffold(
              appBar: CommonHelper().appbarCommon(
                AppLocalizations.of(context)!.advertisement, context,
                () => Navigator.pop(context),
                // actions: [
                //   Padding(
                //     padding: const EdgeInsets.all(8.0),
                //     child: InkWell(
                //       onTap: () {
                //         showDaySelectionDialog(context);
                //       },
                //       child: Container(
                //           alignment: Alignment.center,
                //           decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(6.0),
                //             color: cc.primaryColor,
                //           ),
                //           child: Padding(
                //             padding: const EdgeInsets.symmetric(
                //                 horizontal: 8.0, vertical: 4),
                //             child: Icon(
                //               Icons.add,
                //               color: cc.white,
                //             ),
                //           )),
                //     ),
                //   ),
                // ]
              ),
              body: SafeArea(
                child: vendorProvider.isLoading
                    ? Center(child: OthersHelper().showLoading(cc.primaryColor))
                    : vendorProvider.subscriptionList.isNotEmpty
                        ? ListView.builder(
                            itemCount: vendorProvider.subscriptionList.length,
                            itemBuilder: (context, index) {
                              var plan = vendorProvider.subscriptionList[index];
                              String subscriptionId = plan["id"].toString();

                              // Check if seller exists and get its banner_info
                              List<dynamic>? sellerList =
                                  plan["seller"] as List<dynamic>?;
                              String? bannerImageUrl;
                              // Get banner info from the first seller (assuming one seller per subscription)
                              var bannerInfo = (sellerList?.isNotEmpty == true)
                                  ? sellerList![0]["banner_info"]
                                  : null;

                              // Ensure bannerInfo is a Map and not an empty list or null
                              if (bannerInfo is Map<String, dynamic> &&
                                  bannerInfo.isNotEmpty) {
                                // Extract image URL from banner_info
                                bannerImageUrl = bannerInfo["image_url"];
                              } else {
                                bannerImageUrl =
                                    null; // No valid banner available
                              }

                              debugPrint(
                                  "🖼 Banner Image URL: ${bannerImageUrl ?? 'No banner available'}");

                              // Extract image URL from banner_info

                              bool isSubscribed = sellerList?.any((seller) =>
                                      seller["seller_id"].toString() ==
                                      userId) ??
                                  false;

                              // Fetch selected image specific to this subscription
                              File? selectedImage = getImageController
                                  .fileForTopBannerMap[subscriptionId];

                              debugPrint("🆔 Subscription ID: $subscriptionId");
                              debugPrint("🛠 Is Subscribed: $isSubscribed");
                              debugPrint(
                                  "🖼 Banner Image URL: ${bannerImageUrl ?? 'No banner available'}");
                              debugPrint(
                                  "📸 Selected Image: ${selectedImage?.path}");

                              return isSubscribed
                                  ? Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: () async {
                                          getImageController
                                              .chooseImageForTopBanner(
                                                  subscriptionId);
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: 150,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color: cc.successColor
                                                    .withOpacity(0.1),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                border: Border.all(
                                                    color: cc.successColor),
                                              ),
                                              alignment: Alignment.center,
                                              child: selectedImage != null
                                                  ? ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      child: Image.file(
                                                        height: 150,
                                                        width: double.infinity,
                                                        selectedImage,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    )
                                                  : bannerImageUrl != null
                                                      ? ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          child: CommonHelper()
                                                              .profileImage(
                                                                  bannerImageUrl,
                                                                  150,
                                                                  double
                                                                      .infinity,
                                                                  fit: BoxFit
                                                                      .cover))
                                                      : Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Icon(
                                                              size: 40,
                                                              Icons
                                                                  .image_search,
                                                              color: cc.black6,
                                                            ),
                                                            Text(
                                                              AppLocalizations.of(
                                                                      context)!
                                                                  .addPosterForTopSlider,
                                                              style: TextStyle(
                                                                color:
                                                                    cc.black5,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child:
                                                  CommonHelper().buttonOrange(
                                                paddingVerticle: 10,
                                                AppLocalizations.of(context)!
                                                    .save,
                                                () async {
                                                  if (selectedImage != null) {
                                                    String imagePath =
                                                        selectedImage.path;
                                                    String subscriptionId =
                                                        plan["id"].toString();
                                                    debugPrint(
                                                        "📌 Clicked Subscription ID: $subscriptionId"); // ✅ Print Subscription ID
                                                    bool success =
                                                        await vendorProvider
                                                            .uploadBanner(
                                                      subscriptionId,
                                                      context,
                                                      imagePath: imagePath,
                                                    );

                                                    if (success) {
                                                      // ✅ Image successfully uploaded
                                                      getImageController
                                                                  .fileForTopBannerMap[
                                                              subscriptionId] =
                                                          File(imagePath);
                                                      OthersHelper().showToast(
                                                          "Banner uploaded successfully!",
                                                          cc.successColor);
                                                    } else {
                                                      OthersHelper().showToast(
                                                          "Failed to upload banner!",
                                                          cc.errorColor);
                                                    }
                                                  } else {
                                                    OthersHelper().showToast(
                                                        "Please select an image before saving!",
                                                        cc.warningColor);
                                                  }

                                                  // if (plan['id'] == plan['id']) {
                                                  //   print(
                                                  //       "tapped top plan id ${plan['id']} ${selectedImage?.path}");
                                                  // } else {
                                                  //   print(
                                                  //       "tapped bottom plan id ${plan['id']} ${selectedImage?.path}");
                                                  // }
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: PayBannerContainer(
                                        description: plan['desc'] ?? "NA",
                                        price: "${plan["price"]}/-",
                                        onTap: () async {
                                          handlePayment(
                                              payAmount: plan['price'],
                                              subscriptionId:
                                                  plan['id'].toString(),
                                              selectedPaymentMethod: "PhonePe");
                                        },
                                      ),
                                    );
                            },
                          )
                        : Center(
                            child: Text(
                              textAlign: TextAlign.center,
                              AppLocalizations.of(context)!
                                  .noSubscriptionAddedHere,
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                          ),
              )),
        );
      },
    );
  }

  GestureDetector PayBannerContainer({
    String? description,
    String? price,
    VoidCallback? onTap,
  }) =>
      GestureDetector(
        // Use GestureDetector to handle taps
        onTap: onTap, // Call the onTap callback when the container is tapped
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: cc.primaryColor,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(color: cc.black6, blurRadius: 3, offset: Offset(0, 2))
              ]),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  textAlign: TextAlign.center,
                  description ?? "",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: cc.white,
                  ),
                ),
                Text(
                  textAlign: TextAlign.center,
                  "\u{20B9}$price" ?? "\u{20B9}200/-",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: cc.white,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(width: 1, color: cc.white),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(
                      textAlign: TextAlign.center,
                      AppLocalizations.of(context)!.payNow,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: cc.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

// ListView.builder(
// itemCount: 7,
// itemBuilder: (context, index) {
// return Padding(
// padding: const EdgeInsets.all(8.0),
// child: Container(
// decoration: BoxDecoration(
// color: cc.white,
// borderRadius: BorderRadius.circular(8.0),
// boxShadow: [
// BoxShadow(
// color: Colors.grey.withOpacity(0.2),
// blurRadius: 3,
// offset: Offset(0, 2),
// ),
// ],
// ),
// padding: EdgeInsets.symmetric(
// vertical: 12, horizontal: 10),
// child: Row(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// CommonHelper().profileImage(
// "https://i.pinimg.com/originals/96/64/a9/9664a927650847190ac0f1c29fb79c5f.jpg",
// 100,
// 100),
// SizedBox(width: 12),
// Expanded(
// child: Column(
// crossAxisAlignment:
// CrossAxisAlignment.start,
// mainAxisAlignment: MainAxisAlignment.start,
// children: [
// // RichText(
// //   text: TextSpan(
// //     text: "Description : ",
// //     style: TextStyle(
// //       fontSize: 14,
// //       fontWeight: FontWeight.w500,
// //       color: cc.black3,
// //     ),
// //     children: [
// //       TextSpan(
// //         text:
// //             "An advertisement description is a communication that promotes a product, service, or brand. It aims to attract interest, engagement, and sales",
// //         style: TextStyle(
// //           fontSize: 14,
// //           fontWeight: FontWeight.w400,
// //           color: cc.black6,
// //         ),
// //       ),
// //     ],
// //   ),
// // ),
// // SizedBox(height: 4),
// RichText(
// text: TextSpan(
// text: "Valid Upto : ",
// style: TextStyle(
// fontSize: 14,
// fontWeight: FontWeight.w500,
// color: cc.black3,
// ),
// children: [
// TextSpan(
// text: "1 Apr 2025",
// style: TextStyle(
// fontSize: 14,
// fontWeight: FontWeight.w400,
// color: cc.black6,
// ),
// ),
// ],
// ),
// ),
// SizedBox(height: 4),
// RichText(
// text: TextSpan(
// text: "Status : ",
// style: TextStyle(
// fontSize: 14,
// fontWeight: FontWeight.w500,
// color: cc.black3,
// ),
// children: [
// TextSpan(
// text: "Active",
// style: TextStyle(
// fontSize: 14,
// fontWeight: FontWeight.w400,
// color: cc.successColor,
// ),
// ),
// ],
// ),
// ),
// ],
// ),
// ),
// Icon(
// Icons.disabled_by_default,
// color: cc.errorColor,
// ),
// ],
// ),
// ));
// },
// )
