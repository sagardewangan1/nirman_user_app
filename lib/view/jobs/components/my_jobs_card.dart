// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/app_string_service.dart';

import '../../utils/common_helper.dart';
import '../../utils/constant_colors.dart';

class MyJobsCardContents extends StatelessWidget {
  const MyJobsCardContents({
    super.key,
    required this.cc,
    required this.imageLink,
    required this.title,
    required this.viewCount,
    required this.price,
  });

  final ConstantColors cc;
  final imageLink;
  final title;
  final viewCount;
  final price;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStringService>(
      builder: (context, asProvider, child) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonHelper().profileImage(imageLink, 75, 78),
          const SizedBox(
            width: 13,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //service name ======>
                Text(
                  title.toString(),
                  textAlign: TextAlign.start,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: cc.greyFour,
                    fontSize: 15,
                    height: 1.4,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                //Author name
                const SizedBox(
                  height: 10,
                ),

                Row(
                  children: [
                    Icon(
                      Icons.remove_red_eye_outlined,
                      size: 18,
                      color: cc.successColor,
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Text(
                      viewCount.toString(),
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: cc.greyFour,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
