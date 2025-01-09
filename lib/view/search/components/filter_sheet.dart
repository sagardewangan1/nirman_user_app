import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:qixer/helper/extension/context_extension.dart';
import 'package:qixer/helper/extension/int_extension.dart';
import 'package:qixer/helper/extension/string_extension.dart';
import 'package:qixer/view/search/service_filter_model.dart';
import 'package:qixer/view/utils/custom_dropdown.dart';
import 'package:qixer/view/utils/field_label.dart';

import '../../../service/filter_services_service.dart';
import '../../utils/constant_colors.dart';
import '../../utils/responsive.dart';

class FilterSheet extends StatelessWidget {
  const FilterSheet({super.key});

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
                16.toHeight,
                const FieldLabel(label: "Sort By"),
                ValueListenableBuilder<SortModel?>(
                  valueListenable: sfm.selectedSorting,
                  builder: (context, sort, child) {
                    return CustomDropdown(
                      "",
                      sfm.sortList.map((e) => e.name).toList(),
                      (name) {
                        try {
                          sfm.selectedSorting.value = sfm.sortList
                              .firstWhere((element) => element.name == name);
                        } catch (e) {}
                      },
                      value: sort?.name ?? sfm.sortList[0].name,
                    );
                  },
                ),
                const FieldLabel(label: "Price"),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        controller: sfm.minPriceController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: lnProvider.getString("Min"),
                        ),
                      ),
                    ),
                    16.toWidth,
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        controller: sfm.maxPriceController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: lnProvider.getString("Max"),
                        ),
                      ),
                    ),
                  ],
                ),
                16.toHeight,
                const FieldLabel(label: "Ratings"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ValueListenableBuilder<num?>(
                      valueListenable: sfm.rating,
                      builder: (context, rating, child) {
                        return RatingBar.builder(
                            initialRating: rating?.toDouble() ?? 0,
                            itemBuilder: (context, index) => Icon(
                                  Icons.star_rounded,
                                  color: cc.yellowColor,
                                ),
                            onRatingUpdate: (r) {
                              sfm.rating.value = r;
                            });
                      },
                    ),
                    IconButton(
                        onPressed: () {
                          sfm.rating.value = null;
                        },
                        icon: const Icon(Icons.replay_outlined))
                  ],
                ),
                20.toHeight,
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: OutlinedButton(
                          onPressed: () {
                            Provider.of<FilterServicesService>(context,
                                    listen: false)
                                .setNormalFilters(
                                    minPrice: "",
                                    maxPrice: "",
                                    sort: null,
                                    rating: null);
                            context.popFalse;
                          },
                          child: Text(lnProvider.getString("Clear Filter"))),
                    ),
                    16.toWidth,
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                          onPressed: () {
                            if (sfm.minPriceController.text.isNotEmpty &&
                                sfm.maxPriceController.text.isEmpty) {
                              "Please provide maximum filter price amount"
                                  .tr()
                                  .showToast();
                              return;
                            }
                            Provider.of<FilterServicesService>(context,
                                    listen: false)
                                .setNormalFilters(
                                    minPrice: sfm.minPriceController.text,
                                    maxPrice: sfm.maxPriceController.text,
                                    sort: sfm.selectedSorting.value,
                                    rating: sfm.rating.value);
                            context.popFalse;
                          },
                          child: Text(lnProvider.getString("Apply Filter"))),
                    ),
                  ],
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
