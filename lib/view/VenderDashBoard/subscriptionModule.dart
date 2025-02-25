import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:qixer/service/app_string_service.dart';
import 'package:qixer/service/profile_service.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/others_helper.dart';

import '../services/components/desc_from_html.dart';

class SubscriptionModule extends StatefulWidget {
  const SubscriptionModule({super.key});

  @override
  State<SubscriptionModule> createState() => _SubscriptionModuleState();
}

class _SubscriptionModuleState extends State<SubscriptionModule> {
  ConstantColors cc = ConstantColors();

  final List<Map<String, dynamic>> subscriptionPlans = [
    {
      "type": "Free",
      "desc": '''
        <h4>Free Service 🆓</h4>
        <ul>
            <li>Access to basic features</li>
            <li>Limited service availability</li>
            <li>Ads may be displayed</li>
            <li>No priority support</li>
        </ul>
      ''',
      "price": "0/month",
      "typeText": "Your Current Plan",
      "typebgColor": Colors.grey[300],
      "typeTextColor": Colors.black,
      "isActive": true,
    },
    {
      "type": "Premium",
      "desc": '''
        <h4>Premium Service ⭐</h4>
        <ul>
            <li>Full access to all features</li>
            <li>No ads, smooth experience</li>
            <li>Priority customer support</li>
            <li>Exclusive tools & content</li>
        </ul>
      ''',
      "price": "500/month",
      "typeText": "Upgrade Now",
      "typebgColor": Colors.blue,
      "typeTextColor": Colors.white,
      "isActive": false,
    },
    {
      "type": "Gold",
      "desc": '''
        <h4>Gold Service 🏆</h4>
        <ul>
            <li>All premium features included</li>
            <li>Personalized support</li>
            <li>Early access to new features</li>
            <li>Exclusive webinars and events</li>
        </ul>
      ''',
      "price": "1000/month",
      "typeText": "Best Value",
      "typebgColor": Colors.orange,
      "typeTextColor": Colors.white,
      "isActive": false,
    },
    {
      "type": "Platinum",
      "desc": '''
        <h4>Platinum Service 💎</h4>
        <ul>
            <li>All gold features included</li>
            <li>Dedicated account manager</li>
            <li>Custom integrations</li>
            <li>VIP customer service</li>
        </ul>
      ''',
      "price": "2000/month",
      "typeText": "Elite Plan",
      "typebgColor": Colors.purple,
      "typeTextColor": Colors.white,
      "isActive": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStringService>(
      builder: (context, asProvider, child) {
        return Consumer<ProfileService>(
          builder: (context, profileProvider, child) {
            return Scaffold(
              appBar: CommonHelper().appbarCommon(
                "Subscription Module",
                context,
                () => Navigator.pop(context),
              ),
              body: SmartRefresher(
                controller: RefreshController(),
                child: ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: subscriptionPlans.length,
                  itemBuilder: (context, index) {
                    var plan = subscriptionPlans[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: InkWell(
                        onTap: () {},
                        child: SubscriptionCard(
                          cc: cc,
                          freePlan: plan["desc"],
                          type: plan["type"],
                          typebgColor: plan["typebgColor"],
                          typeText: plan["typeText"],
                          price: plan["price"],
                          typeTextColor: plan["typeTextColor"],
                          onTapPremium: () => print(
                              "Premium Type Selected====> ${plan['type']}"),
                          isActive: plan["isActive"],
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class SubscriptionCard extends StatelessWidget {
  const SubscriptionCard({
    super.key,
    required this.cc,
    required this.freePlan,
    required this.type,
    required this.typeText,
    required this.price,
    required this.typebgColor,
    required this.typeTextColor,
    this.onTapPremium,
    this.isActive,
  });

  final ConstantColors cc;
  final String freePlan;
  final String type;
  final String typeText;
  final String price;
  final Color typebgColor;
  final Color typeTextColor;
  final VoidCallback? onTapPremium;
  final bool? isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: isActive == true ? Colors.orange.shade50 : cc.white,
          boxShadow: [
            BoxShadow(
              color: cc.greyFive,
              blurRadius: 3,
              offset: Offset(0, 1),
            )
          ],
          border: Border.all(
              width: 1, color: isActive == true ? cc.primaryColor : cc.black6)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  type,
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
                ),
                Gap(10),
                isActive == true
                    ? Icon(
                        Icons.check_circle,
                        size: 14,
                        color: cc.successColor,
                      )
                    : Offstage(),
              ],
            ),
            Gap(10),
            Text(
              "INR $rupeeSymbol$price",
              style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400),
            ),
            Gap(10),
            InkWell(
              onTap: onTapPremium,
              child: Container(
                decoration: BoxDecoration(
                  color: typebgColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 5.0),
                  child: Text(
                    typeText,
                    style: TextStyle(
                        color: typeTextColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 14),
                  ),
                ),
              ),
            ),
            Gap(10),
            DescInHtml(
              cc: cc,
              desc: freePlan,
            ),
          ],
        ),
      ),
    );
  }
}
