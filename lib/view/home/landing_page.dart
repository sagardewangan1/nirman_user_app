import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:qixer/model/navigationModel.dart';
import 'package:qixer/service/filter_services_service.dart';
import 'package:qixer/service/home_services/landingPageService.dart';
import 'package:qixer/view/home/home.dart';
import 'package:qixer/view/search/service_filter_model.dart';
import 'package:qixer/view/tabs/leads/leadsView.dart';
import 'package:qixer/view/tabs/saved_item_page.dart';
import 'package:qixer/view/tabs/search/search_tab.dart';
import 'package:qixer/view/tabs/settings/menu_page.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upgrader/upgrader.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final Upgrader upgrader = Upgrader(
    debugLogging: true,
    languageCode: "IN",
    storeController: UpgraderStoreController(
      onAndroid: () => UpgraderPlayStore(),
    ),
  );

  String? userType;
  List<Widget> _children = [];
  List<int> _navIndexes = [];
  DateTime? currentBackPressTime;

  @override
  void initState() {
    super.initState();
    firstLoad();
  }

  firstLoad() async {
    final pref = await SharedPreferences.getInstance();
    userType = pref.getString("shashaktnirmanusertype");
    print("usertype===> $userType");

    _children = [];
    _navIndexes = [];

    // ✅ Add pages dynamically
    _children.add(const Homepage());
    _navIndexes.add(0);

    if (userType == "0") {
      _children
          .add(LeadsView(navigationModel: NavigationModel(navFrom: "Home")));
      _navIndexes.add(1);
    }

    _children.add(const SavedItemPage());
    _navIndexes
        .add(_navIndexes.length); // This will be 2 or 1 depending on userType

    _children.add(const SearchTab());
    _navIndexes
        .add(_navIndexes.length); // This will be 3 or 2 depending on userType

    _children.add(const MenuPage());
    _navIndexes
        .add(_navIndexes.length); // This will be 4 or 3 depending on userType

    // Ensure that the tabIndex is within the bounds of _children
    final landingPageController =
        Provider.of<LandingPageService>(context, listen: false);
    if (landingPageController.tabIndex >= _children.length) {
      landingPageController
          .setTabIndex(0); // Reset to the first tab if out of bounds
    }

    setState(() {});
  }

  void onTabTapped(int index) {
    if (index >= _navIndexes.length) {
      print("⚠️ Invalid index: $index, resetting to 0");
      index = 0;
    }
    final landingPageController =
        Provider.of<LandingPageService>(context, listen: false);
    int actualIndex = _navIndexes[index];
    if (userType == '0' ? actualIndex == 2 : actualIndex == 3) {
      Provider.of<FilterServicesService>(context, listen: false).resetFilters();
      ServiceFilterViewModel.instance.searchTextController.text = "";
    }
    landingPageController.setTabIndex(actualIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LandingPageService>(
      builder: (context, landingPageProvider, child) {
        return UpgradeAlert(
          upgrader: upgrader,
          showIgnore: false,
          showReleaseNotes: true,
          barrierDismissible: true,
          child: Scaffold(
            backgroundColor: Colors.white,
            body: WillPopScope(
              onWillPop: () async {
                DateTime now = DateTime.now();
                if (currentBackPressTime == null ||
                    now.difference(currentBackPressTime!) >
                        const Duration(seconds: 2)) {
                  currentBackPressTime = now;
                  if (landingPageProvider.tabIndex != 0) {
                    landingPageProvider.setTabIndex(0);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Press again to exit")),
                    );
                  }
                  return false;
                }
                if (Platform.isAndroid) {
                  SystemNavigator.pop();
                }
                return true;
              },
              child: _children[landingPageProvider.tabIndex],
            ),
            bottomNavigationBar: BottomNav(
              currentIndex: landingPageProvider.tabIndex,
              onTabTapped: onTabTapped,
              userType: userType,
              navIndexes: _navIndexes,
            ),
          ),
        );
      },
    );
  }
}

class BottomNav extends StatelessWidget {
  final int currentIndex;
  final List<int> navIndexes;
  final String? userType;
  final Function(int) onTabTapped;

  const BottomNav({
    super.key,
    required this.currentIndex,
    required this.onTabTapped,
    required this.navIndexes,
    this.userType,
  });

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();

    List<BottomNavigationBarItem> navItems = [
      BottomNavigationBarItem(
        icon: _navIcon('assets/svg/home-icon.svg', currentIndex == 0, cc),
        label: AppLocalizations.of(context)!.home,
      ),
      if (userType == "0")
        BottomNavigationBarItem(
          icon: _navIcon('assets/svg/growth.svg', currentIndex == 1, cc),
          label: AppLocalizations.of(context)!.myLeads,
        ),
      BottomNavigationBarItem(
        icon: _navIcon('assets/svg/saved-icon.svg',
            currentIndex == (userType == "0" ? 2 : 1), cc),
        label: AppLocalizations.of(context)!.saved,
      ),
      BottomNavigationBarItem(
        icon: _navIcon('assets/svg/search-icon.svg',
            currentIndex == (userType == "0" ? 3 : 2), cc),
        label: AppLocalizations.of(context)!.search,
      ),
      BottomNavigationBarItem(
        icon: _navIcon('assets/svg/settings-icon.svg',
            currentIndex == (userType == "0" ? 4 : 3), cc),
        label: AppLocalizations.of(context)!.menuText,
      ),
    ];

    return SizedBox(
      height: Platform.isIOS ? 90 : 70,
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: cc.primaryColor,
        unselectedItemColor: cc.greyFour,
        onTap: onTabTapped,
        currentIndex: currentIndex,
        items: navItems,
      ),
    );
  }

  Widget _navIcon(String asset, bool isActive, ConstantColors cc) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      child: SvgPicture.asset(
        asset,
        color: isActive ? cc.primaryColor : cc.greyFour,
      ),
    );
  }
}
