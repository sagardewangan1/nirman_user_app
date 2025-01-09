import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:qixer/view/home/components/marker_window_painter.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/responsive.dart';

import '../../service/service_details_service.dart';
import '../services/service_details_page.dart';
import '../utils/common_helper.dart';
import '../utils/constant_styles.dart';

class HomepageHelper {
  static ValueNotifier<int> tabIndex = ValueNotifier(0);

  static ValueNotifier<bool> viewMap = ValueNotifier(false);
  changeMapView(value) {
    debugPrint(
        "Changing map view data from -${viewMap.value} to -$value".toString());
    viewMap.value = value;
  }

  locationPermissionCheck() async {
    final GeolocatorPlatform geolocatorPlatform = GeolocatorPlatform.instance;
    await geolocatorPlatform.requestPermission();
    final permission = await geolocatorPlatform.checkPermission();
    return permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always;
  }

  Widget searchbar(asProvider, BuildContext context) {
    ConstantColors cc = ConstantColors();
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
        decoration: BoxDecoration(
            color: const Color(0xffF5F5F5),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.01),
                  spreadRadius: -2,
                  blurRadius: 13,
                  offset: const Offset(0, 13)),
            ],
            borderRadius: BorderRadius.circular(3)),
        child: Row(
          children: [
            const Icon(
              Icons.search,
              color: Color.fromARGB(255, 126, 126, 126),
              size: 22,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              asProvider.getString("Search services"),
              style: const TextStyle(
                color: Color.fromARGB(255, 126, 126, 126),
                fontSize: 14,
              ),
            ),
          ],
        ));
  }

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
            bottom: (screenHeight / 2.3) + 50,
            child: Material(
              color: Colors.transparent,
              child: CustomPaint(
                painter: MarkerWindowPainter(),
                child: Container(
                  // height: 334,
                  width: 272,
                  constraints: const BoxConstraints(maxHeight: 346),
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
                          imageUrl: imageUrl ?? "",
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
                      CommonHelper().titleCommon(title,
                          maxLines: 1, overflow: TextOverflow.ellipsis),
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
                            sellerName ?? "",
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
                            "${rtlProvider.currency}$price",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                    color: cc.primaryColor,
                                    fontWeight: FontWeight.w600),
                          ),
                          const Spacer(),
                          if (rating > 0)
                            Icon(
                              Icons.star_rounded,
                              color: cc.yellowColor,
                              size: 20,
                            ),
                          const SizedBox(width: 4),
                          Text(
                            rating > 0 ? "$rating" : "",
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
                          lnProvider.getString("View More"), () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                const ServiceDetailsPage(),
                          ),
                        );
                        Provider.of<ServiceDetailsService>(context,
                                listen: false)
                            .fetchServiceDetails(serviceId);
                      })
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
