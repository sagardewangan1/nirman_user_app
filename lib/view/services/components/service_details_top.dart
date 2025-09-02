// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/helper/contactFeatures.dart';
import 'package:qixer/service/rtl_service.dart';
import 'package:qixer/service/service_details_service.dart';
import 'package:qixer/view/services/components/desc_from_html.dart';
import 'package:qixer/view/services/seller_all_service_page.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/responsive.dart';
import 'package:share_plus/share_plus.dart';

import '../../utils/constant_styles.dart';
import '../service_helper.dart';
import 'package:qixer/generated/app_localizations.dart';

class ServiceDetailsTop extends StatelessWidget {
  const ServiceDetailsTop({
    super.key,
    required this.cc,
  });

  final ConstantColors cc;

  @override
  Widget build(BuildContext context) {
    return Consumer<ServiceDetailsService>(
      builder: (context, provider, child) => Column(
        children: [
          //title author price details
          Container(
            padding: EdgeInsets.symmetric(horizontal: screenPadding),
            decoration: BoxDecoration(
                color: cc.white, borderRadius: BorderRadius.circular(8.0)),
            child: Column(children: [
              ServiceTitleAndUser(
                cc: cc,
                title: provider.serviceDetailsModel.serviceDetails?.title ?? '',
                userImg:
                    provider.serviceDetailsModel.serviceSellerImage?.imgUrl ??
                        '',
                sellerName: provider.serviceDetailsModel.serviceDetails
                        ?.sellerForMobile.businessName ??
                    '',
                sellerId: provider.sellerId,
                videoLink: provider.serviceDetailsModel.videoUrl,
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => SellerAllServicePage(
                  //             sellerId: provider.sellerId,
                  //             sellerName: provider
                  //                     .serviceDetailsModel.serviceSellerName ??
                  //                 '',
                  //           )),
                  // );
                },
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${AppLocalizations.of(context)!.address} : ",
                          style: TextStyle(
                              color: cc.black3,
                              fontSize: 12,
                              fontWeight: FontWeight.w400)),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.65,
                        child: Text(
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            provider.serviceDetailsModel.serviceDetails
                                    ?.sellerForMobile.businessFullAddress ??
                                '',
                            style: TextStyle(
                                color: cc.black3,
                                fontSize: 12,
                                fontWeight: FontWeight.w400)),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${AppLocalizations.of(context)!.category} : ",
                        style: TextStyle(
                          color: cc.black3,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(width: 5), // Adds small spacing between text
                      Flexible(
                        // Ensures text does not overflow
                        child: Text(
                          provider.serviceDetailsModel.serviceDetails?.category
                                  .name ??
                              '',
                          style: TextStyle(
                            color: cc.black3,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                          maxLines: 2, // Restrict to 2 lines if needed
                          overflow: TextOverflow
                              .ellipsis, // Add "..." if text is too long
                        ),
                      ),
                    ],
                  ),

                  // Row(
                  //   children: [
                  //     Text(AppLocalizations.of(context)!.experience,
                  //         style: TextStyle(
                  //             color: cc.black3,
                  //             fontSize: 12,
                  //             fontWeight: FontWeight.w400)),
                  //     Text(
                  //         provider.serviceDetailsModel.serviceDetails
                  //                     ?.experience ==
                  //                 null
                  //             ? ''
                  //             : (RegExp(r'^\d+$').hasMatch(provider
                  //                         .serviceDetailsModel
                  //                         .serviceDetails
                  //                         ?.experience
                  //                         .toString() ??
                  //                     '')
                  //                 ? "${provider.serviceDetailsModel.serviceDetails?.experience} year"
                  //                 : "${provider.serviceDetailsModel.serviceDetails?.experience}"),
                  //         style: TextStyle(
                  //             color: cc.black3,
                  //             fontSize: 12,
                  //             fontWeight: FontWeight.w400)),
                  //   ],
                  // ),

                  // InkWell(
                  //   onTap: () => showBottomSheetWithListView(desc, context),
                  //   child: Row(
                  //     children: [
                  //       // Static label for Open Time
                  //       Text(
                  //         "Open Time : ",
                  //         style: TextStyle(
                  //           color: cc.black3,
                  //           fontSize: 12,
                  //           fontWeight: FontWeight.w400,
                  //         ),
                  //       ),
                  //       RichText(
                  //         text: TextSpan(
                  //           children: [
                  //             TextSpan(
                  //               text: "9:00 AM",
                  //               style: TextStyle(
                  //                 color: cc.primaryColor,
                  //                 fontSize: 12,
                  //                 fontWeight: FontWeight.w400,
                  //               ),
                  //             ),
                  //             TextSpan(
                  //               text: " - ",
                  //               style: TextStyle(
                  //                 color: cc.black3,
                  //                 fontSize: 12,
                  //                 fontWeight: FontWeight.w400,
                  //               ),
                  //             ),
                  //             TextSpan(
                  //               text: "5:00 PM",
                  //               style: TextStyle(
                  //                 color: cc.primaryColor,
                  //                 fontSize: 12,
                  //                 fontWeight: FontWeight.w400,
                  //               ),
                  //             ),
                  //             TextSpan(
                  //               text: " Tap To Know More",
                  //               style: TextStyle(
                  //                 color: Color(0xFF0000EE),
                  //                 fontSize: 12,
                  //                 fontWeight: FontWeight.w500,
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  SizedBox(
                    height: 10,
                  ),

                  provider.serviceDetailsModel.serviceDetails?.serviceArea !=
                              null &&
                          provider.serviceDetailsModel.serviceDetails!
                              .serviceArea!.isNotEmpty
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${AppLocalizations.of(context)!.area} : ",
                              style: TextStyle(
                                color: cc.black3,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(
                                width: 5), // Adds small spacing between text
                            Flexible(
                              child: provider.serviceDetailsModel.serviceDetails
                                              ?.serviceArea !=
                                          null &&
                                      provider
                                          .serviceDetailsModel
                                          .serviceDetails!
                                          .serviceArea!
                                          .isNotEmpty
                                  ? Text(
                                      provider.serviceDetailsModel
                                          .serviceDetails!.serviceArea!
                                          .map((serviceArea) => serviceArea
                                              .serviceArea
                                              .toString())
                                          .join(
                                              ', '), // ✅ Joins all values with ", "
                                      style: TextStyle(
                                        color: cc.black3,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  : Offstage(),
                            )
                          ],
                        )
                      : Offstage(),

                  // Row(
                  //   children: [
                  //     Icon(
                  //       Icons.check_circle,
                  //       color: provider.serviceDetailsModel.serviceDetails
                  //                   ?.status ==
                  //               1
                  //           ? cc.successColor
                  //           : cc.errorColor,
                  //       size: 14,
                  //     ),
                  //     SizedBox(width: 7),
                  //     Text(
                  //         provider.serviceDetailsModel.serviceDetails?.status ==
                  //                 1
                  //             ? AppLocalizations.of(context)!.available
                  //             : AppLocalizations.of(context)!.unAvailable,
                  //         style: TextStyle(
                  //             color: provider.serviceDetailsModel.serviceDetails
                  //                         ?.status ==
                  //                     1
                  //                 ? cc.successColor
                  //                 : cc.errorColor,
                  //             fontSize: 12,
                  //             fontWeight: FontWeight.w500)),
                  //   ],
                  // )
                ],
              ),

              // package price
              // Container(
              //   margin: const EdgeInsets.only(top: 20),
              //   padding:
              //       const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
              //   decoration: BoxDecoration(
              //       border: Border.all(color: cc.borderColor),
              //       borderRadius: BorderRadius.circular(6)),
              //   child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text(
              //           lnProvider.getString('Our Package'),
              //           style: TextStyle(
              //               color: cc.greyFour,
              //               fontSize: 18,
              //               fontWeight: FontWeight.w400),
              //         ),
              //         Consumer<RtlService>(
              //           builder: (context, rtlP, child) => Text(
              //             rtlP.currencyDirection == 'left'
              //                 ? '${rtlP.currency}${provider.serviceDetailsModel.serviceDetails.price}'
              //                 : '${provider.serviceDetailsModel.serviceDetails.price}${rtlP.currency}',
              //             style: TextStyle(
              //                 color: cc.primaryColor,
              //                 fontSize: 23,
              //                 fontWeight: FontWeight.bold),
              //           ),
              //         ),
              //       ]),
              // ),

              // checklist
              const SizedBox(
                height: 30,
              ),
              for (int i = 0;
                  i <
                      (provider.serviceDetailsModel.serviceIncludes?.length ??
                          0);
                  i++)
                ServiceHelper().checkListCommon(
                    context,
                    provider.serviceDetailsModel.serviceIncludes?[i]
                            .includeServiceTitle
                            .toString() ??
                        ''.capitalizeEachWord())
            ]),
          ),
          Container(
            decoration: BoxDecoration(
              color: cc.white,
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      ContactFeatures().launchWhatsapp(
                          context,
                          provider.serviceDetailsModel.serviceDetails
                                  ?.sellerForMobile.businessPhoneNumber ??
                              '',
                          "${AppLocalizations.of(context)!.whatsappContactMsg} *${provider.serviceDetailsModel.serviceDetails?.title.toString()}*.");

                      debugPrint(
                          "${AppLocalizations.of(context)!.whatsappContactMsg} *${provider.serviceDetailsModel.serviceDetails?.title.toString()}*.");
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: cc.black6),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5.0, vertical: 3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Image.network(
                              "https://i.postimg.cc/zGGrQYmw/whatsa-removebg-preview.png",
                              height: 21,
                              width: 21,
                            ),
                            SizedBox(width: 5),
                            Text(
                              AppLocalizations.of(context)!.whatsapp,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      ContactFeatures().launchCalling(
                          context,
                          provider.serviceDetailsModel.serviceDetails
                                  ?.sellerForMobile.businessPhoneNumber ??
                              '');
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade700,
                        border:
                            Border.all(width: 1, color: Colors.blue.shade700),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5.0, vertical: 3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.call,
                              size: 16,
                              color: Colors.white,
                            ),
                            SizedBox(width: 5),
                            Text(
                              AppLocalizations.of(context)!.callNow,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Share.share(
                        "${AppLocalizations.of(context)!.shareMessage} https://sashaktnirman.com/",
                        subject: AppLocalizations.of(context)!.shareSubject,
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: cc.black6),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5.0, vertical: 3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.share,
                              size: 16,
                              color: Colors.black,
                            ),
                            SizedBox(width: 5),
                            Text(
                              AppLocalizations.of(context)!.shareNow,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Container(
          //   padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 13),
          //   decoration: BoxDecoration(
          //     color: cc.white,
          //     border: Border(
          //       bottom: BorderSide(width: 1, color: cc.borderColor),
          //       top: BorderSide(width: 1, color: cc.borderColor),
          //     ),
          //   ),
          //   child: Row(children: [
          //     //orders completed ========>
          //     Expanded(
          //       child: Row(
          //         children: [
          //           Text(
          //             provider.serviceDetailsModel.sellerCompleteOrder
          //                 .toString()
          //                 .capitalizeEachWord(),
          //             style: TextStyle(
          //                 color: cc.successColor,
          //                 fontSize: 16,
          //                 fontWeight: FontWeight.bold),
          //           ),
          //           const SizedBox(width: 8),
          //           SizedBox(
          //             // width: screenWidth / 3.8,
          //             child: AutoSizeText(
          //               lnProvider.getString('Orders completed'),
          //               maxLines: 2,
          //               style: TextStyle(
          //                   color: cc.greyFour,
          //                   fontSize: 15,
          //                   fontWeight: FontWeight.w400),
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //     //vertical border
          //     Container(
          //       height: 28,
          //       width: 1,
          //       margin: const EdgeInsets.only(left: 10, right: 15),
          //       color: cc.borderColor,
          //     ),
          //     //Sellers ratings ========>
          //     Row(
          //       children: [
          //         Text(
          //           provider.serviceDetailsModel.sellerRating.toString(),
          //           style: TextStyle(
          //               color: cc.primaryColor,
          //               fontSize: 16,
          //               fontWeight: FontWeight.bold),
          //         ),
          //         const SizedBox(width: 8),
          //         AutoSizeText(
          //           lnProvider.getString('Seller Ratings'),
          //           maxLines: 1,
          //           style: TextStyle(
          //               color: cc.greyFour,
          //               fontSize: 15,
          //               fontWeight: FontWeight.w400),
          //         ),
          //       ],
          //     ),
          //   ]),
          // ),
        ],
      ),
    );
  }

  void showBottomSheetWithListView(var desc, BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          height: MediaQuery.of(context).size.height * 0.55,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
              )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 5,
                width: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade300),
              ),
              const SizedBox(height: 10),
              Center(
                child: Text(
                  textAlign: TextAlign.center,
                  "Opening Days and Hours",
                  style: TextStyle(
                    fontSize: 16,
                    color: cc.black3,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DescInHtml(
                  cc: cc,
                  desc: desc,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ServiceTitleAndUser extends StatelessWidget {
  const ServiceTitleAndUser(
      {super.key,
      required this.cc,
      required this.title,
      this.userImg,
      required this.sellerName,
      required this.videoLink,
      required this.sellerId,
      required this.onTap});
  final ConstantColors cc;
  final String title;
  final userImg;
  final String sellerName;
  final videoLink;
  final sellerId;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          sellerName.toString().capitalizeEachWord(),
          // title.capitalizeEachWord(),
          style: TextStyle(
            color: cc.greyFour,
            fontSize: 16,
            height: 1.4,
            fontWeight: FontWeight.bold,
          ),
        ),
        //profile image and name
        InkWell(
          onTap: () {
            onTap.call();
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User image section
              // Uncomment and use the desired user image logic
              // userImg != null
              //     ? ClipRRect(
              //         borderRadius: BorderRadius.circular(100),
              //         child: CachedNetworkImage(
              //           imageUrl: userImg,
              //           placeholder: (context, url) {
              //             return Image.asset('assets/images/loading_image.png');
              //           },
              //           height: 40,
              //           width: 40,
              //           fit: BoxFit.cover,
              //         ),
              //       )
              //     : ClipRRect(
              //         borderRadius: BorderRadius.circular(8),
              //         child: Image.asset(
              //           'assets/images/avatar.png',
              //           height: 40,
              //           width: 40,
              //           fit: BoxFit.cover,
              //         ),
              //       ),

              // Expanded seller name
              Expanded(
                child: Text(
                  title.capitalizeEachWord(),
                  // sellerName.toString().capitalizeEachWord(),
                  overflow: TextOverflow
                      .ellipsis, // Prevent overflow and add ellipsis
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                ),
              ),
              const SizedBox(
                width: 8,
              ),

              // Rating section
              // Row(
              //   children: [
              //     Container(
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(3),
              //         color: Colors.green.shade800,
              //       ),
              //       child: Padding(
              //         padding: const EdgeInsets.all(2.0),
              //         child: Icon(
              //           Icons.star,
              //           color: cc.white,
              //           size: 12,
              //         ),
              //       ),
              //     ),
              //     const SizedBox(
              //       width: 5,
              //     ),
              //     Text(
              //       "3.5",
              //       style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ],
    );
  }
}
