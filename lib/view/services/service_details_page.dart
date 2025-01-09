import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/app_string_service.dart';
import 'package:qixer/service/booking_services/book_service.dart';
import 'package:qixer/service/push_notification_service.dart';
import 'package:qixer/service/service_details_service.dart';
import 'package:qixer/view/booking/service_personalization_page.dart';
import 'package:qixer/view/live_chat/chat_message_page.dart';
import 'package:qixer/view/services/components/about_seller_tab.dart';
import 'package:qixer/view/services/components/image_big.dart';
import 'package:qixer/view/services/components/overview_tab.dart';
import 'package:qixer/view/services/components/review_tab.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/constant_styles.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../service/booking_services/personalization_service.dart';
import '../utils/common_helper.dart';
import 'components/service_details_top.dart';

class ServiceDetailsPage extends StatefulWidget {
  const ServiceDetailsPage({
    super.key,
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

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabSelection);

    // Provider.of<ServiceDetailsService>(context, listen: false)
    //     .fetchServiceDetails(widget.serviceId);
    super.initState();
  }

  _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {
        _tabIndex = _tabController.index;
      });
    }
  }

  int currentTab = 0;

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<AppStringService>(
        builder: (context, asProvider, child) =>
            Consumer<ServiceDetailsService>(
          builder: (context, provider, child) => provider.isloading == false
              ? provider.serviceAllDetails != 'error' &&
                      provider.serviceAllDetails != null
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
                                    serviceName:
                                        asProvider.getString('Service Name'),
                                    imageLink: provider.serviceAllDetails
                                                ?.serviceImage !=
                                            null
                                        ? provider.serviceAllDetails
                                                .serviceImage.imgUrl ??
                                            placeHolderUrl
                                        : placeHolderUrl,
                                  ),

                                  const SizedBox(
                                    height: 15,
                                  ),

                                  //Top part
                                  ServiceDetailsTop(cc: cc),
                                ],
                              ),
                              Container(
                                color: Colors.white,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                margin:
                                    const EdgeInsets.only(top: 20, bottom: 20),
                                child: Column(
                                  children: <Widget>[
                                    TabBar(
                                      onTap: (value) {
                                        setState(() {
                                          currentTab = value;
                                        });
                                      },
                                      labelColor: cc.primaryColor,
                                      unselectedLabelColor: cc.greyFour,
                                      indicatorColor: cc.primaryColor,
                                      unselectedLabelStyle: TextStyle(
                                          color: cc.greyParagraph,
                                          fontWeight: FontWeight.normal),
                                      controller: _tabController,
                                      tabs: [
                                        Tab(
                                            text: asProvider
                                                .getString('Overview')),
                                        Tab(
                                            text: asProvider
                                                .getString('About seller')),
                                        Tab(
                                            text:
                                                asProvider.getString('Review')),
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
                                        ReviewTab(
                                          provider: provider,
                                        ),
                                      ][_tabIndex],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        //Book now button
                        CommonHelper().dividerCommon(),
                        //Button
                        sizedBox20(),

                        Container(
                            padding:
                                EdgeInsets.symmetric(horizontal: screenPadding),
                            child: Column(
                              children: [
                                // currentTab == 2
                                //     ? Column(
                                //         children: [
                                //           CommonHelper().borderButtonOrange(
                                //               asProvider.getString(
                                //                   'Write a review'), () {
                                //             Navigator.push(
                                //               context,
                                //               MaterialPageRoute<void>(
                                //                 builder:
                                //                     (BuildContext context) =>
                                //                         WriteReviewPage(
                                //                   serviceId: provider
                                //                       .serviceAllDetails
                                //                       .serviceDetails
                                //                       .id,
                                //                 ),
                                //               ),
                                //             );
                                //           }),
                                //           const SizedBox(
                                //             height: 14,
                                //           ),
                                //         ],
                                //       )
                                //     : Container(),
                                Row(
                                  children: [
                                    Expanded(
                                      child: CommonHelper().buttonOrange(
                                          asProvider.getString(
                                              'Book Appointment'), () {
                                        Provider.of<BookService>(context,
                                                listen: false)
                                            .setData(
                                          provider.serviceAllDetails
                                              .serviceDetails.id,
                                          provider.serviceAllDetails
                                              .serviceDetails.title,
                                          provider.serviceAllDetails
                                              .serviceDetails.price,
                                          provider.serviceAllDetails
                                              .serviceDetails.sellerId,
                                          image: provider.serviceAllDetails
                                                      .serviceImage !=
                                                  null
                                              ? provider.serviceAllDetails
                                                  .serviceImage.imgUrl
                                              : placeHolderUrl,
                                        );

                                        //==========>
                                        Provider.of<PersonalizationService>(
                                                context,
                                                listen: false)
                                            .setDefaultPrice(
                                                Provider.of<BookService>(
                                                        context,
                                                        listen: false)
                                                    .totalPrice);
                                        //fetch service extra
                                        Provider.of<PersonalizationService>(
                                                context,
                                                listen: false)
                                            .fetchServiceExtra(
                                                provider.serviceAllDetails
                                                    .serviceDetails.id,
                                                context);

                                        //=============>
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute<void>(
                                            builder: (BuildContext context) =>
                                                const ServicePersonalizationPage(),
                                          ),
                                        );
                                      }),
                                    ),

                                    // chat icon
                                    const ServiceDetailsChatIcon()
                                  ],
                                ),
                              ],
                            )),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    )
                  : Container(
                      alignment: Alignment.center,
                      child: Text(asProvider.getString('Something went wrong')),
                    )
              : OthersHelper().showLoading(cc.primaryColor),
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
    final pusherInstance =
        Provider.of<PushNotificationService>(context, listen: false)
            .pusherInstance;
    return pusherInstance == null
        ? const SizedBox()
        : Consumer<ServiceDetailsService>(
            builder: (context, provider, child) => InkWell(
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                var currentUserId = prefs.getInt('userId')!;

                //======>
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => ChatMessagePage(
                      receiverId: provider.sellerId,
                      currentUserId: currentUserId,
                      userName: provider.serviceAllDetails.serviceSellerName,
                    ),
                  ),
                );
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
