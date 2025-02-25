import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';

class LeadItemCard extends StatelessWidget {
  const LeadItemCard({
    super.key,
    required this.cc,
    required this.isNew,
    this.imageUrl,
    this.name,
    this.enquiryName,
    this.address,
    this.leftTime,
    this.onTapMenu,
    this.onTap,
    this.onTapWhatsapp,
    this.onTapCall,
    this.onTapMessage,
    this.onTapFav,
    required this.isFav,
  });

  final ConstantColors cc;
  final bool isNew;
  final String? imageUrl;
  final String? name;
  final String? enquiryName;
  final String? address;
  final String? leftTime;
  final Function? onTapMenu;
  final VoidCallback? onTap;
  final VoidCallback? onTapWhatsapp;
  final VoidCallback? onTapCall;
  final VoidCallback? onTapMessage;
  final VoidCallback? onTapFav;
  final bool isFav;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: cc.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 3,
                color: cc.greyFive,
                offset: Offset(0, 2),
              )
            ]),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: isNew
                          ? cc.primaryColor.withOpacity(0.2)
                          : cc.successColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4.0, vertical: 2.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            isNew
                                ? Icons.local_fire_department_rounded
                                : Icons.circle,
                            size: 10,
                            color: isNew ? cc.primaryColor : cc.white,
                          ),
                          Gap(3),
                          Text(
                            isNew ? "New Lead" : "Read",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: isNew ? cc.primaryColor : cc.white,
                                fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      imageUrl != null
                          ? CommonHelper().profileImage(imageUrl ?? "", 30, 30)
                          : CircleAvatar(radius: 17, child: Icon(Icons.person)),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              width: 200,
                              child: Text(
                                textAlign: TextAlign.left,
                                name ?? "",
                                // "Rajesh Kumar Thawait ${index + 1}",
                                overflow: TextOverflow.visible,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              )),
                          Text(
                            textAlign: TextAlign.left,
                            enquiryName ?? "",
                            style: TextStyle(
                                color: cc.black6,
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 270,
                    child: Text(
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      // "Ramanand Pandey Wadi, 41 W E Higway,pt. Motilal Nehru Rd., Vit Bahtti, Goregaon (east)",
                      address ?? '',
                      style: TextStyle(
                          color: cc.black3,
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 25,
                    // width: size.width * 0.89,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: onTapWhatsapp,
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(width: 1, color: cc.black6),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5.0, vertical: 3),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.network(
                                    "https://i.postimg.cc/zGGrQYmw/whatsa-removebg-preview.png",
                                    height: 18,
                                    width: 18,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    'Whatsapp',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        GestureDetector(
                          onTap: onTapCall,
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.blue.shade700,
                              border: Border.all(
                                  width: 1, color: Colors.blue.shade700),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5.0, vertical: 3),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.call,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    'Call Now',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        GestureDetector(
                          onTap: onTapMessage,
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(width: 1, color: cc.black6),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5.0, vertical: 3),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.message,
                                    size: 16,
                                    color: Colors.black,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    'Message',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  // CircleAvatar(
                  //   radius: 14,
                  //   backgroundColor: cc.black8,
                  //   child: PopupMenuButton<String>(
                  //     iconSize: 18,
                  //     splashRadius: 20,
                  //     padding: EdgeInsets.zero,
                  //     menuPadding: EdgeInsets.zero,
                  //     color: Colors.white,
                  //     onSelected: (value) {
                  //       onTapMenu?.call(value);
                  //     },
                  //     itemBuilder: (BuildContext context) =>
                  //         <PopupMenuEntry<String>>[
                  //       PopupMenuItem<String>(
                  //         value: "showDetails",
                  //         child: const Text(
                  //           'Show Details',
                  //           style: TextStyle(
                  //               fontWeight: FontWeight.w500, fontSize: 14),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // Gap(10),
                  Text(
                    textAlign: TextAlign.center,
                    // "12hr",
                    leftTime ?? '',
                    style: TextStyle(
                        color: cc.black5,
                        fontSize: 10,
                        fontWeight: FontWeight.w400),
                  ),
                  // Gap(10),
                  InkWell(
                    onTap: onTapFav,
                    child: Icon(
                      isFav ? Icons.bookmark_rounded : Icons.bookmark_border,
                      color: isFav ? Colors.deepOrange : cc.black6,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
