import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:qixer/service/service_details_service.dart';
import 'package:qixer/view/services/components/desc_from_html.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:qixer/view/utils/responsive.dart';

import '../seller_all_service_page.dart';

class AboutSellerTab extends StatelessWidget {
  const AboutSellerTab({super.key, required this.provider});
  final ServiceDetailsService provider;
  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        //profile image, name and completed orders
        InkWell(
          // onTap: () {
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => SellerAllServicePage(
          //               sellerId: provider.sellerId,
          //               sellerName: provider.serviceDetailsModel.serviceDetails
          //                       ?.seller.name ??
          //                   '',
          //             )),
          //   );
          // },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: CachedNetworkImage(
                  imageUrl:
                      provider.serviceDetailsModel.serviceSellerImage?.imgUrl ??
                          userPlaceHolderUrl,
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
              provider.serviceDetailsModel.serviceSellerName != null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          provider.serviceDetailsModel.serviceSellerName
                              .toString()
                              .capitalize(),
                          style: TextStyle(
                              color: cc.greyFour,
                              fontSize: 17,
                              fontWeight: FontWeight.w600),
                        ),
                        // const SizedBox(
                        //   height: 6,
                        // ),
                        // Row(
                        //   children: [
                        //     Text(
                        //       lnProvider.getString('Order Completed'),
                        //       style: TextStyle(
                        //         color: cc.primaryColor,
                        //         fontSize: 12,
                        //       ),
                        //     ),
                        //     const SizedBox(
                        //       width: 5,
                        //     ),
                        //     Text(
                        //       '(${provider.serviceDetailsModel.sellerCompleteOrder.toString()})',
                        //       style: TextStyle(
                        //         color: cc.greyParagraph,
                        //         fontSize: 12,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                      ],
                    )
                  : Offstage(),
            ],
          ),
        ),
        const SizedBox(
          height: 30,
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
        //             child: ServiceHelper().serviceDetails(
        //                 'From', provider.serviceDetailsModel.sellerFrom ?? ''),
        //           ),
        //           Expanded(
        //               child: ServiceHelper().serviceDetails(
        //                   'Order Completion Rate',
        //                   '${provider.serviceDetailsModel.orderCompletionRate}%'))
        //         ],
        //       ),
        //       const SizedBox(
        //         height: 30,
        //       ),
        //       Row(
        //         children: [
        //           Expanded(
        //             child: ServiceHelper().serviceDetails(
        //                 'Seller Since',
        //                 getYear(
        //                     provider.serviceDetailsModel.sellerSince.createdAt)),
        //           ),
        //           Expanded(
        //               child: ServiceHelper().serviceDetails(
        //                   'Order Completed',
        //                   provider.serviceDetailsModel.sellerCompleteOrder
        //                       .toString()))
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
        provider.serviceDetailsModel.serviceDetails?.seller.about != null
            ? DescInHtml(
                cc: cc,
                desc: provider.serviceDetailsModel.serviceDetails?.seller.about
                        .toString()
                        .capitalize() ??
                    '',
              )
            : Offstage(),
      ]),
    );
  }
}
