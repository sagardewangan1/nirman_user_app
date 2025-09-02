// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:qixer/service/service_details_service.dart';
import 'package:qixer/view/services/components/desc_from_html.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/generated/app_localizations.dart';

class OverviewTab extends StatelessWidget {
  const OverviewTab({super.key, this.provider});

  final ServiceDetailsService? provider;
  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              AppLocalizations.of(context)!.keyFeature,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
            DescInHtml(
              cc: cc,
              desc: provider?.serviceDetailsModel.serviceDetails
                  ?.sellerForMobile.businessDescription,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              AppLocalizations.of(context)!.officeAddress,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Text(
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.visible,
                  provider?.serviceDetailsModel.serviceDetails?.sellerForMobile
                          .businessFullAddress ??
                      "",
                  style: TextStyle(
                      color: cc.black3,
                      fontSize: 12,
                      fontWeight: FontWeight.w400)),
            ),
            // Text(
            //   "Availability",
            //   style: TextStyle(
            //       color: Colors.black,
            //       fontSize: 14,
            //       fontWeight: FontWeight.w500),
            // ),
            // for (int i = 0;
            //     i < provider.serviceAllDetails.serviceBenifits.length;
            //     i++)
            //   ServiceHelper().checkListCommon(context,
            //       provider.serviceAllDetails.serviceBenifits[i].benifits),
            //
            // //FAQ ===============>
            // (provider.serviceAllDetails.serviceDetails.serviceFaq).isNotEmpty
            //     ? Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           const SizedBox(
            //             height: 15,
            //           ),
            //           AutoSizeText(
            //             'FAQ:',
            //             maxLines: 1,
            //             style: TextStyle(
            //                 color: cc.greyFour,
            //                 fontSize: 19,
            //                 fontWeight: FontWeight.bold),
            //           ),
            //           //checklist
            //           const SizedBox(
            //             height: 15,
            //           ),
            //
            //           // for (int i = 0;
            //           //     i <
            //           //         provider.serviceAllDetails.serviceDetails
            //           //             .serviceFaq.length;
            //           //     i++)
            //             // ExpandablePanel(
            //             //   controller:
            //             //       ExpandableController(initialExpanded: false),
            //             //   theme: const ExpandableThemeData(hasIcon: false),
            //             //   header: Container(
            //             //     padding: const EdgeInsets.only(bottom: 2),
            //             //     child: Row(
            //             //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             //       children: [
            //             //         Flexible(
            //             //           child: Text(
            //             //             provider.serviceAllDetails.serviceDetails
            //             //                     .serviceFaq[i].title ??
            //             //                 '',
            //             //             maxLines: 1,
            //             //             overflow: TextOverflow.ellipsis,
            //             //             style: TextStyle(
            //             //                 color: cc.greyFour,
            //             //                 fontSize: 16,
            //             //                 fontWeight: FontWeight.w600),
            //             //           ),
            //             //         ),
            //             //         Container(
            //             //           margin: const EdgeInsets.only(left: 10),
            //             //           child: Icon(
            //             //             Icons.keyboard_arrow_down_rounded,
            //             //             color: cc.greyParagraph,
            //             //           ),
            //             //         )
            //             //       ],
            //             //     ),
            //             //   ),
            //             //   collapsed: Text(''),
            //             //   expanded: Container(
            //             //       //Dropdown
            //             //       margin: const EdgeInsets.only(bottom: 20, top: 8),
            //             //       child: Column(
            //             //         children: [
            //             //           Text(provider.serviceAllDetails.serviceDetails
            //             //                   .serviceFaq[i].description ??
            //             //               '')
            //             //         ],
            //             //       )),
            //             // ),
            //         ],
            //       )
            //     : Container()
          ]),
    );
  }
}
