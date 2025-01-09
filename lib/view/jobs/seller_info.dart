import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/constant_styles.dart';
import 'package:qixer/view/utils/responsive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../service/common_service.dart';
import '../live_chat/chat_message_page.dart';
import '../services/service_helper.dart';
import '../utils/common_helper.dart';
import '../utils/others_helper.dart';

class SellerInfo extends StatelessWidget {
  var imgUrl;
  dynamic sellerId;
  String sellerName;
  var sellerCompleteOrder;
  var createdAt;
  var orderCompletionRate;
  var sellerCountry;
  var sellerCity;
  var completeOrder;

  SellerInfo({
    this.sellerId,
    required this.sellerName,
    this.completeOrder,
    this.sellerCompleteOrder,
    this.createdAt,
    this.orderCompletionRate,
    this.sellerCountry,
    this.sellerCity,
    this.imgUrl,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();
    return SizedBox(
        width: MediaQuery.of(context).size.width - 60,
        height: 350,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //profile image, name and completed orders
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: CachedNetworkImage(
                      imageUrl: imgUrl ?? userPlaceHolderUrl,
                      placeholder: (context, url) {
                        return Image.asset('assets/images/loading_image.png');
                      },
                      height: 60,
                      width: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        sellerName,
                        style: TextStyle(
                            color: cc.greyFour,
                            fontSize: 17,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Row(
                        children: [
                          Text(
                            lnProvider.getString('Order Completed'),
                            style: TextStyle(
                              color: cc.primaryColor,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            '(${completeOrder.toString()})',
                            style: TextStyle(
                              color: cc.greyParagraph,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      border: Border.all(color: cc.borderColor, width: 1),
                      borderRadius: BorderRadius.circular(6)),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: ServiceHelper().serviceDetails(
                                  'Country', sellerCountry ?? ''),
                            ),
                            Expanded(
                              child: ServiceHelper()
                                  .serviceDetails('City', sellerCity ?? ''),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: ServiceHelper().serviceDetails(
                                  'Seller Since', getYear(createdAt)),
                            ),
                            Expanded(
                                child: ServiceHelper().serviceDetails(
                                    'Order Completion Rate',
                                    '$orderCompletionRate%'))
                          ],
                        ),

                        // Container(
                        //   padding: const EdgeInsets.all(20),
                        //   decoration: BoxDecoration(
                        //       border: Border.all(color: cc.borderColor, width: 1),
                        //       borderRadius: BorderRadius.circular(6)),
                        //   child: Column(
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: [
                        //       Row(
                        //         children: [
                        //           Expanded(
                        //             child:
                        //                 ServiceHelper().serviceDetails('From', sellerFrom ?? ''),
                        //           ),
                        //           Expanded(
                        //               child: ServiceHelper().serviceDetails(
                        //                   'Order Completion Rate', '$completionRate%'))
                        //         ],
                        //       ),
                        //       const SizedBox(
                        //         height: 30,
                        //       ),
                        //       Row(
                        //         children: [
                        //           Expanded(
                        //             child: ServiceHelper()
                        //                 .serviceDetails('Seller Since', getYear(createdAt)),
                        //           ),
                        //           Expanded(
                        //               child: ServiceHelper().serviceDetails(
                        //                   'Order Completed', completeOrder.toString()))
                        //         ],
                        //       ),
                        //       // const SizedBox(
                        //       //   height: 30,
                        //       // ),
                        //       // Text(
                        //       //   'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less.',
                        //       //   style: TextStyle(
                        //       //     color: cc.greyParagraph,
                        //       //     fontSize: 14,
                        //       //     height: 1.4,
                        //       //   ),
                        //       // ),
                        //     ],
                        //   ),
                        // ),
                      ])),
              sizedBoxCustom(12),
              CommonHelper().buttonOrange("Chat", () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                var currentUserId = prefs.getInt('userId')!;

                //======>
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => ChatMessagePage(
                      receiverId: sellerId,
                      currentUserId: currentUserId,
                      userName: sellerName,
                    ),
                  ),
                );
              })
            ]));
  }
}
