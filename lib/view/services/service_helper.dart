import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/responsive.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ServiceHelper {
  ConstantColors cc = ConstantColors();

  //==============>
  checkListCommon(BuildContext context, String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 13),
      child: Row(
        children: [
          Icon(
            Icons.check,
            color: cc.successColor,
          ),
          const SizedBox(
            width: 14,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width - 90,
            child: AutoSizeText(
              title,
              maxLines: 2,
              style: TextStyle(
                color: cc.greyFour,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }

//==================>
  serviceDetails(String title1, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          lnProvider.getString(title1),
          style: TextStyle(
            color: cc.greyParagraph,
            fontSize: 14,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          value,
          maxLines: 2,
          style: TextStyle(
              color: cc.greyPrimary, fontSize: 17, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

//===================>
  watchVideoPopup(BuildContext context, String videoLink) {
    String videoId = YoutubePlayer.convertUrlToId(videoLink)!;
    YoutubePlayerController controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );

    return Alert(
        context: context,
        style: AlertStyle(
            alertElevation: 0,
            overlayColor: Colors.black.withOpacity(.6),
            alertPadding: const EdgeInsets.all(16),
            isButtonVisible: false,
            alertBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: const BorderSide(
                color: Colors.transparent,
              ),
            ),
            titleStyle: const TextStyle(),
            animationType: AnimationType.grow,
            animationDuration: const Duration(milliseconds: 500)),
        content: Container(
          margin: const EdgeInsets.only(top: 17),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.01),
                  spreadRadius: -2,
                  blurRadius: 13,
                  offset: const Offset(0, 13)),
            ],
          ),
          child: Column(
            children: [
              Container(
                color: cc.primaryColor,
                height: 200,
                child: YoutubePlayer(
                  controller: controller,
                  showVideoProgressIndicator: true,
                ),
              ),
            ],
          ),
        )).show();
  }
}
