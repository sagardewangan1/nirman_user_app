import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/app_string_service.dart';

import '../../utils/constant_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    super.key,
    required this.cc,
    required this.title,
    required this.pressed,
    this.hasSeeAllBtn = true,
  });

  final ConstantColors cc;
  final String title;
  final VoidCallback pressed;
  final bool hasSeeAllBtn;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStringService>(
      builder: (context, asProvider, child) => Row(
        children: [
          Text(
            asProvider.getString(title),
            style: TextStyle(
              color: cc.greyFour,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (hasSeeAllBtn)
            Expanded(
              child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: pressed,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.seeAll,
                      style: TextStyle(
                        color: cc.primaryColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: cc.primaryColor,
                      size: 15,
                    )
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class CategoryTitle extends StatelessWidget {
  const CategoryTitle({
    super.key,
    required this.cc,
    required this.title,
    required this.pressed,
    this.hasSeeAllBtn = true,
    this.textOverflow,
    this.maxLines,
    this.titleWidth,
  });

  final ConstantColors cc;
  final String title;
  final VoidCallback pressed;
  final bool hasSeeAllBtn;
  final TextOverflow? textOverflow;
  final int? maxLines;
  final double? titleWidth;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStringService>(
      builder: (context, asProvider, child) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(
            width: titleWidth ?? 150,
            child: Text(
              title,
              maxLines: maxLines ?? 1,
              overflow: textOverflow ?? TextOverflow.visible,
              softWrap: true,
              style: TextStyle(
                color: cc.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          if (hasSeeAllBtn)
            Expanded(
              child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: pressed,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.seeAll,
                      style: TextStyle(
                        color: cc.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    // const SizedBox(
                    //   width: 2,
                    // ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: cc.white,
                      size: 12,
                    )
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class CategoryTitle2 extends StatelessWidget {
  const CategoryTitle2({
    super.key,
    required this.cc,
    required this.title,
    required this.pressed,
    this.hasSeeAllBtn = true,
  });

  final ConstantColors cc;
  final String title;
  final VoidCallback pressed;
  final bool hasSeeAllBtn;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStringService>(
      builder: (context, asProvider, child) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: cc.black3,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (hasSeeAllBtn)
            Expanded(
              child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: pressed,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.seeAll,
                      style: TextStyle(
                        color: cc.primaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    // const SizedBox(
                    //   width: 2,
                    // ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: cc.primaryColor,
                      size: 12,
                    )
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
