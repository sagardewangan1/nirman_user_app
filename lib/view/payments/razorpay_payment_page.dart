// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/jobs_service/job_request_service.dart';
import 'package:qixer/service/order_details_service.dart';
import 'package:qixer/service/wallet_service.dart';
import 'package:qixer/view/booking/booking_helper.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../service/booking_services/place_order_service.dart';
import '../../service/payment_gateway_list_service.dart';
import '../../service/rtl_service.dart';

class RazorpayPaymentPage extends StatefulWidget {
  const RazorpayPaymentPage(
      {super.key,
      required this.amount,
      required this.name,
      required this.phone,
      required this.email,
      required this.isFromOrderExtraAccept,
      required this.isFromWalletDeposite,
      required this.isFromHireJob});

  final amount;
  final name;
  final phone;
  final email;
  final isFromOrderExtraAccept;
  final isFromWalletDeposite;
  final isFromHireJob;

  @override
  _RazorpayPaymentPageState createState() => _RazorpayPaymentPageState();
}

class _RazorpayPaymentPageState extends State<RazorpayPaymentPage> {
  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    // amount = Provider.of<BookConfirmationService>(context, listen: false)
    //     .totalPriceAfterAllcalculation
    //     .toString();
    initializeRazorPay();
  }

  void initializeRazorPay() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    launchRazorPay(context);
  }

  void launchRazorPay(BuildContext context) {
    double amountToPay = double.parse(widget.amount) * 100;

    // var options = {
    //   'key': 'rzp_test_FSFnXQOqPP1YbJ',
    //   'amount': "$amountToPay",
    //   'name': name,
    //   'description': ' ',
    //   'prefill': {'contact': phone, 'email': email}
    // };

    final currencyCode =
        Provider.of<RtlService>(context, listen: false).currencyCode;

    var options = {
      'key': Provider.of<PaymentGatewayListService>(context, listen: false)
              .publicKey ??
          '',
      'amount': "$amountToPay",
      'name': widget.name,
      'description': ' ',
      'currency': currencyCode,
      'prefill': {'contact': widget.phone, 'email': widget.email}
    };

    try {
      _razorpay.open(options);
    } catch (e) {}
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    if (widget.isFromOrderExtraAccept == true) {
      Provider.of<OrderDetailsService>(context, listen: false)
          .acceptOrderExtra(context);
    }
    if (widget.isFromWalletDeposite) {
      Provider.of<WalletService>(context, listen: false)
          .makeDepositeToWalletSuccess(context);
    } else if (widget.isFromHireJob) {
      Provider.of<JobRequestService>(context, listen: false)
          .goToJobSuccessPage(context);
    } else {
      Provider.of<PlaceOrderService>(context, listen: false)
          .makePaymentSuccess(context);
    }

    //     "${response.orderId} \n${response.paymentId} \n${response.signature}");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Provider.of<PlaceOrderService>(context, listen: false)
        .doNext(context, 'failed', paymentFailed: true);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {}

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Razorpay"),
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(
                    top: 30, bottom: 20, left: 25, right: 25),
                child:
                    BookingHelper().detailsPanelRow('Total', 0, widget.amount),
              ),
              // textField(size, "Name", false, name),
              // textField(size, "Phone no.", false, phoneNo),
              // textField(size, "Email", false, email),
              // textField(size, "Description", false, description),
              // textField(size, "amount", true, amount),
              // ElevatedButton(
              //   onPressed: launchRazorPay,
              //   child: const Text("Pay Now"),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget textField(Size size, String text, bool isNumerical,
      TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: size.height / 50),
      child: SizedBox(
        height: size.height / 15,
        width: size.width / 1.1,
        child: TextField(
          controller: controller,
          keyboardType: isNumerical ? TextInputType.number : null,
          decoration: InputDecoration(
            hintText: text,
            border: const OutlineInputBorder(),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }
}
