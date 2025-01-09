import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/helper/extension/widget_extension.dart';
import 'package:qixer/service/app_string_service.dart';
import 'package:qixer/service/common_service.dart';
import 'package:qixer/service/filter_services_service.dart';
import 'package:qixer/service/home_services/slider_service.dart';
import 'package:qixer/view/home/categories/all_categories_page.dart';
import 'package:qixer/view/home/components/categories.dart';
import 'package:qixer/view/home/components/recent_jobs.dart';
import 'package:qixer/view/home/components/recent_services.dart';
import 'package:qixer/view/home/components/slider_home.dart';
import 'package:qixer/view/home/components/top_rated_services.dart';
import 'package:qixer/view/home/homepage_helper.dart';
import 'package:qixer/view/search/service_filter_model.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/responsive.dart';

import '../utils/constant_styles.dart';
import 'components/home_app_bar.dart';
import 'components/section_title.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    super.initState();
    setChatSellerId(null);
    runAtHome(context);
  }

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();
    return Listener(
      onPointerDown: (_) {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.focusedChild?.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leadingWidth: 0,
          title: HomeAppBar(cc: cc),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: physicsCommon,
            child: Consumer<AppStringService>(
              builder: (context, asProvider, child) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 24,
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (value) {
                        HomepageHelper.tabIndex.value = 3;
                        Provider.of<FilterServicesService>(context,
                                listen: false)
                            .resetFilters(st: value);
                        ServiceFilterViewModel
                            .instance.searchTextController.text = value;
                      },
                      decoration: InputDecoration(
                          hintText: asProvider.getString("Search services"),
                          prefixIcon: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.search,
                                color: Color.fromARGB(255, 126, 126, 126),
                                size: 22,
                              ),
                            ],
                          )),
                    ).hp20,
                    // Container(
                    //   padding: const EdgeInsets.symmetric(horizontal: 25),
                    //   margin: const EdgeInsets.only(bottom: 15),
                    //   child: InkWell(
                    //       onTap: () {
                    //         Provider.of<SearchBarWithDropdownService>(context,
                    //                 listen: false)
                    //             .resetSearchParams();
                    //         Provider.of<SearchBarWithDropdownService>(context,
                    //                 listen: false)
                    //             .fetchService(context);
                    //         Navigator.push(
                    //             context,
                    //             PageTransition(
                    //                 type: PageTransitionType.rightToLeft,
                    //                 child: SearchBarPageWithDropdown(
                    //                   cc: cc,
                    //                 )));
                    //       },
                    //       child:
                    //           HomepageHelper().searchbar(asProvider, context)),
                    // ),

                    const SizedBox(
                      height: 10,
                    ),
                    CommonHelper().dividerCommon(),
                    const SizedBox(
                      height: 25,
                    ),

                    //Slider
                    Consumer<SliderService>(
                        builder: (context, provider, child) => provider
                                .sliderImageList.isNotEmpty
                            ? SliderHome(
                                cc: cc,
                                sliderDetailsList: provider.sliderDetailsList,
                                sliderImageList: provider.sliderImageList,
                              )
                            : Container()),

                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //see all ============>
                          const SizedBox(
                            height: 25,
                          ),

                          SectionTitle(
                            cc: cc,
                            title: asProvider.getString('Browse categories'),
                            pressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      const AllCategoriesPage(),
                                ),
                              );
                            },
                          ),

                          const SizedBox(
                            height: 18,
                          ),

                          //Categories =============>
                          Categories(
                            cc: cc,
                            asProvider: asProvider,
                          ),

                          //Top rated sellers ========>

                          TopRatedServices(
                            cc: cc,
                            asProvider: asProvider,
                          ),

                          //Recent service ========>

                          RecentServices(
                            cc: cc,
                            asProvider: asProvider,
                          ),

                          //Discount images
                          const RecentJobs(),

                          sizedBoxCustom(30)
                        ],
                      ),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
