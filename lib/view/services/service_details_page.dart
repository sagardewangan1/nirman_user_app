import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/all_services_service.dart';
import 'package:qixer/service/app_string_service.dart';
import 'package:qixer/service/service_details_service.dart';
import 'package:qixer/view/services/components/about_seller_tab.dart';
import 'package:qixer/view/services/components/image_big.dart';
import 'package:qixer/view/services/components/overview_tab.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/login_or_register.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/common_helper.dart';
import 'components/service_details_top.dart';
import 'package:qixer/generated/app_localizations.dart';

class ServiceDetailsPage extends StatefulWidget {
  final String? serviceId;
  const ServiceDetailsPage({
    super.key,
    this.serviceId,
  });

  // final serviceId;

  @override
  State<ServiceDetailsPage> createState() => _ServiceDetailsPageState();
}

class _ServiceDetailsPageState extends State<ServiceDetailsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _tabIndex = 0;
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  bool isLoggedIn = false;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabSelection);

    // Provider.of<ServiceDetailsService>(context, listen: false)
    //     .fetchServiceDetails(widget.serviceId);

    Provider.of<AllServicesService>(context, listen: false)
        .fetchCategories(context);
    firstLoad();
    super.initState();
  }

  _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {
        _tabIndex = _tabController.index;
      });
    }
  }

  firstLoad() async {
    if (mounted) {
      final prefs = await SharedPreferences.getInstance();
      isLoggedIn = prefs.getBool("shashaktnirman_is_logged_in") ?? false;
      setState(() {});
    }
  }

  @override
  void didChangeDependencies() {
    firstLoad();
    super.didChangeDependencies();
  }

  int currentTab = 0;

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();
    return Scaffold(
      // backgroundColor: Colors.white,
      body: Consumer<AppStringService>(
        builder: (context, asProvider, child) =>
            Consumer<ServiceDetailsService>(
          builder: (context, provider, child) => provider.isloading == false
              ? provider.serviceDetailsModel.serviceDetails != null
                  ? Column(
                      children: [
                        Expanded(
                          child: ListView(
                            padding: EdgeInsets.zero,
                            children: [
                              Column(
                                children: [
                                  // Image big
                                  ImageBig(
                                    fit: BoxFit.fill,
                                    serviceName: provider.serviceDetailsModel
                                        .serviceDetails?.title,
                                    imageLink: provider
                                                .serviceDetailsModel
                                                .serviceDetails
                                                ?.sellerForMobile
                                                .sellerBusinessImg !=
                                            null
                                        ? provider
                                                .serviceDetailsModel
                                                .serviceDetails
                                                ?.sellerForMobile
                                                .sellerBusinessImg ??
                                            placeHolderUrl2
                                        : placeHolderUrl2,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  //Top part
                                  ServiceDetailsTop(cc: cc),
                                ],
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  // borderRadius: BorderRadius.circular(8.0)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      TabBar(
                                        tabAlignment: TabAlignment.start,
                                        onTap: (value) {
                                          setState(() {
                                            currentTab = value;
                                          });
                                        },
                                        padding: EdgeInsets.zero,
                                        labelColor: cc.primaryColor,
                                        unselectedLabelColor: cc.greyFour,
                                        indicatorColor: cc.primaryColor,
                                        unselectedLabelStyle: TextStyle(
                                            color: cc.greyParagraph,
                                            fontWeight: FontWeight.normal),
                                        controller: _tabController,
                                        isScrollable: true,
                                        tabs: [
                                          Tab(
                                              text:
                                                  AppLocalizations.of(context)!
                                                      .overview),
                                          Tab(
                                              text:
                                                  AppLocalizations.of(context)!
                                                      .aboutContractor),
                                          // Tab(
                                          //     text: asProvider
                                          //         .getString('Review')),
                                          // Tab(
                                          //     text: asProvider
                                          //         .getString('Price Chart')),
                                          // Tab(
                                          //     text: asProvider
                                          //         .getString('Services')),
                                          // Tab(
                                          //     text: asProvider
                                          //         .getString('Photos')),
                                        ],
                                      ),
                                      Container(
                                        child: [
                                          OverviewTab(
                                            provider: provider,
                                          ),
                                          AboutSellerTab(
                                            provider: provider,
                                          ),
                                          // ReviewTab(
                                          //   provider: provider,
                                          // ),
                                          // MemberShipTabs(
                                          //   desc: points,
                                          //   cc: cc,
                                          // ),
                                          // MoreServicesTab(
                                          //   provider: provider,
                                          // ),
                                          // PhotosTabs(
                                          //   provider: provider,
                                          // ),
                                        ][_tabIndex],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        //Book now button
                        CommonHelper().dividerCommon(),
                        //Button
                        // sizedBox20(),
                      ],
                    )
                  :
                  ////
                  isLoggedIn == false
                      ? const LoginOrRegister()
                      : Container(
                          alignment: Alignment.center,
                          child: Text(
                              AppLocalizations.of(context)!.somethingWentWrong),
                        )
              : OthersHelper().showLoading(cc.primaryColor),
        ),
      ),
      bottomNavigationBar: isLoggedIn == false
          ? Offstage()
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: 400, // Set maximum width for the dialog
                              maxHeight:
                                  300, // Set maximum height for the dialog
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(20.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                color: Colors.white,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.thankYou,
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Divider(color: Colors.grey.shade300),
                                  Text(
                                    textAlign: TextAlign.center,
                                    AppLocalizations.of(context)!
                                        .thankYouEnquiryText,
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Image.network(
                                      height: 85,
                                      width: 85,
                                      "https://i.postimg.cc/fbKmxjYg/pngwing-com-1.png"),
                                  const SizedBox(height: 8),
                                  // Text(
                                  //   textAlign:
                                  //       TextAlign.center,
                                  //     "Tap OK to chat, or tap Cancel to dismiss.",
                                  //   style: TextStyle(
                                  //       fontSize: 14,
                                  //       fontWeight:
                                  //           FontWeight
                                  //               .w500),
                                  // ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      // ElevatedButton(
                                      //   onPressed: () {
                                      //     Navigator.pop(
                                      //         context);
                                      //   },
                                      //   style:
                                      //       ElevatedButton
                                      //           .styleFrom(
                                      //     backgroundColor:
                                      //         Colors
                                      //             .redAccent,
                                      //   ),
                                      //   child: const Text(
                                      //       'Cancel'),
                                      // ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          // Add your additional action here
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.blueAccent,
                                        ),
                                        child: Text(
                                            AppLocalizations.of(context)!.ok),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                      height: 65,
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * 0.2,
                      decoration: BoxDecoration(
                          color: cc.primaryColor,
                          borderRadius: BorderRadius.circular(12.0)),
                      child: Text(
                        "Enquiry Now",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, color: cc.white),
                      )),
                ),
              ),
            ),
    );
  }
}

class ServiceDetailsChatIcon extends StatelessWidget {
  const ServiceDetailsChatIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cc = ConstantColors();

    return Consumer<ServiceDetailsService>(
      builder: (context, provider, child) => InkWell(
        onTap: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          var currentUserId = prefs.getInt('userId')!;
        },
        child: Container(
          padding: const EdgeInsets.only(left: 13, bottom: 6, top: 6),
          child: Icon(
            Icons.message_outlined,
            size: 40,
            color: cc.greyFour,
          ),
        ),
      ),
    );
  }
}
