// ignore_for_file: avoid_print

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/app_string_service.dart';
import 'package:qixer/service/booking_services/book_service.dart';
import 'package:qixer/service/service_details_service.dart';
import 'package:qixer/view/booking/service_personalization_page.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:qixer/view/utils/responsive.dart';
import 'package:share_plus/share_plus.dart';
import '../../../service/booking_services/personalization_service.dart';
import '../../utils/common_helper.dart';
import '../../utils/constant_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ServiceCard extends StatelessWidget {
  const ServiceCard(
      {super.key,
      required this.cc,
      required this.imageLink,
      required this.title,
      required this.sellerName,
      required this.buttonText,
      required this.rating,
      required this.price,
      required this.width,
      required this.marginRight,
      required this.pressed,
      required this.isSaved,
      required this.serviceId,
      required this.sellerId,
      this.cardFrom,
      this.address,
      this.experience,
      this.status,
      this.onTapWhatsapp,
      this.onTapCall});

  final ConstantColors cc;
  final serviceId;
  final imageLink;
  final title;
  final sellerName;
  final buttonText;
  final rating;
  final price;
  final width;
  final marginRight;
  final VoidCallback pressed;
  final bool isSaved;
  final sellerId;
  final String? cardFrom;
  final address;
  final experience;
  final status;
  final VoidCallback? onTapWhatsapp;
  final VoidCallback? onTapCall;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStringService>(
      builder: (context, asProvider, child) => Container(
        alignment: Alignment.center,
        width: width,
        decoration: BoxDecoration(
            color: cardFrom == 'Home' ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(9),
            boxShadow: [
              BoxShadow(
                color: cardFrom == 'Home'
                    ? Colors.grey.shade400
                    : Colors.transparent,
                offset: Offset(0, 2),
                blurRadius: 3,
              )
            ]),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ServiceCardContents(
                cc: cc,
                imageLink: imageLink,
                title: title,
                sellerName: sellerName,
                rating: rating,
                price: price,
                asProvider: asProvider,
                address: address,
                experience: experience,
                status: status,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // screenWidth < fourinchScreenWidth
                        //     ? Container()
                        //     : AutoSizeText(
                        //         '${asProvider.getString('Starts from')}:',
                        //         textAlign: TextAlign.start,
                        //         maxLines: 1,
                        //         overflow: TextOverflow.ellipsis,
                        //         style: TextStyle(
                        //           color: cc.greyFour.withOpacity(.6),
                        //           fontSize: screenWidth < fourinchScreenWidth
                        //               ? 11
                        //               : 14,
                        //           fontWeight: FontWeight.w400,
                        //         ),
                        //       ),
                        // const SizedBox(
                        //   width: 6,
                        // ),
                        InkWell(
                          onTap: onTapWhatsapp,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: CachedNetworkImage(
                              height: 30,
                              width: 30,
                              fit: BoxFit.cover,
                              imageUrl:
                                  "https://i.postimg.cc/zGGrQYmw/whatsa-removebg-preview.png",
                              errorWidget: (context, url, error) =>
                                  Image.network(
                                      fit: BoxFit.cover,
                                      height: 30,
                                      width: 30,
                                      placeHolderUrl),
                            ),
                          ),
                        ),

                        InkWell(
                          onTap: onTapCall,
                          child: Icon(
                            Icons.call,
                            color: cc.black3,
                            size: 22,
                          ),
                        ),
                        // Consumer<RtlService>(
                        //   builder: (context, rtlP, child) => Expanded(
                        //     child: AutoSizeText(
                        //       rtlP.currencyDirection == 'left'
                        //           ? '${rtlP.currency}$price'
                        //           : '$price${rtlP.currency}',
                        //       textAlign: TextAlign.start,
                        //       maxLines: 1,
                        //       overflow: TextOverflow.ellipsis,
                        //       style: TextStyle(
                        //         color: cc.greyFour,
                        //         fontSize: 19,
                        //         fontWeight: FontWeight.bold,
                        //       ),
                        //     ),
                        //   ),
                        // ),

                        InkWell(
                          onTap: () {
                            Share.share(
                                "$title\n\n${AppLocalizations.of(context)!.shareMessage}",
                                subject:
                                    AppLocalizations.of(context)!.shareSubject);
                          },
                          child: Icon(
                            Icons.share,
                            color: cc.black3,
                            size: 22,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: pressed,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: Container(
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: cc.borderColor),
                          borderRadius: BorderRadius.circular(5)),
                      child: SvgPicture.asset(
                        isSaved
                            ? 'assets/svg/saved-fill-icon.svg'
                            : 'assets/svg/saved-icon.svg',
                        color: isSaved ? cc.primaryColor : cc.greyFour,
                        height: screenWidth < fourinchScreenWidth ? 19 : 21,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 11,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          foregroundColor: cc.white,
                          backgroundColor: cc.primaryColor,
                          elevation: 0),
                      onPressed: () {
                        //set some data of the service which is clicked, these datas may be needed

                        // Provider.of<BookService>(context, listen: false)
                        //     .setData(serviceId, title, price, sellerId,
                        //         image: imageLink);
                        // //==========>
                        // Provider.of<PersonalizationService>(context,
                        //         listen: false)
                        //     .setDefaultPrice(
                        //         Provider.of<BookService>(context, listen: false)
                        //             .totalPrice);
                        // //fetch service extra
                        // Provider.of<PersonalizationService>(context,
                        //         listen: false)
                        //     .fetchServiceExtra(serviceId, context);
                        // Navigator.push(
                        //     context,
                        //     PageTransition(
                        //         type: PageTransitionType.rightToLeft,
                        //         child: const ServicePersonalizationPage()));

                        showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth:
                                      400, // Set maximum width for the dialog
                                  maxHeight:
                                      300, // Set maximum height for the dialog
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(20.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Thank You',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Divider(color: Colors.grey.shade300),
                                      Text(
                                        textAlign: TextAlign.center,
                                        "Thank you for your enquiry with us, we will call you back soon.",
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Image.network(
                                          height: 85,
                                          width: 85,
                                          "https://i.postimg.cc/fbKmxjYg/pngwing-com-1.png"),
                                      const SizedBox(height: 8),
                                      // Text(
                                      //   textAlign:
                                      //       TextAlign.center,
                                      //     "Tap OK to chat, or tap Cancel to dismiss.",
                                      //   style: TextStyle(
                                      //       fontSize: 14,
                                      //       fontWeight:
                                      //           FontWeight
                                      //               .w500),
                                      // ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          // ElevatedButton(
                                          //   onPressed: () {
                                          //     Navigator.pop(
                                          //         context);
                                          //   },
                                          //   style:
                                          //       ElevatedButton
                                          //           .styleFrom(
                                          //     backgroundColor:
                                          //         Colors
                                          //             .redAccent,
                                          //   ),
                                          //   child: const Text(
                                          //       'Cancel'),
                                          // ),
                                          ElevatedButton(
                                            onPressed: () {
                                              Provider.of<ServiceDetailsService>(
                                                      context,
                                                      listen: false)
                                                  .fetchServiceDetails(
                                                      serviceId.toString());
                                              Navigator.pop(context);
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Colors.blueAccent,
                                            ),
                                            child: Text(
                                              AppLocalizations.of(context)!.ok,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Text(
                        AppLocalizations.of(context)!.bookNow,
                        style: TextStyle(
                            fontSize:
                                screenWidth < fourinchScreenWidth ? 9 : 13,
                            fontWeight: FontWeight.normal),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ServiceCardContents extends StatelessWidget {
  const ServiceCardContents(
      {super.key,
      required this.cc,
      required this.imageLink,
      required this.title,
      required this.sellerName,
      required this.rating,
      required this.price,
      required this.asProvider,
      this.address,
      this.experience,
      this.status});

  final ConstantColors cc;
  final imageLink;
  final title;
  final sellerName;
  final rating;
  final price;
  final asProvider;
  final address;
  final experience;
  final status;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            //service image
            CommonHelper().profileImage(imageLink, 75, 78),

            // rating != 0.0
            //     ? Positioned(
            //         left: 8,
            //         child: Container(
            //           decoration: BoxDecoration(
            //               border: Border.all(color: Colors.white, width: 2),
            //               color: const Color(0xffFFC300),
            //               borderRadius: BorderRadius.circular(4)),
            //           padding: const EdgeInsets.symmetric(
            //               horizontal: 6, vertical: 4),
            //           child: Row(children: [
            //             Icon(
            //               Icons.star_border,
            //               color: cc.greyFour,
            //               size: 14,
            //             ),
            //             const SizedBox(
            //               width: 3,
            //             ),
            //             Text(
            //               rating.toString(),
            //               style: TextStyle(
            //                   color: cc.greyFour,
            //                   fontWeight: FontWeight.w600,
            //                   fontSize: 13),
            //             )
            //           ]),
            //         ))
            //     : Container(),
          ],
        ),
        const SizedBox(
          width: 13,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start, // Ensures alignment to the start
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Service Name
              Text(
                sellerName != null
                    ? sellerName.toString().capitalizeEachWord() ?? ''
                    : 'Unknown Seller',
                textAlign: TextAlign.start,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: cc.greyFour,
                  fontSize: 16, // Slightly larger for emphasis
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),

              // Title Row (with Icon)
              Row(
                crossAxisAlignment:
                    CrossAxisAlignment.center, // Align text & icon properly
                children: [
                  Icon(
                    Icons.location_history_outlined,
                    size: 14, // Slightly increased for better visibility
                    color: cc.greyFour.withOpacity(.6),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    // Ensures text does not overflow
                    child: Text(
                      title.toString().capitalizeEachWord(),
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        color: cc.greyFour,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),

              // Address (If available)
              if (address != null &&
                  address.isNotEmpty &&
                  address != 'null') ...[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 14,
                      color: cc.greyFour.withOpacity(.6),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        address,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          color: cc.greyFour,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
              ],

              // Experience (If available)
              if (experience != null &&
                  experience.isNotEmpty &&
                  experience != 'null') ...[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.real_estate_agent_outlined,
                      size: 14,
                      color: cc.greyFour.withOpacity(.6),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        experience,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          color: cc.greyFour,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
              ],

              // Status (If available)
              // if (status != null && status.isNotEmpty && status != 'null') ...[
              //   Row(
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: [
              //       Icon(
              //         Icons.event_available,
              //         size: 14,
              //         color: cc.greyFour.withOpacity(.6),
              //       ),
              //       const SizedBox(width: 6),
              //       Text(
              //         status == '1' ? 'Available' : 'Unavailable',
              //         textAlign: TextAlign.start,
              //         maxLines: 1,
              //         overflow: TextOverflow.ellipsis,
              //         style: TextStyle(
              //           color: status == "1" ? cc.successColor : cc.errorColor,
              //           fontSize: 12,
              //           fontWeight: FontWeight.w400,
              //         ),
              //       ),
              //     ],
              //   ),
              // ],
            ],
          ),
        ),
      ],
    );
  }
}

class ServiceCard2 extends StatelessWidget {
  const ServiceCard2(
      {super.key,
      required this.cc,
      required this.imageLink,
      required this.title,
      required this.sellerName,
      required this.buttonText,
      required this.rating,
      required this.price,
      required this.width,
      required this.marginRight,
      required this.pressed,
      required this.isSaved,
      required this.serviceId,
      required this.sellerId,
      this.cardFrom,
      this.address,
      this.experience,
      this.status,
      this.onTapWhatsapp,
      this.onTapCall});

  final ConstantColors cc;
  final serviceId;
  final imageLink;
  final title;
  final sellerName;
  final buttonText;
  final rating;
  final price;
  final width;
  final marginRight;
  final VoidCallback pressed;
  final bool isSaved;
  final sellerId;
  final String? cardFrom;
  final address;
  final experience;
  final status;
  final VoidCallback? onTapWhatsapp;
  final VoidCallback? onTapCall;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStringService>(
      builder: (context, asProvider, child) => Container(
        alignment: Alignment.center,
        width: width,
        decoration: BoxDecoration(
            color: cardFrom == 'Home' ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(9),
            boxShadow: [
              BoxShadow(
                color: cardFrom == 'Home'
                    ? Colors.grey.shade400
                    : Colors.transparent,
                offset: Offset(0, 2),
                blurRadius: 3,
              )
            ]),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ServiceCardContents2(
                cc: cc,
                imageLink: imageLink,
                title: title,
                sellerName: sellerName,
                rating: rating,
                price: price,
                asProvider: asProvider,
                address: address,
                experience: experience,
                status: status,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // screenWidth < fourinchScreenWidth
                        //     ? Container()
                        //     : AutoSizeText(
                        //         '${asProvider.getString('Starts from')}:',
                        //         textAlign: TextAlign.start,
                        //         maxLines: 1,
                        //         overflow: TextOverflow.ellipsis,
                        //         style: TextStyle(
                        //           color: cc.greyFour.withOpacity(.6),
                        //           fontSize: screenWidth < fourinchScreenWidth
                        //               ? 11
                        //               : 14,
                        //           fontWeight: FontWeight.w400,
                        //         ),
                        //       ),
                        // const SizedBox(
                        //   width: 6,
                        // ),
                        InkWell(
                          onTap: onTapWhatsapp,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: CachedNetworkImage(
                              height: 30,
                              width: 30,
                              fit: BoxFit.cover,
                              imageUrl:
                                  "https://i.postimg.cc/zGGrQYmw/whatsa-removebg-preview.png",
                              errorWidget: (context, url, error) =>
                                  Image.network(
                                      fit: BoxFit.cover,
                                      height: 30,
                                      width: 30,
                                      placeHolderUrl),
                            ),
                          ),
                        ),

                        InkWell(
                          onTap: onTapCall,
                          child: Icon(
                            Icons.call,
                            color: cc.black3,
                            size: 22,
                          ),
                        ),
                        // Consumer<RtlService>(
                        //   builder: (context, rtlP, child) => Expanded(
                        //     child: AutoSizeText(
                        //       rtlP.currencyDirection == 'left'
                        //           ? '${rtlP.currency}$price'
                        //           : '$price${rtlP.currency}',
                        //       textAlign: TextAlign.start,
                        //       maxLines: 1,
                        //       overflow: TextOverflow.ellipsis,
                        //       style: TextStyle(
                        //         color: cc.greyFour,
                        //         fontSize: 19,
                        //         fontWeight: FontWeight.bold,
                        //       ),
                        //     ),
                        //   ),
                        // ),

                        InkWell(
                          onTap: () {
                            Share.share(
                                "$title\n\n${AppLocalizations.of(context)!.shareMessage}",
                                subject:
                                    AppLocalizations.of(context)!.shareSubject);
                          },
                          child: Icon(
                            Icons.share,
                            color: cc.black3,
                            size: 22,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: pressed,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: Container(
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: cc.borderColor),
                          borderRadius: BorderRadius.circular(5)),
                      child: SvgPicture.asset(
                        isSaved
                            ? 'assets/svg/saved-fill-icon.svg'
                            : 'assets/svg/saved-icon.svg',
                        color: isSaved ? cc.primaryColor : cc.greyFour,
                        height: screenWidth < fourinchScreenWidth ? 19 : 21,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 11,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          foregroundColor: cc.white,
                          backgroundColor: cc.primaryColor,
                          elevation: 0),
                      onPressed: () {
                        //set some data of the service which is clicked, these datas may be needed

                        // Provider.of<BookService>(context, listen: false)
                        //     .setData(serviceId, title, price, sellerId,
                        //         image: imageLink);
                        // //==========>
                        // Provider.of<PersonalizationService>(context,
                        //         listen: false)
                        //     .setDefaultPrice(
                        //         Provider.of<BookService>(context, listen: false)
                        //             .totalPrice);
                        // //fetch service extra
                        // Provider.of<PersonalizationService>(context,
                        //         listen: false)
                        //     .fetchServiceExtra(serviceId, context);
                        // Navigator.push(
                        //     context,
                        //     PageTransition(
                        //         type: PageTransitionType.rightToLeft,
                        //         child: const ServicePersonalizationPage()));

                        showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth:
                                      400, // Set maximum width for the dialog
                                  maxHeight:
                                      300, // Set maximum height for the dialog
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(20.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!.thankYou,
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Divider(color: Colors.grey.shade300),
                                      Text(
                                        textAlign: TextAlign.center,
                                        AppLocalizations.of(context)!
                                            .thankYouEnquiryText,
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Image.network(
                                          height: 85,
                                          width: 85,
                                          "https://i.postimg.cc/fbKmxjYg/pngwing-com-1.png"),
                                      const SizedBox(height: 8),
                                      // Text(
                                      //   textAlign:
                                      //       TextAlign.center,
                                      //     "Tap OK to chat, or tap Cancel to dismiss.",
                                      //   style: TextStyle(
                                      //       fontSize: 14,
                                      //       fontWeight:
                                      //           FontWeight
                                      //               .w500),
                                      // ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          // ElevatedButton(
                                          //   onPressed: () {
                                          //     Navigator.pop(
                                          //         context);
                                          //   },
                                          //   style:
                                          //       ElevatedButton
                                          //           .styleFrom(
                                          //     backgroundColor:
                                          //         Colors
                                          //             .redAccent,
                                          //   ),
                                          //   child: const Text(
                                          //       'Cancel'),
                                          // ),
                                          ElevatedButton(
                                            onPressed: () {
                                              Provider.of<ServiceDetailsService>(
                                                      context,
                                                      listen: false)
                                                  .fetchServiceDetails(
                                                      serviceId.toString());
                                              Navigator.pop(context);
                                              // Add your additional action here
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Colors.blueAccent,
                                            ),
                                            child: Text(
                                                AppLocalizations.of(context)!
                                                    .ok),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Text(
                        AppLocalizations.of(context)!.bookNow,
                        style: TextStyle(
                            fontSize:
                                screenWidth < fourinchScreenWidth ? 9 : 13,
                            fontWeight: FontWeight.normal),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ServiceCardContents2 extends StatelessWidget {
  const ServiceCardContents2(
      {super.key,
      required this.cc,
      required this.imageLink,
      required this.title,
      required this.sellerName,
      required this.rating,
      required this.price,
      required this.asProvider,
      this.address,
      this.experience,
      this.status});

  final ConstantColors cc;
  final imageLink;
  final title;
  final sellerName;
  final rating;
  final price;
  final asProvider;
  final address;
  final experience;
  final status;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CommonHelper().profileImage(imageLink, 75, 78),
        // Stack(
        //   clipBehavior: Clip.none,
        //   children: [
        //     //service image
        //     // CommonHelper().profileImage(imageLink, 75, 78),
        //
        //     // rating != 0.0
        //     //     ? Positioned(
        //     //         left: 8,
        //     //         child: Container(
        //     //           decoration: BoxDecoration(
        //     //               border: Border.all(color: Colors.white, width: 2),
        //     //               color: const Color(0xffFFC300),
        //     //               borderRadius: BorderRadius.circular(4)),
        //     //           padding: const EdgeInsets.symmetric(
        //     //               horizontal: 6, vertical: 4),
        //     //           child: Row(children: [
        //     //             Icon(
        //     //               Icons.star_border,
        //     //               color: cc.greyFour,
        //     //               size: 14,
        //     //             ),
        //     //             const SizedBox(
        //     //               width: 3,
        //     //             ),
        //     //             Text(
        //     //               rating.toString(),
        //     //               style: TextStyle(
        //     //                   color: cc.greyFour,
        //     //                   fontWeight: FontWeight.w600,
        //     //                   fontSize: 13),
        //     //             )
        //     //           ]),
        //     //         ))
        //     //     : Container(),
        //   ],
        // ),
        const SizedBox(
          width: 13,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start, // Ensures alignment to the start
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Service Name
              Text(
                sellerName.toString().capitalizeEachWord(),
                textAlign: TextAlign.start,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: cc.greyFour,
                  fontSize: 16, // Slightly larger for emphasis
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),

              // Title Row (with Icon)
              Row(
                crossAxisAlignment:
                    CrossAxisAlignment.center, // Align text & icon properly
                children: [
                  Icon(
                    Icons.location_history_outlined,
                    size: 14, // Slightly increased for better visibility
                    color: cc.greyFour.withOpacity(.6),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    // Ensures text does not overflow
                    child: Text(
                      title.toString().capitalizeEachWord(),
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        color: cc.greyFour,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),

              // Address (If available)
              if (address != null &&
                  address.isNotEmpty &&
                  address != 'null') ...[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 14,
                      color: cc.greyFour.withOpacity(.6),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        address,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          color: cc.greyFour,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
              ],

              // Experience (If available)
              if (experience != null &&
                  experience.isNotEmpty &&
                  experience != 'null') ...[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.real_estate_agent_outlined,
                      size: 14,
                      color: cc.greyFour.withOpacity(.6),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        experience,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          color: cc.greyFour,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
              ],

              // Status (If available)
              // if (status != null && status.isNotEmpty && status != 'null') ...[
              //   Row(
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: [
              //       Icon(
              //         Icons.event_available,
              //         size: 14,
              //         color: cc.greyFour.withOpacity(.6),
              //       ),
              //       const SizedBox(width: 6),
              //       Text(
              //         status == '1' ? 'Available' : 'Unavailable',
              //         textAlign: TextAlign.start,
              //         maxLines: 1,
              //         overflow: TextOverflow.ellipsis,
              //         style: TextStyle(
              //           color: status == "1" ? cc.successColor : cc.errorColor,
              //           fontSize: 12,
              //           fontWeight: FontWeight.w400,
              //         ),
              //       ),
              //     ],
              //   ),
              // ],
            ],
          ),
        ),
      ],
    );
  }
}
