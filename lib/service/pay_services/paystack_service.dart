import 'package:flutter/material.dart';
import 'package:qixer/view/payments/paystack_payment_page.dart';

class PaystackService {
  payByPaystack(BuildContext context,
      {bool isFromOrderExtraAccept = false,
      bool isFromWalletDeposite = false,
      bool isFromHireJob = false}) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => PaystackPaymentPage(
            isFromOrderExtraAccept: isFromOrderExtraAccept,
            isFromWalletDeposite: isFromWalletDeposite,
            isFromHireJob: isFromHireJob),
      ),
    );
  }
}
