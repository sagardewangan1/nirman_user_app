import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/app/constant/appLanguages.dart';
import 'package:qixer/service/languageController/languageController.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppSettings extends StatefulWidget {
  const AppSettings({super.key});

  @override
  State<AppSettings> createState() => _AppSettingsState();
}

class _AppSettingsState extends State<AppSettings> {
  ConstantColors cc = ConstantColors();

  @override
  Widget build(BuildContext context) {
    debugPrint(AppLocalizations.of(context)!.language);
    return Consumer<LanguageController>(
      builder: (context, langController, child) {
        return Scaffold(
          appBar: CommonHelper()
              .appbarCommon2(AppLocalizations.of(context)!.appSetting, context),
          body: ListView(
            children: [
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        showDragHandle: true,
                        enableDrag: true,
                        builder: (context) {
                          return LanguageBottomSheetCard();
                        },
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: cc.white,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              AppLocalizations.of(context)!.language ??
                                  'Language',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: cc.black3),
                            ),
                            Spacer(),
                            Text(
                              langController.languageTitle.toString(),
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: cc.black6),
                            ),
                            Icon(Icons.arrow_drop_down),
                          ],
                        ),
                      ),
                    ),
                  )),
            ],
          ),
        );
      },
    );
  }
}

class LanguageBottomSheetCard extends StatelessWidget {
  const LanguageBottomSheetCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageController>(
      builder: (context, langController, child) {
        return Container(
          height: 300,
          decoration: BoxDecoration(
              color: cc.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(16.0),
                topLeft: Radius.circular(16.0),
              )),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: AppLanguages.languages.length,
              itemBuilder: (context, index) {
                final appLang = AppLanguages.languages[index];
                return InkWell(
                  onTap: () async => await langController
                      .changeLanguage(Locale(appLang.languageCode.toString()))
                      .whenComplete(
                        () => Navigator.pop(context),
                      ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          textAlign: TextAlign.center,
                          appLang.languageName ?? "NA",
                          style: TextStyle(
                              fontSize: 14.0,
                              color: cc.black3,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      if (index != AppLanguages.languages.length - 1)
                        CommonHelper().dividerCommon()
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
