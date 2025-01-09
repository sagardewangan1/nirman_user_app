import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:flutterzilla_fixed_grid/flutterzilla_fixed_grid.dart';
import 'package:provider/provider.dart';
import 'package:qixer/helper/extension/context_extension.dart';
import 'package:qixer/helper/extension/int_extension.dart';
import 'package:qixer/service/app_string_service.dart';
import 'package:qixer/service/booking_services/book_service.dart';
import 'package:qixer/service/booking_services/place_order_service.dart';
import 'package:qixer/service/pay_services/bank_transfer_service.dart';
import 'package:qixer/service/pay_services/payment_constants.dart';
import 'package:qixer/service/payment_gateway_list_service.dart';
import 'package:qixer/service/wallet_service.dart';
import 'package:qixer/view/booking/components/deposite_amount_section.dart';
import 'package:qixer/view/booking/components/total_payable.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/constant_styles.dart';
import 'package:qixer/view/utils/others_helper.dart';

import '../auth/signup/pages/tac_pp.dart';

class PaymentChoosePage extends StatefulWidget {
  const PaymentChoosePage(
      {super.key,
      this.isFromOrderExtraAccept = false,
      this.isFromDepositeToWallet = false,
      this.payAgain = false,
      this.isFromHireJob = false});

  final bool isFromOrderExtraAccept;
  final bool payAgain;
  final bool isFromDepositeToWallet;
  final bool isFromHireJob;

  @override
  _PaymentChoosePageState createState() => _PaymentChoosePageState();
}

class _PaymentChoosePageState extends State<PaymentChoosePage> {
  @override
  void initState() {
    super.initState();
  }

  int selectedMethod = 0;
  bool termsAgree = false;
  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();

    //fetch payment gateway list
    Provider.of<PaymentGatewayListService>(context, listen: false)
        .fetchGatewayList(context);

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CommonHelper().appbarCommon('Payment', context, () {
          Navigator.pop(context);
        }),
        body: SingleChildScrollView(
          physics: physicsCommon,
          child: Consumer<AppStringService>(
            builder: (context, asProvider, child) => Container(
              padding: EdgeInsets.symmetric(horizontal: screenPadding),
              child: Consumer<PaymentGatewayListService>(
                builder: (context, pgProvider, child) => pgProvider
                        .paymentList.isNotEmpty
                    ? Consumer<PlaceOrderService>(
                        builder: (context, provider, child) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //border
                              Container(
                                margin: const EdgeInsets.only(bottom: 20),
                                child: CommonHelper().dividerCommon(),
                              ),

                              //Total payable
                              if (widget.isFromDepositeToWallet == false)
                                TotalPayable(
                                  isFromOrderExtraAccept:
                                      widget.isFromOrderExtraAccept,
                                  isFromJobHire: widget.isFromHireJob,
                                ),

                              //Deposite amount
                              if (widget.isFromDepositeToWallet)
                                const DepositeAmountSection(),

                              if (!widget.isFromDepositeToWallet)
                                Container(
                                  margin: const EdgeInsets.only(
                                      top: 10, bottom: 20),
                                  child: CommonHelper().dividerCommon(),
                                ),

                              CommonHelper().titleCommon(asProvider
                                  .getString('Choose payment method')),

                              //payment method card
                              GridView.builder(
                                gridDelegate: const FlutterzillaFixedGridView(
                                    crossAxisCount: 3,
                                    mainAxisSpacing: 15,
                                    crossAxisSpacing: 15,
                                    height: 60),
                                padding: const EdgeInsets.only(top: 30),
                                itemCount: pgProvider.paymentList.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                clipBehavior: Clip.none,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        selectedMethod = index;
                                      });

                                      pgProvider.setSelectedMethodName(
                                          pgProvider.paymentList[selectedMethod]
                                              ['name']);

                                      //set key
                                      pgProvider.setKey(
                                          pgProvider.paymentList[selectedMethod]
                                              ['name'],
                                          index);

                                      //save selected payment method name
                                      Provider.of<BookService>(context,
                                              listen: false)
                                          .setSelectedPayment(pgProvider
                                                  .paymentList[selectedMethod]
                                              ['name']);
                                    },
                                    child: Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          height: 60,
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                                color: selectedMethod == index
                                                    ? cc.primaryColor
                                                    : cc.borderColor),
                                          ),
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                pgProvider.paymentList[index]
                                                    ['logo_link'],
                                            placeholder: (context, url) {
                                              return Image.asset(
                                                  'assets/images/loading_image.png');
                                            },
                                            // fit: BoxFit.fitWidth,
                                          ),
                                        ),
                                        selectedMethod == index
                                            ? Positioned(
                                                right: -7,
                                                top: -9,
                                                child: CommonHelper()
                                                    .checkCircle())
                                            : Container()
                                      ],
                                    ),
                                  );
                                },
                              ),

                              pgProvider.paymentList[selectedMethod]['name'] ==
                                      'manual_payment'
                                  ?
                                  //pick image ==========>
                                  Consumer<BankTransferService>(
                                      builder: (context, btProvider, child) =>
                                          Column(
                                            children: [
                                              if (pgProvider.paymentList[
                                                          selectedMethod]
                                                      ['description'] !=
                                                  null) ...[
                                                12.toHeight,
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(20),
                                                  decoration: BoxDecoration(
                                                      color: cc.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                      border: Border.all(
                                                        color: cc.borderColor,
                                                      )),
                                                  child: HtmlWidget(pgProvider
                                                                  .paymentList[
                                                              selectedMethod]
                                                          ['description'] ??
                                                      ""),
                                                )
                                              ],
                                              //pick image button =====>
                                              Column(
                                                children: [
                                                  const SizedBox(
                                                    height: 30,
                                                  ),
                                                  CommonHelper().buttonOrange(
                                                      asProvider.getString(
                                                          'Choose image'), () {
                                                    btProvider
                                                        .pickImage(context);
                                                  }),
                                                ],
                                              ),
                                              btProvider.pickedImage != null
                                                  ? Column(
                                                      children: [
                                                        sizedBoxCustom(30),
                                                        SizedBox(
                                                          height: 80,
                                                          child: Image.file(
                                                            File(btProvider
                                                                .pickedImage
                                                                .path),
                                                            height: 80,
                                                            width: 80,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  : Container(),
                                            ],
                                          ))
                                  : Container(),

                              //Agreement checkbox ===========>
                              sizedBoxCustom(20),

                              Row(children: [
                                Checkbox(
                                  checkColor: Colors.white,
                                  activeColor: ConstantColors().primaryColor,
                                  value: termsAgree,
                                  onChanged: (newValue) {
                                    setState(() {
                                      termsAgree = !termsAgree;
                                    });
                                  },
                                ),
                                Expanded(
                                  flex: 1,
                                  child: RichText(
                                    softWrap: true,
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,
                                    text: TextSpan(
                                        text:
                                            asProvider.getString("I agree to") +
                                                " ",
                                        style: TextStyle(
                                          color: cc.black5,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        children: [
                                          TextSpan(
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  context.toPage(const TacPP(
                                                    route:
                                                        "/terms-and-condition",
                                                  ));
                                                  FocusScope.of(context)
                                                      .unfocus();
                                                },
                                              text: asProvider.getString(
                                                  "Terms & Conditions"),
                                              style: TextStyle(
                                                color: cc.primaryColor,
                                                fontWeight: FontWeight.w600,
                                              )),
                                          TextSpan(
                                              text:
                                                  "${" " + asProvider.getString("and")} ",
                                              style:
                                                  TextStyle(color: cc.black5)),
                                          TextSpan(
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  context.toPage(const TacPP(
                                                    route: "/privacy-policy",
                                                  ));
                                                  FocusScope.of(context)
                                                      .unfocus();
                                                },
                                              text: asProvider
                                                  .getString("Privacy policy"),
                                              style: TextStyle(
                                                color: cc.primaryColor,
                                                fontWeight: FontWeight.w600,
                                              )),
                                        ]),
                                  ),
                                ),
                              ]),

                              //pay button =============>
                              const SizedBox(
                                height: 20,
                              ),
                              CommonHelper().buttonOrange(
                                  asProvider.getString('Pay & Confirm'),
                                  () async {
                                var w = await Provider.of<WalletService>(
                                        context,
                                        listen: false)
                                    .validate(
                                        context, widget.isFromDepositeToWallet);

                                if (w == false) return;

                                if (termsAgree == false) {
                                  OthersHelper().showToast(
                                      asProvider.getString(
                                          'You must agree with the terms and conditions to place the order'),
                                      Colors.black);
                                  return;
                                }
                                if (provider.isloading == true) {
                                  return;
                                } else {
                                  // if deposite from current balance is selected

                                  payAction(
                                      pgProvider.paymentList[selectedMethod]
                                          ['name'],
                                      context,
                                      //if user selected bank transfer
                                      pgProvider.paymentList[selectedMethod]
                                                  ['name'] ==
                                              'manual_payment'
                                          ? Provider.of<BankTransferService>(
                                                  context,
                                                  listen: false)
                                              .pickedImage
                                          : null,
                                      isFromOrderExtraAccept:
                                          widget.isFromOrderExtraAccept,
                                      isFromWalletDeposite:
                                          widget.isFromDepositeToWallet,
                                      payAgain: widget.payAgain,
                                      isFromHireJob: widget.isFromHireJob);
                                }
                              },
                                  isloading: provider.isloading == false
                                      ? false
                                      : true),

                              sizedBoxCustom(30)
                            ]),
                      )
                    : Container(
                        margin: const EdgeInsets.only(top: 60),
                        child: OthersHelper().showLoading(cc.primaryColor),
                      ),
              ),
            ),
          ),
        ));
  }
}
