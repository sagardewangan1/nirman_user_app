import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/helper/extension/widget_extension.dart';
import 'package:qixer/service/app_string_service.dart';
import 'package:qixer/service/common_service.dart';
import 'package:qixer/service/filter_services_service.dart';
import 'package:qixer/service/home_services/category_service.dart';
import 'package:qixer/service/home_services/slider_service.dart';
import 'package:qixer/view/home/components/categories.dart';
import 'package:qixer/view/home/components/location_section.dart';
import 'package:qixer/view/home/components/recent_jobs.dart';
import 'package:qixer/view/home/components/recent_services.dart';
import 'package:qixer/view/home/components/slider_home.dart';
import 'package:qixer/view/home/components/top_rated_services.dart';
import 'package:qixer/view/home/homepage_helper.dart';
import 'package:qixer/view/search/service_filter_model.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:qixer/view/utils/responsive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../search/components/location_sheet.dart';
import '../utils/constant_styles.dart';
import 'components/home_app_bar.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String? userType;
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setChatSellerId(null);

    firstLoad();
  }

  firstLoad() async {
    final pref = await SharedPreferences.getInstance();
    userType = pref.getString("shashaktnirmanusertype");
    print("userType =====> $userType ${userType.runtimeType}");
    if (!mounted) false;
    runAtHome(context);
    setState(() {});
  }

  void showLocationBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      enableDrag: true,
      context: context,
      builder: (contextSheet) {
        bool isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
        // Adjust min and max sizes based on whether the keyboard is visible
        double minChildSize = isKeyboardVisible
            ? 0.3
            : 0.5; // Reduce min size when keyboard is visible
        double maxChildSize =
            isKeyboardVisible ? 0.8 : 0.9; // Adjust max size accordingly
        return DraggableScrollableSheet(
          snap: true,
          initialChildSize: 0.5,
          maxChildSize: maxChildSize,
          minChildSize: minChildSize,
          // expand: true,
          builder: (context, scrollController) {
            return const LocationSheet2();
          },
        );
      },
    );
  }

  @override
  void dispose() {
    runAtHome(context);
    super.dispose();
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
        // backgroundColor: Colors.grey.shade50,
        appBar: AppBar(
          // backgroundColor: Color(0xFFF5F5FF),
          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: HomeAppBar(
              cc: cc,
              onTapLocation: () => showLocationBottomSheet(context),
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: physicsCommon,
            child: Consumer<AppStringService>(
              builder: (context, asProvider, child) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: cc.white,
                          borderRadius: BorderRadius.circular(8.0)),
                      child: TextFormField(
                        readOnly: true,
                        onTap: () => userType == '1'
                            ? HomepageHelper.tabIndex.value = 2
                            : HomepageHelper.tabIndex.value = 3,
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
                          ),
                        ),
                      ),
                    ).hp15,
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
                    // SizedBox(
                    //   height: userType != null && userType == '0' ? 10 : 0,
                    // ),
                    // userType != null && userType == '0'
                    //     ? Padding(
                    //         padding: EdgeInsets.symmetric(horizontal: 15),
                    //         child: CommonHelper().buttonOrange(
                    //             "Go TO DASHBOARD",
                    //             () => context.toPage(VendorDashBoardVies())),
                    //       )
                    //     : Offstage(),
                    const SizedBox(
                      height: 10,
                    ),
                    //Slider top
                    Consumer<SliderService>(
                        builder: (context, provider, child) => provider
                                .sliderImageList2.isNotEmpty
                            ? SliderHome2(
                                cc: cc,
                                sliderDetailsList: provider.sliderDetailsList2,
                                sliderImageList: provider.sliderImageList2,
                              )
                            : Offstage()),
                    const SizedBox(
                      height: 10,
                    ),

                    // CommonHelper().dividerCommon(),
                    // const SizedBox(
                    //   height: 25,
                    // ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        //see all ============>
                        // const SizedBox(
                        //   height: 25,
                        // ),

                        // Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 12),
                        //   child: SectionTitle(
                        //     cc: cc,
                        //     title: asProvider.getString('Browse categories'),
                        //     pressed: () {
                        //       Navigator.push(
                        //         context,
                        //         MaterialPageRoute<void>(
                        //           builder: (BuildContext context) =>
                        //               const AllCategoriesPage(),
                        //         ),
                        //       );
                        //     },
                        //   ),
                        // ),
                        //
                        // const SizedBox(
                        //   height: 18,
                        // ),

                        //Categories =============>
                        CategoriesMain(
                          cc: cc,
                          asProvider: asProvider,
                        ),

                        Consumer<CategoryService>(
                          builder: (context, value, child) {
                            return value.categoryDataModel.categories != null ||
                                    (value.categoryDataModel.categories
                                                ?.length ??
                                            0) >
                                        3
                                ? value.categoryDataModel.categories != 'error'
                                    ? Center(
                                        child: InkWell(
                                          onTap: () => value
                                              .setExpanded(), // Toggle expanded state,
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.5,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: cc.white,
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                border: Border.all(
                                                    width: 1,
                                                    color: cc.black3)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(3.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  RotatedBox(
                                                    quarterTurns:
                                                        value.isExpanded
                                                            ? 2
                                                            : 0,
                                                    child: ClipOval(
                                                      child: Image.network(
                                                          height: 25,
                                                          width: 25,
                                                          loadMoreGif),
                                                    ),
                                                  ),
                                                  Text(
                                                    value.isExpanded
                                                        ? "Show Less Category"
                                                        : "Show More Category",
                                                    style: TextStyle(
                                                      color: cc.black3,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Offstage()
                                : Offstage();
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        //
                        // Consumer<CategoryService>(
                        //   builder: (context, value, child) {
                        //     return value.categories != null
                        //         ? value.categories != 'error'
                        //             ? Center(
                        //                 child: TextButton(
                        //                   onPressed: () {
                        //                     value
                        //                         .setExpanded(); // Toggle expanded state
                        //                   },
                        //                   child: Text(
                        //                     value.isExpanded
                        //                         ? "Show Less Category"
                        //                         : "Show More Category",
                        //                     style: TextStyle(
                        //                       color: cc.primaryColor,
                        //                       fontSize: 16,
                        //                     ),
                        //                   ),
                        //                 ),
                        //               )
                        //             : Text(asProvider
                        //                 .getString('Something went wrong'))
                        //         : OthersHelper().showLoading(cc.primaryColor);
                        //   },
                        // ),
                        CommonHelper().dividerCommon(),
                        const SizedBox(
                          height: 10,
                        ),
                        //Slider main
                        Consumer<SliderService>(
                            builder: (context, provider, child) => provider
                                    .sliderImageList.isNotEmpty
                                ? SliderHome(
                                    cc: cc,
                                    sliderDetailsList:
                                        provider.sliderDetailsList,
                                    sliderImageList: provider.sliderImageList,
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Offstage(),
                                  )),
                        // Top booked services ========>
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: TopRatedServices(
                            cc: cc,
                            asProvider: asProvider,
                          ),
                        ),
                        // Featured Services ========>
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: RecentServices(
                            cc: cc,
                            asProvider: asProvider,
                          ),
                        ),
                        // Discount images
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: const RecentJobs(),
                        ),

                        const SizedBox(
                          height: 18,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: LocationSection(
                            asProvider: asProvider,
                          ),
                        ),
                        sizedBoxCustom(30)
                      ],
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
