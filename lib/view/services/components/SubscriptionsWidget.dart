import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_styles.dart';

import '../../utils/constant_colors.dart';

class SubscriptionsWidget extends StatelessWidget {
  final String? amount;
  final String? type;
  final String? points;
  final VoidCallback? onTap;
  final Size size;
  const SubscriptionsWidget(
      {super.key,
      this.amount,
      this.type,
      this.points,
      this.onTap,
      required this.size});

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              blurRadius: 4,
              offset: const Offset(0, 1),
            )
          ]),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                textAlign: TextAlign.center,
                type.toString(),
                style: TextStyle(
                    fontWeight: FontWeight.w400, // Regular weight
                    color: cc.black3,
                    fontSize: 16.0)),
            sizedBoxCustom(10),
            ClipOval(
              child: Container(
                decoration: BoxDecoration(color: Colors.blue),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(amount.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.w400, // Regular weight
                        color: cc.black3,
                      )),
                ),
              ),
            ),
            sizedBoxCustom(10),
            Center(child: HtmlWidget(points.toString())),
            sizedBoxCustom(20),
            SizedBox(
                width: size.width * 0.2,
                child: CommonHelper().buttonOrange(
                  "Pay",
                  () {},
                ))
          ],
        ),
      ),
    );
  }
}
