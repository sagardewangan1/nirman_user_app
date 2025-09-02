import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:qixer/helper/extension/widget_extension.dart';
import 'package:qixer/service/app_string_service.dart';
import 'package:qixer/service/cityAndAreaController/cityAndAreaController.dart';
import 'package:qixer/service/filter_services_service.dart';
import 'package:qixer/service/home_services/category_service.dart';
import 'package:qixer/service/home_services/landingPageService.dart';
import 'package:qixer/service/home_services/recent_services_service.dart';
import 'package:qixer/service/home_services/slider_service.dart';
import 'package:qixer/service/home_services/top_rated_services_service.dart';
import 'package:qixer/service/jobs_service/recent_jobs_service.dart';
import 'package:qixer/service/leadsController/leadsController.dart';
import 'package:qixer/service/permissions_service.dart';
import 'package:qixer/service/profile_service.dart';
import 'package:qixer/service/vendorDashboardService/vendorDashboardService.dart';
import 'package:qixer/view/VenderDashBoard/subscriptionModule.dart';
import 'package:qixer/view/home/components/categories.dart';
import 'package:qixer/view/home/components/location_section.dart';
import 'package:qixer/view/home/components/recent_services.dart';
import 'package:qixer/view/home/components/slider_home.dart';
import 'package:qixer/view/search/service_filter_model.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:qixer/view/utils/responsive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/constant_styles.dart';
import '../utils/custom_input.dart';
import 'components/home_app_bar.dart';
import 'package:qixer/generated/app_localizations.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((_) => firstLoad());
  }

  bool isLoggedIn = false;
  Future<void> firstLoad() async {
    if (!mounted) return;

    final pref = await SharedPreferences.getInstance();
    userType = pref.getString('shashaktnirmanusertype') ?? '';
    isLoggedIn = pref.getBool('shashaktnirman_is_logged_in') ?? false;

    final recentJobs = Provider.of<RecentJobsService>(context, listen: false);
    final sliderService = Provider.of<SliderService>(context, listen: false);
    final areaCtrlService =
        Provider.of<CityAndAreaController>(context, listen: false);
    final recentService =
        Provider.of<RecentServicesService>(context, listen: false);
    final topRatedService =
        Provider.of<TopRatedServicesSerivce>(context, listen: false);
    final catService = Provider.of<CategoryService>(context, listen: false);
    final permService = Provider.of<PermissionsService>(context, listen: false);
    final profileService = Provider.of<ProfileService>(context, listen: false);
    final vendorDashboard =
        Provider.of<VendorDashboardService>(context, listen: false);

    // Prepare Futures (wrap void-return to Future<void> via `() async {…}`)
    final futures = <Future<void>>[
      recentJobs.fetchAllCities(context),
      sliderService.loadSlider(),
      () async {
        final cityId = areaCtrlService.cityId.toString();
        await recentService.fetchRecentService(
            context: context, areaID: cityId);
        await catService.fetchCategory(location_id: cityId);
      }(),
      permService.fetchUserPermissions(context),
      profileService.getProfileDetails(context: context),
      vendorDashboard.getSubscriptions(),
      topRatedService.fetchTopService(),
    ];
    await Future.wait(futures);
  }

  // Future<void> showLocationBottomSheet(BuildContext context) async {
  //   showModalBottomSheet(
  //     backgroundColor: Colors.transparent,
  //     isScrollControlled: true,
  //     enableDrag: true,
  //     context: context,
  //     builder: (contextSheet) {
  //       bool isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
  //       // Adjust min and max sizes based on whether the keyboard is visible
  //       double minChildSize = isKeyboardVisible
  //           ? 0.3
  //           : 0.5; // Reduce min size when keyboard is visible
  //       double maxChildSize =
  //           isKeyboardVisible ? 0.8 : 0.9; // Adjust max size accordingly
  //       return DraggableScrollableSheet(
  //         snap: true,
  //         initialChildSize: 0.5,
  //         maxChildSize: maxChildSize,
  //         minChildSize: minChildSize,
  //         // expand: true,
  //         builder: (context, scrollController) {
  //           return const LocationSheet2();
  //         },
  //       );
  //     },
  //   );
  // }

  Future<void> showLocationBottomSheet2(BuildContext context) async {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      isScrollControlled: true,
      enableDrag: true,
      context: context,
      builder: (contextSheet) {
        return SizedBox(
          height: 270,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Consumer<CityAndAreaController>(
              builder: (context, cityAndAreaProvider, child) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(15),
                  CommonHelper()
                      .labelCommon2(AppLocalizations.of(context)!.chooseState),
                  Gap(8),
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20)),
                        ),
                        builder: (context) {
                          return const StateBottomSheetCard();
                        },
                      );
                    },
                    child: Container(
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(width: 1, color: cc.black5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              textAlign: TextAlign.left,
                              cityAndAreaProvider.stateName.toString(),
                              style: TextStyle(
                                fontSize: 14,
                                color: cc.black6,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Icon(
                              Icons.keyboard_arrow_down_sharp,
                              size: 22,
                              color: cc.black6,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Gap(15),
                  CommonHelper()
                      .labelCommon2(AppLocalizations.of(context)!.chooseArea),
                  Gap(8),
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20)),
                        ),
                        builder: (context) {
                          return const CityBottomSheetCard();
                        },
                      );
                    },
                    child: Container(
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(width: 1, color: cc.black5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              textAlign: TextAlign.left,
                              cityAndAreaProvider.cityName ??
                                  AppLocalizations.of(context)!.chooseCity,
                              style: TextStyle(
                                fontSize: 14,
                                color: cc.black6,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Icon(
                              Icons.keyboard_arrow_down_sharp,
                              size: 22,
                              color: cc.black6,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Gap(15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            context.read<CityAndAreaController>().resetAll();
                            Provider.of<CategoryService>(context, listen: false)
                                .fetchCategory(location_id: '');
                            Provider.of<RecentServicesService>(context,
                                    listen: false)
                                .recentServiceMap
                                .clear();
                            Provider.of<RecentServicesService>(context,
                                    listen: false)
                                .fetchRecentService(
                                    context: context, areaID: '');
                            Navigator.pop(context);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(width: 1, color: cc.black5),
                                color: cc.white),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 3.0),
                              child: Text(
                                textAlign: TextAlign.center,
                                AppLocalizations.of(context)!.clearFilter,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: cc.black5),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Gap(10),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            String? locationId =
                                Provider.of<CityAndAreaController>(context,
                                            listen: false)
                                        .cityId
                                        .toString() ??
                                    '';
                            Provider.of<CategoryService>(context, listen: false)
                                .categoryDataModel
                                .categories
                                ?.clear();
                            Provider.of<RecentServicesService>(context,
                                    listen: false)
                                .recentServiceMap
                                .clear();
                            Provider.of<CategoryService>(context, listen: false)
                                .fetchCategory(location_id: locationId);
                            Provider.of<RecentServicesService>(context,
                                    listen: false)
                                .fetchRecentService(
                                    context: context, areaID: locationId);
                            Navigator.pop(context);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: cc.primaryColor),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 3.0),
                              child: Text(
                                textAlign: TextAlign.center,
                                AppLocalizations.of(context)!.applyFilter,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: cc.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    // runAtHome(context);
    firstLoad();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();
    final vendorDashboard = Provider.of<VendorDashboardService>(context);
    final categoryController = Provider.of<CategoryService>(context);
    final landingPageService = Provider.of<LandingPageService>(context);
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
              userType: userType,
              totalUnreadLeads: context
                      .read<LeadsController>()
                      .myLeadsDataModel
                      .newLeads
                      .toString() ??
                  "0",
              cc: cc,
              onTapLocation: () {
                showLocationBottomSheet2(context).whenComplete(
                  () {
                    Provider.of<CategoryService>(context, listen: false)
                        .fetchCategory(
                            location_id: Provider.of<CityAndAreaController>(
                                        context,
                                        listen: false)
                                    .cityId
                                    ?.toString() ??
                                '');
                  },
                );
              },
              isLoggedIn: isLoggedIn ? true : false,
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: categoryController.isLoading
                  ? Padding(
                      padding: const EdgeInsets.all(50.0),
                      child: Center(
                        child: OthersHelper().showLoading(cc.primaryColor),
                      ),
                    )
                  : categoryController.categoryDataModel.categories?.length != 0
                      ? Consumer<AppStringService>(
                          builder: (context, asProvider, child) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AnimatedContainer(
                                  duration: Duration(
                                      milliseconds: 800), // Animation Duration
                                  height: (userType == "0" &&
                                          vendorDashboard.isSubscribed == false)
                                      ? 100
                                      : 0,
                                  width: double.infinity,
                                  curve: Curves.easeInOut, // Smooth Animation
                                  child: (userType == "0" &&
                                          vendorDashboard.isSubscribed == false)
                                      ? Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      SubscriptionModule(
                                                    navFrom: "Home",
                                                  ),
                                                ),
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    "https://sashaktnirmaan.com/assets/subscription.gif",
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        )
                                      : SizedBox
                                          .shrink(), // Hide when height is 0
                                ),
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
                                        ? landingPageService.setTabIndex(2)
                                        : landingPageService.setTabIndex(3),
                                    textInputAction: TextInputAction.done,
                                    onFieldSubmitted: (value) {
                                      landingPageService.setTabIndex(3);
                                      Provider.of<FilterServicesService>(
                                              context,
                                              listen: false)
                                          .resetFilters(st: value);
                                      ServiceFilterViewModel.instance
                                          .searchTextController.text = value;
                                    },
                                    decoration: InputDecoration(
                                      hintText: AppLocalizations.of(context)!
                                          .searchServices,
                                      prefixIcon: const Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.search,
                                            color: Color.fromARGB(
                                                255, 126, 126, 126),
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
                                    builder: (context, provider, child) =>
                                        provider.sliderImageList2.isNotEmpty
                                            ? SliderHome2(
                                                cc: cc,
                                                sliderDetailsList:
                                                    provider.sliderDetailsList2,
                                                sliderImageList:
                                                    provider.sliderImageList2,
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
                                        int categoryLength = value
                                                .categoryDataModel
                                                .categories
                                                ?.length ??
                                            0;

                                        return categoryLength > 3
                                            ? Center(
                                                child: InkWell(
                                                  onTap: () => value
                                                      .setExpanded(), // Toggle expanded state,
                                                  child: Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.5,
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                      color: cc.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                      border: Border.all(
                                                          width: 1,
                                                          color: cc.black3),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              3.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          RotatedBox(
                                                            quarterTurns:
                                                                value.isExpanded
                                                                    ? 2
                                                                    : 0,
                                                            child: ClipOval(
                                                              child:
                                                                  Image.network(
                                                                height: 25,
                                                                width: 25,
                                                                loadMoreGif,
                                                              ),
                                                            ),
                                                          ),
                                                          Text(
                                                            value.isExpanded
                                                                ? AppLocalizations.of(
                                                                        context)!
                                                                    .showLessCategory
                                                                : AppLocalizations.of(
                                                                        context)!
                                                                    .showMoreCategory,
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
                                            : Offstage(); // Hide if categories are 3 or less
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
                                        builder: (context, provider, child) =>
                                            provider.sliderImageList.isNotEmpty
                                                ? SliderHome(
                                                    cc: cc,
                                                    sliderDetailsList: provider
                                                        .sliderDetailsList,
                                                    sliderImageList: provider
                                                        .sliderImageList,
                                                  )
                                                : Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Offstage(),
                                                  )),
                                    // Top booked services ========>
                                    // Padding(
                                    //   padding: const EdgeInsets.symmetric(horizontal: 15),
                                    //   child: TopRatedServices(
                                    //     cc: cc,
                                    //     asProvider: asProvider,
                                    //   ),
                                    // ),
                                    // Featured Services ========>
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: RecentServices(
                                        cc: cc,
                                        asProvider: asProvider,
                                      ),
                                    ),
                                    // Discount images
                                    // Padding(
                                    //   padding: const EdgeInsets.symmetric(horizontal: 15),
                                    //   child: const RecentJobs(),
                                    // ),
                                    const SizedBox(
                                      height: 18,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: TopServiceSection(
                                        asProvider: asProvider,
                                      ),
                                    ),
                                    sizedBoxCustom(30)
                                  ],
                                ),
                              ]),
                        )
                      : Container(
                          alignment: Alignment.center,
                          height: screenHeight - 140,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
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
                        )),
        ),
      ),
    );
  }
}

class StateBottomSheetCard extends StatefulWidget {
  const StateBottomSheetCard({super.key});

  @override
  State<StateBottomSheetCard> createState() => _StateBottomSheetCardState();
}

class _StateBottomSheetCardState extends State<StateBottomSheetCard> {
  final RefreshController refreshController =
      RefreshController(initialRefresh: true);
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Reset state on first load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CityAndAreaController>(context, listen: false)
          .resetPagination();
    });
  }

  @override
  void dispose() {
    refreshController.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cityAreaController = Provider.of<CityAndAreaController>(context);
    final ConstantColors cc = ConstantColors();

    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(15),
          CommonHelper()
              .labelCommon2(AppLocalizations.of(context)!.chooseState),
          Gap(8),
          CustomInput(
            controller: searchController,
            hintText: 'Search state',
            paddingHorizontal: 0,
            icon: 'assets/icons/search.png',
            onChanged: (value) {
              cityAreaController.setSearchQuery(value);

              Future.delayed(Duration(milliseconds: 500), () {
                if (value.isEmpty) {
                  // Jab input empty ho jaye, pura list reset karega
                  cityAreaController.resetPagination();
                  cityAreaController.fetchState(context);
                } else if (value == cityAreaController.searchQuery) {
                  cityAreaController.searchState(context);
                }
              });
            },
          ),
          Gap(10),
          Expanded(
            child: SmartRefresher(
              controller: refreshController,
              enablePullDown: true,
              enablePullUp: cityAreaController.hasMorePages(),
              onRefresh: () async {
                print("Refreshing data...");
                cityAreaController.resetPagination();
                final result = await cityAreaController.fetchState(context);
                if (result) {
                  print("Refresh completed");
                  refreshController.refreshCompleted();
                } else {
                  print("Refresh failed");
                  refreshController.refreshFailed();
                }
              },
              onLoading: () async {
                print("Loading more data...");
                cityAreaController.nextPage();
                final result = await cityAreaController.fetchState(context);
                if (result) {
                  print("Loading completed");
                  refreshController.loadComplete();
                } else {
                  print("No more data");
                  refreshController.loadNoData();
                }
              },
              header: const WaterDropHeader(),
              footer: ClassicFooter(
                loadingText: "Loading more states...",
                noDataText: "No more states available",
                failedText: "Failed to load states",
                canLoadingText: "Release to load more",
                idleText: "Pull up to load more",
              ),
              child: cityAreaController.myState.isEmpty
                  ? Center(
                      child: cityAreaController.isLoading
                          ? CircularProgressIndicator(color: cc.primaryColor)
                          : Text("No states found",
                              style: TextStyle(color: cc.greyParagraph)),
                    )
                  : ListView.separated(
                      itemCount: cityAreaController.myState.length,
                      separatorBuilder: (context, index) => Divider(
                        color: Colors.grey.withOpacity(0.3),
                        thickness: 1,
                        height: 1,
                      ),
                      itemBuilder: (context, index) {
                        final state = cityAreaController.myState[index];
                        return ListTile(
                          title: Text(
                            state.serviceCity ?? '',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: cc.greyParagraph,
                            ),
                          ),
                          onTap: () {
                            cityAreaController.setStateNameAndID(
                              stateId: state.id,
                              stateName: state.serviceCity ?? 'Unknown State',
                            );
                            cityAreaController.fetchArea(context);
                            Navigator.pop(context);
                          },
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

//  area

class CityBottomSheetCard extends StatefulWidget {
  const CityBottomSheetCard({super.key});

  @override
  State<CityBottomSheetCard> createState() => _CityBottomSheetCardState();
}

class _CityBottomSheetCardState extends State<CityBottomSheetCard> {
  final RefreshController refreshController =
      RefreshController(initialRefresh: true);
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Reset state on first load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CityAndAreaController>(context, listen: false)
          .resetPagination();
    });
  }

  @override
  void dispose() {
    refreshController.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cityAreaController = Provider.of<CityAndAreaController>(context);
    final ConstantColors cc = ConstantColors();

    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(15),
          CommonHelper().labelCommon2(AppLocalizations.of(context)!.chooseArea),
          Gap(8),
          CustomInput(
            controller: searchController,
            hintText: 'Search state',
            paddingHorizontal: 0,
            icon: 'assets/icons/search.png',
            onChanged: (value) {
              cityAreaController.setSearchQuery(value);

              Future.delayed(Duration(milliseconds: 500), () {
                if (value.isEmpty) {
                  // Jab input empty ho jaye, pura list reset karega
                  cityAreaController.resetPagination();
                  cityAreaController.fetchArea(context);
                } else if (value == cityAreaController.searchQuery) {
                  cityAreaController.searchArea(context);
                }
              });
            },
          ),
          Gap(10),
          Expanded(
            child: SmartRefresher(
              controller: refreshController,
              enablePullDown: true,
              enablePullUp: cityAreaController.hasMorePages(),
              onRefresh: () async {
                print("Refreshing data...");
                cityAreaController.resetPagination();
                final result = await cityAreaController.fetchArea(context);
                if (result) {
                  print("Refresh completed");
                  refreshController.refreshCompleted();
                } else {
                  print("Refresh failed");
                  refreshController.refreshFailed();
                }
              },
              onLoading: () async {
                print("Loading more data...");
                cityAreaController.nextPage();
                final result = await cityAreaController.fetchArea(context);
                if (result) {
                  print("Loading completed");
                  refreshController.loadComplete();
                } else {
                  print("No more data");
                  refreshController.loadNoData();
                }
              },
              header: const WaterDropHeader(),
              footer: ClassicFooter(
                loadingText: "Loading more states...",
                noDataText: "No more states available",
                failedText: "Failed to load states",
                canLoadingText: "Release to load more",
                idleText: "Pull up to load more",
              ),
              child: cityAreaController.myCity.isEmpty
                  ? Center(
                      child: cityAreaController.isLoading
                          ? CircularProgressIndicator(color: cc.primaryColor)
                          : Text("No states found",
                              style: TextStyle(color: cc.greyParagraph)),
                    )
                  : ListView.separated(
                      itemCount: cityAreaController.myCity.length,
                      separatorBuilder: (context, index) => Divider(
                        color: Colors.grey.withOpacity(0.3),
                        thickness: 1,
                        height: 1,
                      ),
                      itemBuilder: (context, index) {
                        final area = cityAreaController.myCity[index];
                        return ListTile(
                          title: Text(
                            area.serviceArea ?? '',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: cc.greyParagraph,
                            ),
                          ),
                          onTap: () {
                            cityAreaController.setCityNameAndID(
                              cityID: area.id,
                              cityName: area.serviceArea ?? 'Unknown Area',
                            );
                            cityAreaController.fetchArea(context);
                            Navigator.pop(context);
                          },
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
