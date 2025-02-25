import 'package:flutter/material.dart';
import 'package:flutterzilla_fixed_grid/flutterzilla_fixed_grid.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:qixer/service/all_services_service.dart';
import 'package:qixer/view/home/categories/components/category_card.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/constant_styles.dart';
import 'package:qixer/view/utils/others_helper.dart';

import '../../../service/serviceby_category_service.dart';
import '../../services/service_by_category_page.dart';

class AllCategoriesPage extends StatefulWidget {
  final String? catId;
  final String? title;
  const AllCategoriesPage({super.key, this.catId, this.title});

  @override
  State<AllCategoriesPage> createState() => _AllCategoriesPageState();
}

class _AllCategoriesPageState extends State<AllCategoriesPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<AllServicesService>(context, listen: false)
        .fetchCategories(context);
    Provider.of<AllServicesService>(context, listen: false)
        .fetchSubcategory(widget.catId);
  }

  final RefreshController refreshController =
      RefreshController(initialRefresh: true);

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();
    return Scaffold(
        // backgroundColor: Colors.white,
        appBar: CommonHelper()
            .appbarCommon(widget.title ?? 'All Categories', context, () {
          Navigator.pop(context);
        }),
        body: Consumer<AllServicesService>(
          builder: (context, provider, child) => Container(
            padding: EdgeInsets.symmetric(horizontal: screenPadding),
            child: GridView.builder(
              clipBehavior: Clip.none,
              gridDelegate: const FlutterzillaFixedGridView(
                  crossAxisCount: 2,
                  mainAxisSpacing: 19,
                  crossAxisSpacing: 19,
                  height: 100),
              padding: const EdgeInsets.only(top: 12),
              itemCount: provider.subCatList.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final subCate = provider.subCatList[index];
                return provider.subCatList != null
                    ? provider.subCatList != 'error'
                        ? CategoryCard(
                            onTap: () {
                              final sbcProvider =
                                  Provider.of<ServiceByCategoryService>(
                                context,
                                listen: false,
                              );
                              sbcProvider.fetchSubcategoryList(subCate.id);
                              Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      ServiceCategoryPage(
                                    categoryName: subCate.name ?? '',
                                    categoryId: subCate.id,
                                    subCatId: subCate.id,
                                  ),
                                ),
                              );
                            },
                            name: subCate.name,
                            id: subCate.id,
                            cc: cc,
                            index: index,
                            imagelink: subCate.image ??
                                "", // Correctly accessing the mobileIcon data
                          )
                        : const Text("Something went wrong")
                    : OthersHelper().showLoading(cc.primaryColor);
              },
            ),
          ),
        ));
  }
}
