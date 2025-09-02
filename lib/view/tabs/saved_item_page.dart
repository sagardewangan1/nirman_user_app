import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/app_string_service.dart';
import 'package:qixer/service/common_service.dart';
import 'package:qixer/service/saved_items_service.dart';
import 'package:qixer/view/auth/login/login.dart';
import 'package:qixer/view/home/components/service_card.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/constant_styles.dart';
import 'package:qixer/view/utils/login_or_register.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:qixer/view/utils/responsive.dart';
import 'package:qixer/generated/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SavedItemPage extends StatefulWidget {
  const SavedItemPage({super.key});

  @override
  _SavedItemPageState createState() => _SavedItemPageState();
}

class _SavedItemPageState extends State<SavedItemPage> {
  @override
  void initState() {
    super.initState();
    firstLoad();
  }

  bool isLoggedIn = false;
  firstLoad() async {
    Provider.of<SavedItemService>(context, listen: false).fetchSavedItem();
    final pref = await SharedPreferences.getInstance();
    print("isLoggedin ${pref.getBool("shashaktnirman_is_logged_in")}");
    isLoggedIn = pref.getBool("shashaktnirman_is_logged_in") ?? false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();
    final saveItemController = Provider.of<SavedItemService>(context);
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Consumer<AppStringService>(
            builder: (context, asProvider, child) => Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Text(
                overflow: TextOverflow.visible,
                asProvider
                    .getString(AppLocalizations.of(context)!.savedServices),
                textAlign: TextAlign.center,
                softWrap: true,
                style: TextStyle(
                    color: cc.greyPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
        body: saveItemController.isLoading
            ? OthersHelper().showLoading(cc.primaryColor)
            : isLoggedIn == false
                ? LoginOrRegister()
                : SafeArea(
                    child: SingleChildScrollView(
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: screenPadding),
                        clipBehavior: Clip.none,
                        child: Consumer<SavedItemService>(
                          builder: (context, provider, child) => provider
                                  .savedItemList.isNotEmpty
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                      // const SizedBox(
                                      //   height: 25,
                                      // ),
                                      // CommonHelper().titleCommon(
                                      //     lnProvider.getString('Saved services')),
                                      const SizedBox(
                                        height: 22,
                                      ),
                                      Column(
                                        children: [
                                          for (int i = 0;
                                              i < provider.savedItemList.length;
                                              i++)
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 20),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                color: Colors.white,
                                              ),
                                              child: ServiceCard(
                                                cc: cc,
                                                imageLink:
                                                    provider.savedItemList[i]
                                                            ['image'] ??
                                                        placeHolderUrl,
                                                rating: twoDouble(
                                                    provider.savedItemList[i]
                                                        ['rating']),
                                                title: provider.savedItemList[i]
                                                    ['title'],
                                                sellerName:
                                                    provider.savedItemList[i]
                                                        ['sellerName'],
                                                price: provider.savedItemList[i]
                                                    ['price'],
                                                buttonText: AppLocalizations.of(
                                                        context)!
                                                    .enquiryNow,
                                                width: double.infinity,
                                                marginRight: 0.0,
                                                pressed: () {
                                                  provider.remove(
                                                    provider.savedItemList[i]
                                                        ['serviceId'],
                                                    provider.savedItemList[i]
                                                        ['title'],
                                                    provider.savedItemList[i]
                                                        ['image'],
                                                    provider.savedItemList[i]
                                                        ['price'],
                                                    provider.savedItemList[i]
                                                        ['sellerName'],
                                                    twoDouble(provider
                                                            .savedItemList[i]
                                                        ['rating']),
                                                    i,
                                                    context,
                                                    provider.savedItemList[i]
                                                        ['sellerId'],
                                                    provider.savedItemList[i]
                                                        ['experience'],
                                                  );
                                                },
                                                isSaved: true,
                                                serviceId:
                                                    provider.savedItemList[i]
                                                        ['serviceId'],
                                                sellerId:
                                                    provider.savedItemList[i]
                                                        ['sellerId'],
                                                cardFrom: 'Home',
                                                experience: "",
                                                status: "",
                                                address: "",
                                              ),
                                            ),
                                        ],
                                      )

                                      //
                                    ])
                              : Container(
                                  alignment: Alignment.center,
                                  height: screenHeight - 140,
                                  child: Image.asset(
                                    "assets/images/nodata.png",
                                    fit: BoxFit.contain,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }
}
