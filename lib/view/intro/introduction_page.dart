import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:qixer/helper/SharedPreferencesHelper.dart';
import 'package:qixer/helper/extension/context_extension.dart';
import 'package:qixer/helper/extension/int_extension.dart';
import 'package:qixer/view/intro/intro_helper.dart';
import 'package:qixer/view/selectionRole/selectionRoleView.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:qixer/generated/app_localizations.dart';
import '../home/landing_page.dart';

class IntroductionPage extends StatefulWidget {
  const IntroductionPage({super.key});

  @override
  State<IntroductionPage> createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
  ConstantColors cc = ConstantColors();
  int _selectedSlide = 0;
  final PageController _pageController = PageController();

  @override
  void initState() {
    print("_selectedSlide init======> $_selectedSlide");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          clipBehavior: Clip.none,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Slider =============>
                Spacer(),
                SizedBox(
                  height: 320,
                  child: PageView.builder(
                      controller: _pageController,
                      onPageChanged: (value) {
                        setState(() {
                          _selectedSlide = value;
                        });
                      },
                      itemCount: 3,
                      itemBuilder: (context, i) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16.0),
                                child: CachedNetworkImage(
                                  imageUrl: IntroHelper().getImage(i),
                                  width: double.infinity,
                                  height: 320,
                                  fit: BoxFit.contain,
                                  placeholder: (context, url) =>
                                      Transform.scale(
                                    scale: 0.7,
                                    child: OthersHelper()
                                        .showLoading(cc.primaryColor),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                ),
                const SizedBox(
                  height: 42,
                ),
                //slider count show =======>
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (var i = 0; i < 3; i++)
                      Container(
                        margin: const EdgeInsets.only(right: 5),
                        height: 16,
                        width: 16,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: _selectedSlide == i
                                    ? cc.primaryColor
                                    : Colors.transparent),
                            shape: BoxShape.circle),
                        child: Container(
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                              color: _selectedSlide == i
                                  ? cc.primaryColor
                                  : const Color(0xffD0D5DD),
                              shape: BoxShape.circle),
                        ),
                      )
                  ],
                ),

                //buttons
                const SizedBox(
                  height: 42,
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          context.toUntilPage(const LandingPage());
                          SharedPreferencesHelper.clearData();
                          final pref = await SharedPreferences.getInstance();
                          pref.setBool('intro', false);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 16),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: cc.primaryColor, width: 1.5),
                              borderRadius: BorderRadius.circular(7)),
                          child: Text(
                            AppLocalizations.of(context)!.skip,
                            style: TextStyle(
                                color: cc.primaryColor,
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 18,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          print("_selectedSlide======> $_selectedSlide");
                          if (_selectedSlide == 2) {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.setBool('intro', false);
                            context.toUntilPage(const SelectionRoleView(
                              hasBackButton: false,
                            ));
                          } else {
                            _pageController.animateToPage(_selectedSlide + 1,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.ease);
                          }
                        },
                        child: Container(
                            width: double.infinity,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            decoration: BoxDecoration(
                                color: cc.primaryColor,
                                borderRadius: BorderRadius.circular(8)),
                            child: Text(
                              AppLocalizations.of(context)!.continueText,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600),
                            )),
                      ),
                    ),
                  ],
                ),
                20.toHeight,
                const SizedBox(
                  height: 80,
                ),
              ]),
        ),
      ),
    );
  }
}
