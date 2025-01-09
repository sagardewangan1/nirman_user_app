import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/helper/extension/context_extension.dart';
import 'package:qixer/helper/extension/int_extension.dart';
import 'package:qixer/helper/extension/widget_extension.dart';
import 'package:qixer/view/search/service_filter_model.dart';
import 'package:qixer/view/utils/custom_dropdown.dart';
import 'package:qixer/view/utils/field_label.dart';
import 'package:qixer/view/utils/location_from_google.dart';
import 'package:qixer/view/utils/responsive.dart';

import '../../../service/filter_services_service.dart';
import '../../utils/constant_colors.dart';

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
                  label: lnProvider.getString("Type"),
                ),
                ValueListenableBuilder<String?>(
                  valueListenable: sfm.serviceType,
                  builder: (context, type, child) {
                    return CustomDropdown(
                      "",
                      const ["All", "Offline", "Online"],
                      (p0) {
                        sfm.serviceType.value = p0;
                      },
                      value: type,
                    );
                  },
                ),
                16.toHeight,
                FieldLabel(
                  label: lnProvider.getString("Distance"),
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
                          child: Text(lnProvider.getString("Clear Filter"))),
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
                          child: Text(lnProvider.getString("Apply Filter"))),
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
