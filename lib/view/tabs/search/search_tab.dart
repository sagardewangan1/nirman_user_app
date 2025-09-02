import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:qixer/helper/extension/context_extension.dart';
import 'package:qixer/helper/extension/string_extension.dart';
import 'package:qixer/service/app_string_service.dart';
import 'package:qixer/service/filter_services_service.dart';
import 'package:qixer/service/home_services/category_service.dart';
import 'package:qixer/view/home_map_view/home_map_view.dart';
import 'package:qixer/view/search/components/search_bar.dart' as sb;
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/constant_styles.dart';
import 'package:qixer/generated/app_localizations.dart';
import 'package:qixer/view/utils/responsive.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  ValueNotifier<bool> viewMap = ValueNotifier(false);
  @override
  void initState() {
    super.initState();
    // Provider.of<FilterServicesService>(context, listen: false).resetFilters();
  }

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();
    final categoryController = Provider.of<CategoryService>(context);

    return Listener(onPointerDown: (_) {
      FocusScopeNode currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.focusedChild?.unfocus();
      }
    }, child: Consumer<AppStringService>(
      builder: (context, asProvider, child) {
        return SafeArea(
          child: Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: CommonHelper()
                    .titleCommon(AppLocalizations.of(context)!.searchServices),
                // actions: [
                //   ValueListenableBuilder<bool>(
                //       valueListenable: viewMap,
                //       builder: (context, view, child) => IconButton(
                //           onPressed: () {
                //             context.toPage(HomeMapView());
                //             // debugPrint(view.toString());
                //             // viewMap.value = !view;
                //           },
                //           icon: "map".toSVGSized(24, color: cc.black4))),
                // ],
              ),
              body: SafeArea(
                child: Container(
                  clipBehavior: Clip.none,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        sizedBox20(),
                        Expanded(
                            child: categoryController
                                        .categoryDataModel.categories?.length ==
                                    0
                                ? Container(
                                    alignment: Alignment.center,
                                    height: screenHeight - 140,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          "assets/images/nodata.png",
                                          fit: BoxFit.contain,
                                        ),
                                        Gap(10),
                                        Text(AppLocalizations.of(context)!
                                            .noServiceProviderInYourArea),
                                      ],
                                    ),
                                  )
                                : ValueListenableBuilder<bool>(
                                    valueListenable: viewMap,
                                    builder: (context, map, _) => map
                                        ? HomeMapView()
                                        : const sb.SearchBar())),
                      ]),
                ),
              )),
        );
      },
    ));
  }
}
