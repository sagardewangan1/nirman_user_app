import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:qixer/service/app_string_service.dart';
import 'package:qixer/service/getImageController.dart';
import 'package:qixer/service/payementService/PhonePeService.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/others_helper.dart';

import '../../model/PaymentModal.dart';

class AddRequestForPosterAdd extends StatefulWidget {
  const AddRequestForPosterAdd({super.key});

  @override
  State<AddRequestForPosterAdd> createState() => _AddRequestForPosterAddState();
}

class _AddRequestForPosterAddState extends State<AddRequestForPosterAdd> {
  ConstantColors cc = ConstantColors();

  final PhonePeService phonePeService = PhonePeService();
  String selectedPaymentMethod = "";
  @override
  void initState() {
    super.initState();
    phonePeService.initializePhonePe();
  }

  void startPhonePePayment() async {
    String transactionId =
        "TXN${DateTime.now().millisecondsSinceEpoch}"; // Generate unique txn ID
    int amount = 500; // ₹500

    PaymentModal? result =
        await phonePeService.startTransaction(transactionId, amount);

    if (result != null && result.success == true) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Payment Successful!")));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Payment Failed!")));
    }
  }

  void handlePayment() {
    if (selectedPaymentMethod == "PhonePe") {
      startPhonePePayment();
    } else if (selectedPaymentMethod == "COD") {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("COD Selected")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please select a payment method!")));
    }
  }

  @override
  Widget build(BuildContext context) {
    final getImageController = Provider.of<GetImageController>(context);
    return Consumer<AppStringService>(
      builder: (context, value, child) {
        return Scaffold(
          appBar: CommonHelper().appbarCommon(
            "Advertisement", context, () => Navigator.pop(context),
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
          body: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: PayBannerContainer(
                  description:
                      "Add Your Upper Banner Here This will show up to 1 Apr 2025",
                  price: "\u{20B9}100/-",
                  onTap: () {
                    // Handle the tap event here
                    print("Banner tapped! 1");
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: PayBannerContainer(
                  description:
                      "Add Your Lower Banner Here This will show up to 1 Apr 2025",
                  price: "\u{20B9}150/-",
                  onTap: () {
                    startPhonePePayment();
                  },
                ),
              )
            ],
          ),
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
                  description ??
                      "Add Your Banner Here This will show up to 1 Apr 2025",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: cc.white,
                  ),
                ),
                Text(
                  textAlign: TextAlign.center,
                  price ?? "\u{20B9}200/-",
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
                      "Pay Now",
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
