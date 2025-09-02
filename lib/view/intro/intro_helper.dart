import 'package:flutter/material.dart';
import 'package:qixer/generated/app_localizations.dart';

class IntroHelper {
  getImage(int i) {
    return 'https://sashaktnirmaan.com/assets/uploads/media-uploader/intro${i + 1}.png';
  }

  geTitle(int i, BuildContext context) {
    List title = [
      AppLocalizations.of(context)!.introTitle1,
      AppLocalizations.of(context)!.introTitle2,
      AppLocalizations.of(context)!.introTitle3,
    ];
    return title[i];
  }

  geSubTitle(int i, BuildContext context) {
    List subTitle = [
      AppLocalizations.of(context)!.introSubTitle1,
      AppLocalizations.of(context)!.introSubTitle2,
      AppLocalizations.of(context)!.introSubTitle3,
    ];
    return subTitle[i];
  }
}
