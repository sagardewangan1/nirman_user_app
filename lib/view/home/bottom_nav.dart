import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qixer/service/common_service.dart';
import 'package:qixer/view/utils/responsive.dart';
import '../utils/constant_colors.dart';

import 'dart:io'; // ✅ For Platform check

import 'dart:io'; // ✅ For Platform check

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

    // ✅ Define nav items dynamically
    List<BottomNavigationBarItem> navItems = [
      BottomNavigationBarItem(
        icon: Container(
          margin: const EdgeInsets.only(bottom: 6),
          child: SvgPicture.asset(
            'assets/svg/home-icon.svg',
            color: currentIndex == 0 ? cc.primaryColor : cc.greyFour,
            semanticsLabel: 'Home Icon',
          ),
        ),
        label: lnProvider.getString('Home'),
      ),
      if (userType == "0")
        BottomNavigationBarItem(
          icon: Container(
            margin: const EdgeInsets.only(bottom: 6),
            child: SvgPicture.asset(
              'assets/svg/growth.svg',
              color: currentIndex == 1 ? cc.primaryColor : cc.greyFour,
            ),
          ),
          label: lnProvider.getString('My Leads'),
        ),
      BottomNavigationBarItem(
        icon: Container(
          margin: const EdgeInsets.only(bottom: 6),
          child: SvgPicture.asset(
            'assets/svg/saved-icon.svg',
            color: currentIndex == (userType == "0" ? 2 : 1)
                ? cc.primaryColor
                : cc.greyFour,
            semanticsLabel: 'Saved Icon',
          ),
        ),
        label: lnProvider.getString('Saved'),
      ),
      BottomNavigationBarItem(
        icon: Container(
          margin: const EdgeInsets.only(bottom: 6),
          child: SvgPicture.asset(
            'assets/svg/search-icon.svg',
            color: currentIndex == (userType == "0" ? 3 : 2)
                ? cc.primaryColor
                : cc.greyFour,
            semanticsLabel: 'Search Icon',
          ),
        ),
        label: lnProvider.getString('Search'),
      ),
      BottomNavigationBarItem(
        icon: Container(
          margin: const EdgeInsets.only(bottom: 6),
          child: SvgPicture.asset(
            'assets/svg/settings-icon.svg',
            color: currentIndex == (userType == "0" ? 4 : 3)
                ? cc.primaryColor
                : cc.greyFour,
            semanticsLabel: 'Menu Icon',
          ),
        ),
        label: lnProvider.getString('Menu'),
      ),
    ];

    return SizedBox(
      height: Platform.isIOS ? 90 : 70, // ✅ Fix for iOS padding
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        backgroundColor: cc.white,
        selectedLabelStyle: const TextStyle(fontSize: 12),
        selectedItemColor: ConstantColors().primaryColor,
        unselectedItemColor: ConstantColors().greyFour,
        onTap: (index) {
          if (index < navIndexes.length) {
            onTabTapped(navIndexes[index]); // ✅ Correct index mapping
          } else {
            print("❌ Invalid index: $index");
          }
        },
        currentIndex: currentIndex,
        items: navItems,
      ),
    );
  }
}
