import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/helper/extension/string_extension.dart';
import 'package:qixer/service/home_services/category_service.dart';
import 'package:qixer/service/serviceby_category_service.dart';
import 'package:qixer/view/home/categories/all_categories_page.dart';
import 'package:qixer/view/home/categories/components/category_card.dart';
import 'package:qixer/view/home/components/section_title.dart';
import 'package:qixer/view/services/service_by_category_page.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CategoriesMain extends StatelessWidget {
  const CategoriesMain({
    super.key,
    required this.cc,
    required this.asProvider,
  });
  final ConstantColors cc;
  final asProvider;
  @override
  Widget build(BuildContext context) {
    // getLineAwsome("las la-charging-station");
    return Consumer<CategoryService>(
      builder: (context, provider, child) {
        return provider.isLoading
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Loading Categories......"),
                  OthersHelper().showLoading(cc.primaryColor)
                ],
              )
            : Container(
                alignment: Alignment.center,
                child: provider.categoryDataModel.categories?.length != 0
                    ? ListView.builder(
                        itemCount: provider.isExpanded
                            ? (provider.categoryDataModel.categories?.length ??
                                0)
                            : ((provider.categoryDataModel.categories?.length ??
                                        0) >
                                    3
                                ? 3
                                : (provider
                                        .categoryDataModel.categories?.length ??
                                    0)),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, indexParent) {
                          final category = provider
                              .categoryDataModel.categories?[indexParent];
                          final subcategories = category?.subcategories;
                          return subcategories?.length == 0
                              ? Offstage()
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        color: cc.white),
                                    child: Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              color: cc.primaryColor,
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(8.0),
                                                topLeft: Radius.circular(8.0),
                                              )),
                                          child: Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: CategoryTitle(
                                              cc: cc,
                                              title: category?.name
                                                      ?.toString()
                                                      .capitalizeWords ??
                                                  '',
                                              maxLines: 1,
                                              titleWidth: 250,
                                              textOverflow:
                                                  TextOverflow.ellipsis,
                                              pressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute<void>(
                                                    builder: (BuildContext
                                                            context) =>
                                                        AllCategoriesPage(
                                                      catId: category?.id
                                                          ?.toString(),
                                                      title: category?.name
                                                          .toString(),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            alignment: Alignment.centerLeft,
                                            height: 150,
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              shrinkWrap: true,
                                              clipBehavior: Clip.antiAlias,
                                              itemCount: subcategories?.length,
                                              itemBuilder: (context, index) {
                                                final subCateData =
                                                    subcategories?[index];
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: CategoryCard(
                                                    name: subCateData?.name,
                                                    id: subCateData?.id,
                                                    cc: cc,
                                                    index: index,
                                                    imagelink: subCateData
                                                        ?.image
                                                        .toString(), // add icon or image
                                                    onTap: () {
                                                      // final sbcProvider = Provider.of<
                                                      //     ServiceByCategoryService>(
                                                      //   context,
                                                      //   listen: false,
                                                      // );
                                                      // sbcProvider
                                                      //     .fetchSubcategoryList(
                                                      //         subCateData?.id);
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute<void>(
                                                          builder: (BuildContext
                                                                  context) =>
                                                              ServiceCategoryPage(
                                                            categoryName:
                                                                subCateData
                                                                        ?.name ??
                                                                    '',
                                                            categoryId:
                                                                category?.id,
                                                            subCatId:
                                                                subCateData?.id,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                        },
                      )
                    : Center(
                        child: Text(AppLocalizations.of(context)!
                            .noServiceProviderInYourArea),
                      ),
              );
      },
    );
  }
}

// class Categories extends StatelessWidget {
//   const Categories({
//     super.key,
//     required this.cc,
//     required this.asProvider,
//   });
//   final ConstantColors cc;
//   final asProvider;
//   @override
//   Widget build(BuildContext context) {
//     // getLineAwsome("las la-charging-station");
//     return Consumer<CategoryService>(
//       builder: (context, provider, child) {
//         return provider.categories != null
//             ? provider.categories != 'error'
//                 ? Container(
//                     alignment: Alignment.center,
//                     margin: const EdgeInsets.only(top: 5),
//                     child: GridView.builder(
//                       gridDelegate:
//                           const SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 3,
//                         mainAxisSpacing: 5,
//                         crossAxisSpacing: 5,
//                         childAspectRatio: 1.0,
//                       ),
//                       scrollDirection: Axis.vertical,
//                       shrinkWrap: true,
//                       physics: const NeverScrollableScrollPhysics(),
//                       clipBehavior: Clip.none,
//                       itemCount: provider.categories.category?.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         return CategoryCard(
//                           name: provider.categories.category?[index].name,
//                           id: provider.categories.category?[index].id,
//                           cc: cc,
//                           index: index,
//                           marginRight: 17.0,
//                           imagelink:
//                               provider.categories.category?[index].mobileIcon,
//                         );
//                       },
//                     ),
//                   )
//                 : Text(asProvider.getString('Something went wrong'))
//             : OthersHelper().showLoading(cc.primaryColor);
//       },
//     );
//   }
// }
