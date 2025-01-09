import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/helper/extension/context_extension.dart';
import 'package:qixer/helper/extension/int_extension.dart';
import 'package:qixer/model/child_category_model.dart';
import 'package:qixer/model/sub_category_model.dart';
import 'package:qixer/view/search/service_filter_model.dart';
import 'package:qixer/view/utils/custom_dropdown.dart';
import 'package:qixer/view/utils/custom_future_widget.dart';
import 'package:qixer/view/utils/field_label.dart';
import 'package:qixer/view/utils/others_helper.dart';

import '../../../model/categoryModel.dart';
import '../../../service/filter_category_service.dart';
import '../../../service/filter_services_service.dart';
import '../../utils/constant_colors.dart';
import '../../utils/responsive.dart';

class CategorySheet extends StatelessWidget {
  const CategorySheet({super.key});

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
          Expanded(child: SingleChildScrollView(
            child:
                Consumer<FilterCategoryService>(builder: (context, fc, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  16.toHeight,
                  const FieldLabel(label: "Category"),
                  CustomFutureWidget(
                    function: fc.shouldFC ? fc.fetchCategory() : null,
                    shimmer: OthersHelper().showLoading(cc.primaryColor),
                    child: ValueListenableBuilder<Category?>(
                        valueListenable: sfm.selectedCategory,
                        builder: (context, category, child) => CustomDropdown(
                              "Select category",
                              fc.categoryModel.category
                                  .map((e) => e.name ?? "")
                                  .toList(),
                              (name) {
                                sfm.selectedCategory.value = fc.getCat(name);
                                fc.fetchSubcategory(
                                    sfm.selectedCategory.value?.id);
                                sfm.selectedSubcategory.value = null;
                              },
                              value: category?.name,
                            )),
                  ),
                  12.toHeight,
                  const FieldLabel(label: "Subcategory"),
                  CustomFutureWidget(
                    shimmer: OthersHelper().showLoading(cc.primaryColor),
                    isLoading: fc.subCatLoading,
                    child: ValueListenableBuilder<SubCategory?>(
                        valueListenable: sfm.selectedSubcategory,
                        builder: (context, subcategory, child) =>
                            CustomDropdown(
                              "Select subcategory",
                              fc.subcategoryModel.subCategories
                                  .map((e) => e.name ?? "")
                                  .toList(),
                              (name) {
                                sfm.selectedSubcategory.value =
                                    fc.getSubCat(name);
                                fc.fetchChildCategory(
                                    sfm.selectedSubcategory.value?.id);
                                sfm.selectedChildCategory.value = null;
                              },
                              value: subcategory?.name,
                            )),
                  ),
                  12.toHeight,
                  const FieldLabel(label: "Child-category"),
                  CustomFutureWidget(
                    shimmer: OthersHelper().showLoading(cc.primaryColor),
                    isLoading: fc.childCatLoading,
                    child: ValueListenableBuilder<ChildCategory?>(
                        valueListenable: sfm.selectedChildCategory,
                        builder: (context, childCategory, child) =>
                            CustomDropdown(
                              "Select child-category",
                              fc.childCategoryModel.childCategory
                                  .map((e) => e.name ?? "")
                                  .toList(),
                              (name) {
                                sfm.selectedChildCategory.value =
                                    fc.getChildCat(name);
                              },
                              value: childCategory?.name,
                            )),
                  ),

                  // ====================>

                  20.toHeight,
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: OutlinedButton(
                            onPressed: () {
                              Provider.of<FilterServicesService>(context,
                                      listen: false)
                                  .setCategoryFilters();
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
                                  .setCategoryFilters(
                                      selectedCategory:
                                          sfm.selectedCategory.value,
                                      selectedSubcategory:
                                          sfm.selectedSubcategory.value,
                                      selectedChildCategory:
                                          sfm.selectedChildCategory.value);
                              context.popFalse;
                            },
                            child: Text(lnProvider.getString("Apply Filter"))),
                      ),
                    ],
                  ),
                ],
              );
            }),
          ))
        ],
      ),
    );
  }
}
