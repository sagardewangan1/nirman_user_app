import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/helper/extension/string_extension.dart';
import 'package:qixer/model/recent_service_model.dart';
import 'package:qixer/service/jobs_service/recent_jobs_service.dart';
import 'package:qixer/view/home/components/section_title.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/constant_styles.dart';

import '../../../service/home_services/category_service.dart';
import '../../utils/others_helper.dart';

class LocationSection extends StatelessWidget {
  final asProvider;
  const LocationSection({super.key, required this.asProvider});

  @override
  Widget build(BuildContext context) {
    final cc = ConstantColors();
    return Consumer<RecentJobsService>(
      builder: (context, provider, child) {
        return provider.allCitiesDataModel.data != null
            ? provider.allCitiesDataModel != 'error'
                ? Column(
                    children: [
                      CategoryTitle2(
                        cc: cc,
                        title: "Explore Locations".toString().capitalizeWords,
                        pressed: () {},
                      ),
                      sizedBoxCustom(10),
                      SizedBox(
                        height: 120, // Increased height to ensure content fits
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: provider.allCitiesDataModel.data?.length,
                          itemBuilder: (context, index) {
                            final cities =
                                provider.allCitiesDataModel.data?[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 150, // Set a fixed width for consistency
                                decoration: BoxDecoration(
                                  color: cc.white,
                                  borderRadius: BorderRadius.circular(8.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: cc.greyFour.withOpacity(0.3),
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    )
                                  ],
                                  image: const DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      "https://t3.ftcdn.net/jpg/05/79/64/14/360_F_579641470_CA5QomtHJKv9qZQaCSCdNwHmFZBVIDrN.jpg",
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
                                        height:
                                            30, // Adjust height of the overlay
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                                Colors.black.withOpacity(
                                                    0.0), // Fully transparent
                                                Colors.black.withOpacity(
                                                    0.4), // Slightly transparent
                                                Colors.black.withOpacity(
                                                    0.5), // Half transparent
                                                Colors.black.withOpacity(
                                                    0.8), // Mostly opaque
                                                Colors.black.withOpacity(
                                                    1.0), // Fully opaque
                                              ]),
                                          // color: Colors.black.withOpacity(0.6),
                                          borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(8.0),
                                            bottomRight: Radius.circular(8.0),
                                          ),
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(
                                          cities?.serviceArea.toString() ?? '',
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
                      ),
                    ],
                  )
                : Text(asProvider.getString('Something went wrong'))
            : OthersHelper().showLoading(cc.primaryColor);
      },
    );
  }
}
