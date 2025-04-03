import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:qixer/helper/contactFeatures.dart';
import 'package:qixer/view/utils/CustomButton.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SupportView extends StatelessWidget {
  const SupportView({super.key});

  //
  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();
    return Scaffold(
        appBar: CommonHelper().appbarCommon(
          AppLocalizations.of(context)!.contactUs,
          context,
          () => Navigator.pop(context),
        ),
        body: ListView(
          padding: EdgeInsets.zero,
          physics: const BouncingScrollPhysics(),
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
              child: Container(
                alignment: Alignment.center,
                child: Image.asset('assets/gif/contactUs.png'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomButton(
                          onTap: () => ContactFeatures().launchWhatsapp(
                            context,
                            "9981165924",
                            AppLocalizations.of(context)!.contactTextMsg,
                          ),
                          title:
                              AppLocalizations.of(context)!.contactViaWhatsApp,
                          leading: SvgPicture.asset(
                            "assets/svg/whataspp.svg",
                            height: 25,
                            width: 25,
                          ),
                          cc: cc,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomButton(
                          onTap: () => ContactFeatures()
                              .launchCalling(context, "9981165924"),
                          title: AppLocalizations.of(context)!.contactViaCall,
                          leading: Image.asset(
                            "assets/icons/call.png",
                            height: 25,
                            width: 25,
                          ),
                          cc: cc,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 14.0),
                        child: CustomButton(
                          onTap: () => ContactFeatures()
                              .launchEmail(context, 'mail@sashaktnirmaan.com'),
                          title: AppLocalizations.of(context)!.contactViaMail,
                          leading: SvgPicture.asset(
                            "assets/svg/mail.svg",
                            height: 20,
                            width: 20,
                          ),
                          cc: cc,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
