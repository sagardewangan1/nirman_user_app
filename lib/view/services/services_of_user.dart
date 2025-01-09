import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/view/services/service_details_page.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';

import '../../service/service_details_service.dart';
import '../home/components/service_card.dart';
import '../utils/constant_styles.dart';

class ServicesOfUser extends StatelessWidget {
  final sellerName;
  const ServicesOfUser(this.sellerName, {super.key});

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonHelper().appbarCommon('Leslie Alexander', context, () {
        Navigator.pop(context);
      }),
      body: ListView.separated(
          padding: EdgeInsets.all(screenPadding),
          itemBuilder: (context, index) {
            return InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                Navigator.pop(context);
                Navigator.pop(context);
                Provider.of<ServiceDetailsService>(context, listen: false)
                    .fetchServiceDetails(68);
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        const ServiceDetailsPage(),
                  ),
                );
              },
              child: ServiceCard(
                cc: cc,
                imageLink:
                    "https://cdn.pixabay.com/photo/2021/09/14/11/33/tree-6623764__340.jpg",
                rating: '4.5',
                title: 'Hair cutting service at low price Hair cutting',
                sellerName: 'Jane Cooper',
                price: 30,
                buttonText: 'Book Now',
                width: double.infinity,
                marginRight: 0.0,
                pressed: () {},
                isSaved: false,
                serviceId: 50,
                sellerId: 2,
              ),
            );
          },
          separatorBuilder: (context, index) {
            return sizedBoxCustom(10);
          },
          itemCount: 3),
    );
  }
}
