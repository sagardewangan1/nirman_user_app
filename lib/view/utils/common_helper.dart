import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/app_string_service.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:qixer/view/utils/responsive.dart';

import '../../service/book_steps_service.dart';

class CommonHelper {
  ConstantColors cc = ConstantColors();
  //common appbar
  appbarCommon(String title, BuildContext context, VoidCallback pressed,
      {actions}) {
    return AppBar(
      centerTitle: true,
      surfaceTintColor: cc.white,
      iconTheme: IconThemeData(color: cc.greyPrimary),
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      title: Consumer<AppStringService>(
        builder: (context, asProvider, child) => Text(
          asProvider.getString(title),
          style: TextStyle(
              color: cc.greyPrimary, fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      backgroundColor: cc.white,
      elevation: 0,
      leading: InkWell(
        onTap: pressed,
        child: const Icon(
          Icons.arrow_back_ios,
          // size: 24,
        ),
      ),
      actions: actions,
    );
  }

  appbarForBookingPages(String title, BuildContext context,
      {bool isPersonalizatioPage = false, VoidCallback? extraFunction}) {
    return AppBar(
      centerTitle: true,
      iconTheme: IconThemeData(color: cc.greyPrimary),
      title: Consumer<AppStringService>(
        builder: (context, asProvider, child) => Text(
          asProvider.getString(title),
          style: TextStyle(
              color: cc.greyPrimary, fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: InkWell(
        onTap: () {
          if (isPersonalizatioPage != true) {
            BookStepsService().decreaseStep(context);
          } else {
            //if its personalization page then decrease step to 1
            Provider.of<BookStepsService>(context, listen: false)
                .setStepsToDefault();
          }
          Navigator.pop(context);
          if (extraFunction != null) {
            extraFunction.call();
          }
        },
        child: const Icon(
          Icons.arrow_back_ios,
          size: 18,
        ),
      ),
    );
  }

  //common orange button =======>
  buttonOrange(String title, VoidCallback pressed,
      {isloading = false, bgColor, double paddingVerticle = 18}) {
    return InkWell(
      onTap: pressed,
      child: Container(
          width: double.infinity,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: paddingVerticle),
          decoration: BoxDecoration(
              color: bgColor ?? cc.primaryColor,
              borderRadius: BorderRadius.circular(8)),
          child: isloading == false
              ? Text(
                  lnProvider.getString(title),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                )
              : OthersHelper().showLoading(Colors.white)),
    );
  }

  borderButtonOrange(String title, VoidCallback pressed,
      {bgColor, double paddingVerticle = 17}) {
    return InkWell(
      onTap: pressed,
      child: Container(
          width: double.infinity,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: paddingVerticle),
          decoration: BoxDecoration(
              border: Border.all(color: bgColor ?? cc.primaryColor),
              borderRadius: BorderRadius.circular(8)),
          child: Text(
            title,
            style: TextStyle(
              color: bgColor ?? cc.primaryColor,
              fontSize: 14,
            ),
          )),
    );
  }

  labelCommon(String title, {margin}) {
    return Container(
      margin: margin ?? const EdgeInsets.only(bottom: 15),
      child: Text(
        lnProvider.getString(title),
        style: TextStyle(
          color: cc.greyThree,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  paragraphCommon(
    String title, {
    double fontsize = 14,
    color,
    textAlign = TextAlign.left,
  }) {
    return AutoSizeText(
      title,
      textAlign: textAlign,
      style: TextStyle(
        color: color ?? cc.greyParagraph,
        height: 1.4,
        fontSize: fontsize,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  titleCommon(String title,
      {double fontsize = 18,
      color,
      lineheight = 1.3,
      maxLines,
      textAlign,
      overflow}) {
    return Text(
      lnProvider.getString(title),
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
      style: TextStyle(
          color: color ?? cc.greyPrimary,
          fontSize: fontsize,
          height: lineheight,
          fontWeight: FontWeight.bold),
    );
  }

  dividerCommon() {
    return Divider(
      thickness: 1,
      height: 2,
      color: cc.borderColor,
    );
  }

  checkCircle() {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(shape: BoxShape.circle, color: cc.primaryColor),
      child: const Icon(
        Icons.check,
        size: 13,
        color: Colors.white,
      ),
    );
  }

  profileImage(String imageLink, double height, double width) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: CachedNetworkImage(
        imageUrl: imageLink,
        placeholder: (context, url) {
          return Image.asset('assets/images/loading_image.png');
        },
        errorWidget: (_, string, obj) {
          return Container(
            margin: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      "assets/images/app_icon.png",
                    ),
                    opacity: .5)),
          );
        },
        height: height,
        width: width,
        fit: BoxFit.cover,
      ),
    );
  }

  //no order found
  nothingfound(BuildContext context, String title) {
    return Container(
        height: MediaQuery.of(context).size.height - 120,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.hourglass_empty,
              size: 26,
              color: cc.greyFour,
            ),
            const SizedBox(
              height: 7,
            ),
            Text(
              lnProvider.getString(title),
              style: TextStyle(color: cc.greyFour),
            ),
          ],
        ));
  }
}
