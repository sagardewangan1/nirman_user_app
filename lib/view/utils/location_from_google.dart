import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:qixer/helper/extension/context_extension.dart';
import 'package:qixer/helper/extension/int_extension.dart';
import 'package:qixer/helper/extension/string_extension.dart';
import 'package:qixer/service/google_location_search_service.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/custom_input.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:qixer/view/utils/responsive.dart';

import '../../model/google_places_model.dart';
import 'custom_button.dart';

class LocationFromGoogle extends StatelessWidget {
  final selectedValue;
  final onSelect;
  final onCurrentLocation;
  final ValueNotifier<Prediction?> predictionNotifier;

  const LocationFromGoogle({
    super.key,
    this.selectedValue,
    this.onSelect,
    this.onCurrentLocation,
    required this.predictionNotifier,
  });

  @override
  Widget build(BuildContext context) {
    final ScrollController controller = ScrollController();
    final cc = ConstantColors();
    Timer? scheduleTimeout;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            Provider.of<GoogleLocationSearch>(context, listen: false)
                .resetLocations();
            showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              isScrollControlled: true,
              // constraints: BoxConstraints(minHeight: context.height),
              builder: (context) {
                return Container(
                  // height: 500,
                  // margin: EdgeInsets.all(20),

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),

                  constraints: BoxConstraints(
                      maxHeight: screenHeight / 1.5 +
                          (MediaQuery.of(context).viewInsets.bottom / 2)),
                  child: Consumer<GoogleLocationSearch>(
                      builder: (context, glsProvider, child) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: CustomInput(
                              textInputAction: TextInputAction.done,
                              hintText: "Search Location",
                              icon: "assets/icons/search.png",
                              onChanged: (value) {
                                scheduleTimeout?.cancel();
                                scheduleTimeout =
                                    Timer(const Duration(seconds: 1), () {
                                  glsProvider.fetchLocations(
                                    location: value,
                                    // region: Provider.of<PostTaskService>(context,
                                    //         listen: false)
                                    //     .selectedCountryCode,
                                  );
                                });
                              }),
                        ),
                        // GestureDetector(
                        //   onTap: () async {
                        //     Navigator.pop(context);
                        //     // var pt = Provider.of<PostTaskService>(context,
                        //     //     listen: false);
                        //     // pt.setCurrentLocationLoading(true);
                        //     OthersHelper().showToast(
                        //         "Choosing current location", Colors.black);
                        //     final permission = await locationPermissionCheck();
                        //     if (permission != true) {
                        //       OthersHelper().showToast(
                        //           "Failed to get location", Colors.black);
                        //       // pt.setCurrentLocationLoading(false);
                        //       return;
                        //     }
                        //     final GeolocatorPlatform geolocatorPlatform =
                        //         GeolocatorPlatform.instance;
                        //     final currentLoc =
                        //         await geolocatorPlatform.getCurrentPosition();

                        //     if (onCurrentLocation != null) {
                        //       OthersHelper().showToast(
                        //           "Location set successfully", Colors.black);
                        //       await onCurrentLocation(currentLoc);
                        //     }
                        //     // pt.setCurrentLocationLoading(false);
                        //   },
                        //   child: Container(
                        //     height: 50,
                        //     margin: const EdgeInsets.symmetric(horizontal: 20),
                        //     decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(8),
                        //       border:
                        //           Border.all(color: cc.borderColor, width: 1),
                        //     ),
                        //     child: Row(
                        //       children: [
                        //         Padding(
                        //           padding: const EdgeInsets.symmetric(
                        //               horizontal: 10),
                        //           child: Icon(
                        //             Icons.my_location_rounded,
                        //             color: cc.greyParagraph,
                        //           ),
                        //         ),
                        //         Text(
                        //           lnProvider
                        //               .getString("Chose current location"),
                        //           style: Theme.of(context)
                        //               .textTheme
                        //               .titleSmall
                        //               ?.copyWith(
                        //                   color: cc.greyParagraph,
                        //                   fontWeight: FontWeight.w500),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        Expanded(
                          child: ListView.separated(
                              controller: controller,
                              shrinkWrap: true,
                              padding: const EdgeInsets.only(
                                  right: 20, left: 20, bottom: 20),
                              itemBuilder: (context, index) {
                                if (glsProvider.isLoading) {
                                  return SizedBox(
                                      height: 50,
                                      width: double.infinity,
                                      child: Center(
                                          child: OthersHelper()
                                              .showLoading(cc.primaryColor)));
                                }
                                if (glsProvider.locations.isEmpty) {
                                  return Container(
                                    width: screenWidth - 60,
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 30),
                                    child: CommonHelper()
                                        .paragraphCommon("No location found"),
                                  );
                                }
                                if (glsProvider.locations.length == index) {
                                  return const SizedBox();
                                }
                                final element = glsProvider.locations[index];
                                return InkWell(
                                  onTap: () {
                                    predictionNotifier.value = element;
                                    debugPrint(element.placeId.toString());
                                    context.popTrue;

                                    if (onSelect == null ||
                                        element == selectedValue) {
                                      return;
                                    }
                                    onSelect(element);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 14),
                                    child: Text(
                                      element.description ?? '',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall
                                          ?.copyWith(
                                              color: cc.greyParagraph,
                                              fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                    height: 8,
                                    child: Center(child: Divider()),
                                  ),
                              itemCount: glsProvider.isLoading == true
                                  ? 1
                                  : glsProvider.locations.length + 1),
                        ),
                      ],
                    );
                  }),
                );
              },
            ).then((value) async {
              if (predictionNotifier.value != null && value != null) {
                final placeDetails = await Provider.of<GoogleLocationSearch>(
                        context,
                        listen: false)
                    .fetchPlaceDetails(predictionNotifier.value?.placeId);
                predictionNotifier.value?.lat =
                    placeDetails?.result?.geometry?.location?.lat;
                predictionNotifier.value?.lng =
                    placeDetails?.result?.geometry?.location?.lng;
              }
            });
          },
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: cc.borderColor, width: 1),
            ),
            child:
                Consumer<GoogleLocationSearch>(builder: (context, gls, child) {
              return gls.isLoading
                  ? OthersHelper().showLoading(cc.primaryColor)
                  : Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Image.asset(
                            "assets/icons/location.png",
                            height: 24,
                          ),
                        ),
                        ValueListenableBuilder<Prediction?>(
                            valueListenable: predictionNotifier,
                            builder: (context, predication, child) {
                              return Expanded(
                                flex: 1,
                                child: Text(
                                  predication?.description ??
                                      lnProvider.getString("Chose location"),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(
                                          color: cc.greyParagraph,
                                          fontWeight: FontWeight.w500),
                                ),
                              );
                            }),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: cc.greyPrimary,
                          ),
                        ),
                      ],
                    );
            }),
          ),
        ),
        16.toHeight,
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Consumer<GoogleLocationSearch>(
                  builder: (context, gls, child) {
                return CustomButton(
                    onPressed: () async {
                      "Choosing current location".tr().showToast();
                      gls.setIsLoading(true);
                      if (locationPermissionCheck() == false) {
                        "Failed to get location".tr().showToast();
                        gls.setIsLoading(true);
                        return;
                      }
                      try {
                        final GeolocatorPlatform geolocatorPlatform =
                            GeolocatorPlatform.instance;
                        final currentLoc =
                            await geolocatorPlatform.getCurrentPosition();
                        await Provider.of<GoogleLocationSearch>(context,
                                listen: false)
                            .fetchGEOLocations(
                                lat: currentLoc.latitude,
                                lng: currentLoc.longitude);
                        "Location set successfully".tr().showToast();
                        predictionNotifier.value = gls.geoLoc;
                      } catch (e) {}
                    },
                    btText: "Choose Current Location".tr(),
                    isLoading: gls.isLoading);
              }),
            ),
          ],
        ),
      ],
    );
  }

  locationPermissionCheck() async {
    final GeolocatorPlatform geolocatorPlatform = GeolocatorPlatform.instance;
    await geolocatorPlatform.requestPermission();
    final permission = await geolocatorPlatform.checkPermission();
    return permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always;
  }
}
