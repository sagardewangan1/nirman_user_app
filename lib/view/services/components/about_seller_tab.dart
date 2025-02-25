import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:qixer/view/services/components/desc_from_html.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:qixer/view/utils/responsive.dart';

import '../seller_all_service_page.dart';

class AboutSellerTab extends StatelessWidget {
  const AboutSellerTab({super.key, required this.provider});
  final provider;
  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        //profile image, name and completed orders
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SellerAllServicePage(
                        sellerId: provider.sellerId,
                        sellerName:
                            provider.serviceAllDetails.serviceSellerName,
                      )),
            );
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: CachedNetworkImage(
                  imageUrl:
                      provider.serviceAllDetails.serviceSellerImage.imgUrl ??
                          userPlaceHolderUrl,
                  placeholder: (context, url) {
                    return Image.asset('assets/images/loading_image.png');
                  },
                  height: 60,
                  width: 60,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    provider.serviceAllDetails.serviceSellerName,
                    style: TextStyle(
                        color: cc.greyFour,
                        fontSize: 17,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Row(
                    children: [
                      Text(
                        lnProvider.getString('Order Completed'),
                        style: TextStyle(
                          color: cc.primaryColor,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        '(${provider.serviceAllDetails.sellerCompleteOrder.toString()})',
                        style: TextStyle(
                          color: cc.greyParagraph,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        // Container(
        //   padding: const EdgeInsets.all(20),
        //   decoration: BoxDecoration(
        //       border: Border.all(color: cc.borderColor, width: 1),
        //       borderRadius: BorderRadius.circular(6)),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       Row(
        //         children: [
        //           Expanded(
        //             child: ServiceHelper().serviceDetails(
        //                 'From', provider.serviceAllDetails.sellerFrom ?? ''),
        //           ),
        //           Expanded(
        //               child: ServiceHelper().serviceDetails(
        //                   'Order Completion Rate',
        //                   '${provider.serviceAllDetails.orderCompletionRate}%'))
        //         ],
        //       ),
        //       const SizedBox(
        //         height: 30,
        //       ),
        //       Row(
        //         children: [
        //           Expanded(
        //             child: ServiceHelper().serviceDetails(
        //                 'Seller Since',
        //                 getYear(
        //                     provider.serviceAllDetails.sellerSince.createdAt)),
        //           ),
        //           Expanded(
        //               child: ServiceHelper().serviceDetails(
        //                   'Order Completed',
        //                   provider.serviceAllDetails.sellerCompleteOrder
        //                       .toString()))
        //         ],
        //       ),
        //       // const SizedBox(
        //       //   height: 30,
        //       // ),
        //       // Text(
        //       //   'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less.',
        //       //   style: TextStyle(
        //       //     color: cc.greyParagraph,
        //       //     fontSize: 14,
        //       //     height: 1.4,
        //       //   ),
        //       // ),
        //     ],
        //   ),
        // ),
        DescInHtml(
          cc: cc,
          desc: '''<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Company Overview</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      margin: 20px;
      line-height: 1.6;
    }
    .container {
      max-width: 800px;
      margin: auto;
      padding: 20px;
      border: 1px solid #ddd;
      border-radius: 8px;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    }
    .section {
      margin-bottom: 20px;
    }
    .section h2 {
      color: #4CAF50;
      margin-bottom: 10px;
      font-size: 1.5em;
    }
    .team-member {
      margin: 10px 0;
    }
    .achievement {
      margin: 5px 0;
    }
    .map {
      margin-top: 10px;
    }
    .contact a {
      color: #4CAF50;
      text-decoration: none;
    }
    .contact a:hover {
      text-decoration: underline;
    }
  </style>
</head>
<body>
  <div class="container">
    <!-- Company Overview Section -->
    <div class="section" id="company-overview">
      <h2>Company Overview</h2>
      <p><strong>Established Year:</strong> Established in 2010.</p>
      <p><strong>Mission Statement:</strong> To provide exceptional services that create value and make a difference.</p>
      <p><strong>Vision:</strong> To be a global leader in delivering innovative and sustainable solutions.</p>
    </div>

    <!-- Team Information Section -->
    <div class="section" id="team-info">
      <h2>Team Information</h2>
      <div class="team-member">
        <strong>John Doe</strong> - CEO
      </div>
      <div class="team-member">
        <strong>Jane Smith</strong> - Service Lead
      </div>
      <div class="team-member">
        <strong>Emily Johnson</strong> - Head of Operations
      </div>
    </div>

    <!-- Achievements Section -->
    <div class="section" id="achievements">
      <h2>Achievements</h2>
      <ul>
        <li class="achievement">ISO Certified</li>
        <li class="achievement">1000+ Clients Served</li>
        <li class="achievement">Winner of the 2023 Industry Excellence Award</li>
      </ul>
    </div>

    <!-- Location Section -->
    <div class="section" id="location">
      <h2>Location</h2>
      <p><strong>Address:</strong>Ofc 06, 3rd Floor Magneto Mall Raipur (C.G) 492001</p>
    </div>
    <!-- Contact Information Section -->
    <div class="section" id="contact-info">
      <h2>Contact Information</h2>
      <p><strong>Phone:</strong> +911234567890</p>
      <p><strong>Email:</strong> <a href="mailto:info@company.com">info@company.com</a></p>
      <p><strong>Follow us:</strong></p>
      <p>
        <a href="https://facebook.com/company" target="_blank">Facebook</a> |
        <a href="https://twitter.com/company" target="_blank">Twitter</a> |
        <a href="https://linkedin.com/company" target="_blank">LinkedIn</a>
      </p>
    </div>
  </div>
</body>
</html>
''',
        ),
      ]),
    );
  }
}
