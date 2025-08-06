import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:qixer/model/PaymentModal.dart';
import 'package:qixer/service/payementService/PhonePeService.dart';
import 'package:qixer/service/vendorDashboardService/vendorDashboardService.dart';
import 'package:qixer/view/home/landing_page.dart';
import 'package:qixer/view/services/components/desc_from_html.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../service/addServiceProvider/addServicerProvider.dart';
import '../../service/home_services/category_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SubscriptionModule extends StatefulWidget {
  final List<Map<String, dynamic>>? catIds;
  final String? navFrom;
  const SubscriptionModule({super.key, this.catIds, this.navFrom});

  @override
  State<SubscriptionModule> createState() => _SubscriptionModuleState();
}

class _SubscriptionModuleState extends State<SubscriptionModule> {
  ConstantColors cc = ConstantColors();

  final PhonePeService phonePeService = PhonePeService();

  String userId = '';
  String? userType;

  Future<void> firstLoad() async {
    if (!mounted) return;

    final vendorController =
        Provider.of<VendorDashboardService>(context, listen: false);

    // 📌 Step1: Get shared‑prefs (quick)
    final pref = await SharedPreferences.getInstance();
    userId = pref.getString('shashaktnirmanUserId') ?? '';
    userType = pref.getString('shashaktnirmanusertype');

    await Future.wait([
      vendorController.getSubscriptions(), // future #0
    ]);
  }

  @override
  void initState() {
    firstLoad();
    super.initState();
    phonePeService.initializePhonePe();
  }

  Color getTypeTextColor(String typeText) {
    switch (typeText.toLowerCase()) {
      case "free":
        return Colors.green;
      case "upgrade now":
        return Colors.blue;
      case "best value":
        return Colors.orange;
      case "elite":
        return Colors.purple;
      default:
        return Colors.grey.shade400; // Default color for unknown types
    }
  }

  void startPhonePePayment({required int payAmount}) async {
    String transactionId =
        "TXN${DateTime.now().millisecondsSinceEpoch}"; // Generate unique txn ID
    int amount = payAmount; // ₹500
    PaymentModal? result =
        await phonePeService.startTransaction(transactionId, amount);
    if (result != null && result.success == true) {
      if (kDebugMode) {
        print("payement merchantId===> ${result.data?.merchantId}");
        print(
            "payement merchantTransactionId===> ${result.data?.merchantTransactionId}");
        print("payement transactionId===> ${result.data?.transactionId}");
        print("payement amount===> ${result.data?.amount}");
        print("payement state===> ${result.data?.state}");
        print("payement responseCode===> ${result.data?.responseCode}");
      }
      final vendorProvider =
          Provider.of<VendorDashboardService>(context, listen: false);
      var body = {
        'subscription_id': vendorProvider.subscriptionList[0]["id"].toString(),
        'payment_gateway': 'PhonePe',
        'transaction_id': result.data?.transactionId.toString(),
        'payment_status': result.success.toString(),
      };
      await vendorProvider.buySubscriptions(body).then(
        (value) {
          print("value====> $value");
          if (value) {
            OthersHelper().showToast(
                AppLocalizations.of(context)!.subscriptionSuccessMsg,
                cc.successColor);
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LandingPage(),
                ));
          } else {
            OthersHelper().showToast(
                AppLocalizations.of(context)!.subscriptionFailedMsg,
                cc.errorColor);
          }
        },
      );

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Payment Successful!")));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Payment Failed!")));
    }
  }

  void handlePayment(
      {String selectedPaymentMethod = "", required int payAmount}) {
    if (selectedPaymentMethod == "PhonePe") {
      startPhonePePayment(payAmount: payAmount);
      // } else if (selectedPaymentMethod == "COD") {
      //   ScaffoldMessenger.of(context)
      //       .showSnackBar(SnackBar(content: Text("COD Selected")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please select a payment method!")));
    }
  }

  String formatDateTime(String rawDate) {
    try {
      DateTime dateTime = DateTime.parse(rawDate);
      return DateFormat('dd MMM yyyy').format(dateTime);
      // Example Output: 25 Aug 2025, 09:35 AM
    } catch (e) {
      return rawDate; // fallback if parsing fails
    }
  }

  @override
  Widget build(BuildContext context) {
    final addServiceController = Provider.of<AddServiceController>(context);
    final categoryController = Provider.of<CategoryService>(context);
    return WillPopScope(
      onWillPop: () async {
        if (widget.navFrom == "Register") {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LandingPage()));
          return true;
        } else {
          Navigator.pop(context);
          return true;
        }
      },
      child: Consumer<VendorDashboardService>(
        builder: (context, vendorProvider, child) {
          return Scaffold(
              appBar: CommonHelper().appbarCommon(
                AppLocalizations.of(context)!.subscriptions,
                context,
                () {
                  if (widget.navFrom == "Register") {
                    categoryController.clearLists();
                    addServiceController.resetCategories();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LandingPage()));
                  } else {
                    Navigator.pop(context);
                  }
                },
              ),
              body: SafeArea(
                  child: vendorProvider.isLoading
                      ? Center(
                          child: OthersHelper().showLoading(cc.primaryColor))
                      : vendorProvider.isSubscribed == true
                          ? Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Lottie.asset(
                                      "assets/gif/premium.json",
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              const Icon(Icons.error),
                                      fit: BoxFit.cover,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                            color: Colors
                                                .black, // default text color
                                          ),
                                          children: [
                                            TextSpan(
                                                text: AppLocalizations.of(
                                                        context)!
                                                    .youAreaProMsgText),
                                            TextSpan(text: " "),
                                            TextSpan(
                                              text: formatDateTime(
                                                  vendorProvider.expiryDate ??
                                                      ''),
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : vendorProvider.subscriptionList.isNotEmpty
                              ? ListView.builder(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  itemCount:
                                      vendorProvider.subscriptionList.length,
                                  itemBuilder: (context, index) {
                                    var plan =
                                        vendorProvider.subscriptionList[index];
                                    // Skip if type is 'banner top' or 'banner bottom'
                                    if (plan["type"] == "banner top" ||
                                        plan["type"] == "banner bottom") {
                                      return const SizedBox.shrink();
                                    }

                                    return Consumer<VendorDashboardService>(
                                      builder: (contextProvider, value, child) {
                                        List<dynamic>? sellerList =
                                            plan["seller"] as List<dynamic>?;
                                        bool isSubscribed = sellerList?.any(
                                                (seller) =>
                                                    seller["seller_id"]
                                                        .toString() ==
                                                    userId) ??
                                            false;

                                        debugPrint(
                                            "is subscribed =====> $isSubscribed");

                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 10.0),
                                          child: SubscriptionCard(
                                            isLoading: vendorProvider.isLoading,
                                            cc: cc,
                                            freePlan: plan["desc"] ??
                                                "No description",
                                            type: plan["title"] ?? "N/A",
                                            typebgColor: Colors.yellow.shade800,
                                            typeText: plan["typeText"] ?? "",
                                            price:
                                                "${plan["price"]?.toString()}/${plan["type"] ?? ""}",
                                            typeTextColor: Colors.white,
                                            onTapPremium: () async {
                                              if (!isSubscribed) {
                                                handlePayment(
                                                  selectedPaymentMethod:
                                                      "PhonePe",
                                                  payAmount: plan["price"],
                                                );
                                              } else {
                                                OthersHelper().showToast(
                                                  AppLocalizations.of(context)!
                                                      .alreadyPaid,
                                                  cc.warningColor,
                                                );
                                              }
                                            },
                                            isActive: false,
                                            btnText: isSubscribed
                                                ? AppLocalizations.of(context)!
                                                    .alreadyPaid
                                                : AppLocalizations.of(context)!
                                                    .payNow,
                                          ),
                                        );
                                      },
                                    );
                                  },
                                )
                              : Center(
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .noSubscriptionAddedHere,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                )));
        },
      ),
    );
  }
}

class SubscriptionCard extends StatelessWidget {
  const SubscriptionCard({
    super.key,
    required this.cc,
    required this.freePlan,
    required this.type,
    required this.typeText,
    required this.price,
    required this.typebgColor,
    required this.typeTextColor,
    this.onTapPremium,
    this.isActive,
    required this.isLoading,
    required this.btnText,
  });

  final ConstantColors cc;
  final String freePlan;
  final String type;
  final String typeText;
  final String btnText;
  final String price;
  final Color typebgColor;
  final Color typeTextColor;
  final VoidCallback? onTapPremium;
  final bool? isActive;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: isActive == true ? Colors.orange.shade50 : cc.white,
              boxShadow: [
                BoxShadow(
                  color: cc.greyFive,
                  blurRadius: 3,
                  offset: Offset(0, 1),
                )
              ],
              border: Border.all(
                  width: 1,
                  color: isActive == true ? cc.primaryColor : cc.black6)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      textAlign: TextAlign.center,
                      type,
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w600),
                    ),
                    Gap(10),
                    isActive == true
                        ? Icon(
                            Icons.check_circle,
                            size: 14,
                            color: cc.successColor,
                          )
                        : Offstage(),
                  ],
                ),
                // Gap(10),
                // Text(
                //   "INR $rupeeSymbol$price",
                //   style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400),
                // ),
                Gap(10),
                InkWell(
                  onTap: onTapPremium,
                  child: Container(
                    decoration: BoxDecoration(
                      color: typebgColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 5.0),
                      child: Text(
                        "INR $rupeeSymbol$price",
                        style: TextStyle(
                            color: typeTextColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 14),
                      ),
                    ),
                  ),
                ),
                Gap(10),
                DescInHtml(
                  cc: cc,
                  desc: freePlan,
                ),
                Gap(10),
                Center(
                  child: InkWell(
                    onTap: onTapPremium,
                    child: Container(
                      decoration: BoxDecoration(
                        color: cc.primaryColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 5.0),
                        child: Text(
                          btnText,
                          style: TextStyle(
                              color: typeTextColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        isLoading
            ? Center(child: OthersHelper().showLoading(cc.primaryColor))
            : Offstage()
      ],
    );
  }
}
