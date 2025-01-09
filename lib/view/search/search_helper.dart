import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:qixer/view/home/components/marker_window_painter.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:qixer/view/utils/responsive.dart';

import '../utils/common_helper.dart';
import '../utils/constant_styles.dart';

class SearchHelper {
  showServiceWindow(BuildContext context, title, price, rating, sellerName,
      imageUrl, serviceId) {
    ConstantColors cc = ConstantColors();
    showDialog(
      context: context,
      anchorPoint: Offset(screenHeight / 2, screenWidth / 2),
      barrierColor: Colors.transparent,
      builder: (context) => Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            bottom: (screenHeight / 2) + 50,
            child: Material(
              child: CustomPaint(
                painter: MarkerWindowPainter(),
                child: Container(
                  // height: 334,
                  width: 260,
                  constraints: const BoxConstraints(maxHeight: 334),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CachedNetworkImage(
                          height: 128,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          imageUrl:
                              "https://i.postimg.cc/m2nwwwMV/325412168-511378201059727-7233546358729569567-n.png",
                          placeholder: (context, url) {
                            return Image.asset(
                                'assets/images/loading_image.png');
                          },
                          errorWidget: (context, url, error) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 80,
                                  width: 80,
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/icon.png'),
                                          opacity: .5)),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      sizedBoxCustom(8),
                      CommonHelper().titleCommon(
                          "Car Washing And Cleaning Service At Home or Office",
                          maxLines: 2),
                      sizedBoxCustom(8),
                      Row(
                        children: [
                          Text(
                            '${lnProvider.getString('by')}:',
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: cc.greyFour.withOpacity(.6),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          Text(
                            "Test Seller",
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: cc.greyFour,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      sizedBoxCustom(8),
                      Row(
                        children: [
                          Text(
                            "${rtlProvider.currency}200",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                    color: cc.primaryColor,
                                    fontWeight: FontWeight.w600),
                          ),
                          const Spacer(),
                          Icon(
                            Icons.star_rounded,
                            color: cc.yellowColor,
                            size: 20,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "3.8",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                    color: cc.yellowColor,
                                    fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      sizedBoxCustom(8),
                      CommonHelper().borderButtonOrange(
                          lnProvider.getString("View More"), () {})
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
