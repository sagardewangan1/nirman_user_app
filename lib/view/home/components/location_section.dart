import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:qixer/generated/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:qixer/helper/extension/string_extension.dart';
import 'package:qixer/model/navigationModel.dart';
import 'package:qixer/service/filter_services_service.dart';
import 'package:qixer/service/home_services/top_rated_services_service.dart';
import 'package:qixer/service/jobs_service/recent_jobs_service.dart';
import 'package:qixer/view/home/components/section_title.dart';
import 'package:qixer/view/services/serviceByLocation.dart';
import 'package:qixer/view/services/service_by_category_page.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/constant_styles.dart';
import 'package:qixer/view/utils/others_helper.dart';

class LocationSection extends StatelessWidget {
  final asProvider;
  const LocationSection({super.key, required this.asProvider});

  @override
  Widget build(BuildContext context) {
    final cc = ConstantColors();
    return Consumer<RecentJobsService>(
      builder: (context, provider, child) {
        return provider.isLoadingLoc
            ? OthersHelper().showLoading(cc.primaryColor)
            : provider.homeCitiesDataModel.homeCities?.length != 0
                ? Column(
                    children: [
                      CategoryTitle2(
                        cc: cc,
                        title: AppLocalizations.of(context)!
                            .exploreLocations
                            .toString()
                            .capitalizeWords,
                        pressed: () {},
                        hasSeeAllBtn: false,
                      ),
                      sizedBoxCustom(10),
                      Consumer<FilterServicesService>(
                        builder: (context, fsService, child) {
                          return SizedBox(
                            // height: 400, // Adjust height as needed
                            child: GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.all(8.0),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount:
                                    2, // ✅ 2 columns for gallery layout
                                crossAxisSpacing:
                                    8, // ✅ Reduced spacing for compact look
                                mainAxisSpacing:
                                    8, // ✅ Reduced spacing between rows
                                childAspectRatio:
                                    0.8, // ✅ Makes items taller like a gallery
                              ),
                              itemCount: (provider.homeCitiesDataModel
                                              .homeCities?.length ??
                                          0) >
                                      10
                                  ? 10 // ✅ Show only first 10 items
                                  : provider.homeCitiesDataModel.homeCities
                                          ?.length ??
                                      0,
                              itemBuilder: (context, index) {
                                final cities = provider
                                    .homeCitiesDataModel.homeCities?[index];
                                return InkWell(
                                  onTap: () {
                                    fsService.setCityId(cities?.id.toString());
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute<void>(
                                        builder: (BuildContext context) =>
                                            ServiceByLocation(
                                          navigationModel: NavigationModel(
                                            pageName: cities?.serviceArea
                                                    .toString()
                                                    .capitalize ??
                                                '',
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: cc.white,
                                      borderRadius: BorderRadius.circular(8.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color: cc.greyFour.withOpacity(0.3),
                                          blurRadius: 4,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                          cities?.mobileIcon.toString() ??
                                              placeHolderUrl,
                                        ),
                                      ),
                                    ),
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          bottom: 0,
                                          left: 0,
                                          right: 0,
                                          child: Container(
                                            height: 30,
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  Colors.black.withOpacity(0.0),
                                                  Colors.black.withOpacity(0.4),
                                                  Colors.black.withOpacity(0.5),
                                                  Colors.black.withOpacity(0.8),
                                                  Colors.black.withOpacity(1.0),
                                                ],
                                              ),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                bottomLeft:
                                                    Radius.circular(8.0),
                                                bottomRight:
                                                    Radius.circular(8.0),
                                              ),
                                            ),
                                            alignment: Alignment.center,
                                            child: Text(
                                              cities?.serviceArea
                                                      .toString()
                                                      .capitalize ??
                                                  '',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelMedium!
                                                  .copyWith(
                                                    fontWeight: FontWeight.w500,
                                                    color: cc.white,
                                                  ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      )
                    ],
                  )
                : Container(
                    alignment: Alignment.center,
                    height: 140,
                    child: Image.asset(
                      "assets/images/nodata.png",
                      fit: BoxFit.contain,
                    ),
                  );
      },
    );
  }
}

// Top Service
class TopServiceSection extends StatelessWidget {
  final asProvider;
  const TopServiceSection({super.key, required this.asProvider});

  @override
  Widget build(BuildContext context) {
    final cc = ConstantColors();
    return Consumer<TopRatedServicesSerivce>(
      builder: (context, provider, child) {
        return provider.isLoading
            ? OthersHelper().showLoading(cc.primaryColor)
            : provider.topServiceList.length != 0
                ? Column(
                    children: [
                      CategoryTitle2(
                        cc: cc,
                        title: AppLocalizations.of(context)!
                            .topServices
                            .toString()
                            .capitalizeWords,
                        pressed: () {},
                        hasSeeAllBtn: false,
                      ),
                      sizedBoxCustom(10),
                      Consumer<FilterServicesService>(
                        builder: (context, fsService, child) {
                          return SizedBox(
                              // height: 400, // Adjust height as needed
                              child: GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.all(8.0),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount:
                                  2, // ✅ 2 columns for gallery layout
                              crossAxisSpacing:
                                  8, // ✅ Reduced spacing for compact look
                              mainAxisSpacing:
                                  8, // ✅ Reduced spacing between rows
                              childAspectRatio:
                                  0.8, // ✅ Makes items taller like a gallery
                            ),
                            itemCount: provider.topServiceList.length > 10
                                ? 10
                                : provider.topServiceList.length,
                            itemBuilder: (context, index) {
                              final cities = provider.topServiceList[index];
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          ServiceCategoryPage(
                                        categoryName: cities["name"].toString(),
                                        categoryId:
                                            cities["categoryId"].toString(),
                                        subCatId: cities["id"].toString(),
                                      ),
                                    ),
                                  );
                                },
                                child: Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.3),
                                            blurRadius: 4,
                                            offset: Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: CachedNetworkImage(
                                          imageUrl: cities["banner_img"] ??
                                              placeHolderUrl,
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          height: double.infinity,
                                          placeholder: (context, url) => Center(
                                              child:
                                                  CircularProgressIndicator()),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      left: 0,
                                      right: 0,
                                      child: Container(
                                        alignment: Alignment.bottomCenter,
                                        height: 120,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Colors.black.withOpacity(0.0),
                                              Colors.black.withOpacity(0.4),
                                              Colors.black.withOpacity(0.5),
                                              Colors.black.withOpacity(0.8),
                                              Colors.black.withOpacity(1.0),
                                            ],
                                          ),
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(8.0),
                                            bottomRight: Radius.circular(8.0),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.visible,
                                            // maxLines: 2,
                                            cities["name"]
                                                .toString()
                                                .capitalizeWords,
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelMedium!
                                                .copyWith(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16,
                                                  color: Colors.white,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ));
                        },
                      )
                    ],
                  )
                : Container();
        // Container(
        //             alignment: Alignment.center,
        //             height: 140,
        //             child: Image.asset(
        //               "assets/images/nodata.png",
        //               fit: BoxFit.contain,
        //             ),
        //           );
      },
    );
  }
}
