import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/helper/extension/context_extension.dart';
import 'package:qixer/helper/extension/int_extension.dart';
import 'package:qixer/helper/extension/widget_extension.dart';
import 'package:qixer/service/common_service.dart';
import 'package:qixer/service/home_services/category_service.dart';
import 'package:qixer/service/jobs_service/recent_jobs_service.dart';
import 'package:qixer/view/search/service_filter_model.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/custom_dropdown.dart';
import 'package:qixer/view/utils/field_label.dart';
import 'package:qixer/view/utils/location_from_google.dart';
import 'package:qixer/view/utils/responsive.dart';

import '../../../service/filter_services_service.dart';
import '../../utils/constant_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LocationSheet extends StatelessWidget {
  const LocationSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final sfm = ServiceFilterViewModel.instance;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      margin:
          EdgeInsets.only(bottom: (MediaQuery.of(context).viewInsets.bottom)),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
          color: cc.white,
          border: Border.all(color: cc.black7)),
      constraints: BoxConstraints(
          maxHeight:
              context.height / 2 + (MediaQuery.of(context).viewInsets.bottom)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 4,
              width: 48,
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: cc.black7,
              ),
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FieldLabel(
                  label: AppLocalizations.of(context)!.type,
                ),
                ValueListenableBuilder<String?>(
                  valueListenable: sfm.serviceType,
                  builder: (context, type, child) {
                    return CustomDropdown(
                      hintText: "",
                      listData: const ["All", "Offline", "Online"],
                      onChanged: (p0) {
                        sfm.serviceType.value = p0;
                      },
                      value: type,
                    );
                  },
                ),
                16.toHeight,
                FieldLabel(
                  label: AppLocalizations.of(context)!.distance,
                ),
                ValueListenableBuilder<int>(
                  valueListenable: sfm.distance,
                  builder: (context, distance, child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "$distance km",
                          style: context.titleMedium
                              ?.copyWith(color: cc.black3)
                              .bold6,
                        ).hp20,
                        Slider(
                            min: 0,
                            max: 200,
                            value: distance.toDouble(),
                            onChanged: (d) {
                              sfm.distance.value = d.toInt();
                            }),
                      ],
                    );
                  },
                ),
                16.toHeight,
                LocationFromGoogle(predictionNotifier: sfm.prediction),
                20.toHeight,
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: OutlinedButton(
                          onPressed: () {
                            Provider.of<FilterServicesService>(context,
                                    listen: false)
                                .setLocationFilters(
                              distance: 50,
                              prediction: null,
                              serviceType: "All",
                            );
                            context.popFalse;
                          },
                          child:
                              Text(AppLocalizations.of(context)!.clearFilter)),
                    ),
                    16.toWidth,
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                          onPressed: () {
                            Provider.of<FilterServicesService>(context,
                                    listen: false)
                                .setLocationFilters(
                              distance: sfm.distance.value,
                              prediction: sfm.prediction.value,
                              serviceType: sfm.serviceType.value,
                            );
                            context.popFalse;
                          },
                          child:
                              Text(AppLocalizations.of(context)!.applyFilter)),
                    ),
                  ],
                ),
                12.toHeight
              ],
            ),
          ))
        ],
      ),
    );
  }
}

class LocationSheet2 extends StatelessWidget {
  const LocationSheet2({super.key});

  @override
  Widget build(BuildContext context) {
    final sfm = ServiceFilterViewModel.instance;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      margin:
          EdgeInsets.only(bottom: (MediaQuery.of(context).viewInsets.bottom)),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
          color: cc.white,
          border: Border.all(color: cc.black7)),
      constraints: BoxConstraints(
          maxHeight:
              context.height / 2 + (MediaQuery.of(context).viewInsets.bottom)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 4,
              width: 48,
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: cc.black7,
              ),
            ),
          ),
          Center(
            child: Text(
              textAlign: TextAlign.center,
              AppLocalizations.of(context)!.selectYourCityHere,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Divider(),
          Expanded(
            child: Consumer<RecentJobsService>(
              builder: (contexts, provider, child) {
                // Add 1 to the itemCount to account for the "Select City" option
                final cityCount = provider.allCitiesDataModel.data?.length ?? 0;
                return ListView.builder(
                  itemCount: cityCount + 1, // +1 for the "Select City" option
                  itemBuilder: (contexts2, index) {
                    if (index == 0) {
                      // This is the "Select City" option
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: InkWell(
                          onTap: () {
                            provider.setCityID(
                                0, AppLocalizations.of(context)!.selectCity);
                            Navigator.pop(context);
                            Provider.of<CategoryService>(contexts,
                                    listen: false)
                                .fetchCategory(location_id: '0');
                          },
                          child: Text(AppLocalizations.of(context)!.selectCity),
                        ),
                      );
                    } else {
                      final cities =
                          provider.allCitiesDataModel.data?[index - 1];
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: InkWell(
                          onTap: () {
                            provider.setCityID(cities?.id ?? 0,
                                cities?.serviceArea.toString() ?? '');

                            Provider.of<CategoryService>(contexts,
                                    listen: false)
                                .fetchCategory(
                                    location_id: cities?.id.toString() ?? '');

                            Navigator.pop(context);
                          },
                          child: Text(
                              cities?.serviceArea.toString().capitalize() ??
                                  ''),
                        ),
                      );
                    }
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
