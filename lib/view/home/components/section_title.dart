import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/app_string_service.dart';

import '../../utils/constant_colors.dart';

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
                      asProvider.getString('See all'),
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
