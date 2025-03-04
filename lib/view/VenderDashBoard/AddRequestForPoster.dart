import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:qixer/service/app_string_service.dart';
import 'package:qixer/service/getImageController.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/others_helper.dart';

class AddRequestForPosterAdd extends StatefulWidget {
  const AddRequestForPosterAdd({super.key});

  @override
  State<AddRequestForPosterAdd> createState() => _AddRequestForPosterAddState();
}

class _AddRequestForPosterAddState extends State<AddRequestForPosterAdd> {
  ConstantColors cc = ConstantColors();

  final List<Map<String, dynamic>> _dayList = [
    {"id": 1, "dayName": "Sun"},
    {"id": 2, "dayName": "Mon"},
    {"id": 3, "dayName": "Tue"},
    {"id": 4, "dayName": "Wed"},
    {"id": 5, "dayName": "Thu"},
    {"id": 6, "dayName": "Fri"},
    {"id": 7, "dayName": "Sat"},
  ];

  void showDaySelectionDialog(BuildContext context) {
    List<Map<String, dynamic>> dayList = [
      {"id": 1, "dayName": "Sun"},
      {"id": 2, "dayName": "Mon"},
      {"id": 3, "dayName": "Tue"},
      {"id": 4, "dayName": "Wed"},
      {"id": 5, "dayName": "Thu"},
      {"id": 6, "dayName": "Fri"},
      {"id": 7, "dayName": "Sat"},
    ];

    String? selectedDay;

    showDialog(
      context: context,
      builder: (context) {
        return Consumer<GetImageController>(
          builder: (context, getImageController, child) {
            return AlertDialog(
              title: Text(
                "Add Your Banner and Description",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize:
                      MainAxisSize.min, // Important: Avoids loose constraints
                  children: [
                    CommonHelper()
                        .labelCommon2("Banner Images", isRequired: true),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Display image if fileSingle is available, otherwise show URL image
                          if (getImageController.fileSingle != null)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          border: Border.all(
                                              width: 1, color: cc.greyFive),
                                        ),
                                        child: getImageController.fileSingle !=
                                                null
                                            ? Image.file(
                                                getImageController.fileSingle!,
                                                height: 100,
                                                width: 150,
                                                fit: BoxFit.cover,
                                              )
                                            : Offstage()),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      if (getImageController.fileSingle !=
                                          null) {
                                        getImageController.removeFile();
                                      }
                                    },
                                    icon: const Icon(Icons.delete,
                                        color: Colors.red),
                                  ),
                                ],
                              ),
                            )
                          else
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: InkWell(
                                  onTap: () => getImageController.chooseImage(),
                                  child: Text(
                                    "No Image Selected \n(Tap Here For Select Image)",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Write Your Description Here",
                        prefixIcon: const Icon(Icons.description),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "Cancel",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, selectedDay);
                    print("Selected Day: $selectedDay"); // Handle selection
                  },
                  child: const Text(
                    "OK",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final getImageController = Provider.of<GetImageController>(context);
    return Consumer<AppStringService>(
      builder: (context, value, child) {
        return Scaffold(
          appBar: CommonHelper().appbarCommon(
            "Advertisement", context, () => Navigator.pop(context),
            // actions: [
            //   Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: InkWell(
            //       onTap: () {
            //         showDaySelectionDialog(context);
            //       },
            //       child: Container(
            //           alignment: Alignment.center,
            //           decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(6.0),
            //             color: cc.primaryColor,
            //           ),
            //           child: Padding(
            //             padding: const EdgeInsets.symmetric(
            //                 horizontal: 8.0, vertical: 4),
            //             child: Icon(
            //               Icons.add,
            //               color: cc.white,
            //             ),
            //           )),
            //     ),
            //   ),
            // ]
          ),
          body: _dayList.isEmpty
              ? Center(
                  child: OthersHelper().showLoading(cc.primaryColor),
                )
              : ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: PayBannerContainer(
                        description:
                            "Add Your Upper Banner Here This will show up to 1 Apr 2025",
                        price: "\u{20B9}100/-",
                        onTap: () {
                          // Handle the tap event here
                          print("Banner tapped! 1");
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: PayBannerContainer(
                        description:
                            "Add Your Lower Banner Here This will show up to 1 Apr 2025",
                        price: "\u{20B9}150/-",
                        onTap: () {
                          // Handle the tap event here
                          print("Banner tapped! 2");
                        },
                      ),
                    )
                  ],
                ),
        );
      },
    );
  }

  GestureDetector PayBannerContainer({
    String? description,
    String? price,
    VoidCallback? onTap,
  }) =>
      GestureDetector(
        // Use GestureDetector to handle taps
        onTap: onTap, // Call the onTap callback when the container is tapped
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: cc.primaryColor,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(color: cc.black6, blurRadius: 3, offset: Offset(0, 2))
              ]),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  textAlign: TextAlign.center,
                  description ??
                      "Add Your Banner Here This will show up to 1 Apr 2025",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: cc.white,
                  ),
                ),
                Text(
                  textAlign: TextAlign.center,
                  price ?? "\u{20B9}200/-",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: cc.white,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(width: 1, color: cc.white),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(
                      textAlign: TextAlign.center,
                      "Pay Now",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: cc.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

// ListView.builder(
// itemCount: 7,
// itemBuilder: (context, index) {
// return Padding(
// padding: const EdgeInsets.all(8.0),
// child: Container(
// decoration: BoxDecoration(
// color: cc.white,
// borderRadius: BorderRadius.circular(8.0),
// boxShadow: [
// BoxShadow(
// color: Colors.grey.withOpacity(0.2),
// blurRadius: 3,
// offset: Offset(0, 2),
// ),
// ],
// ),
// padding: EdgeInsets.symmetric(
// vertical: 12, horizontal: 10),
// child: Row(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// CommonHelper().profileImage(
// "https://i.pinimg.com/originals/96/64/a9/9664a927650847190ac0f1c29fb79c5f.jpg",
// 100,
// 100),
// SizedBox(width: 12),
// Expanded(
// child: Column(
// crossAxisAlignment:
// CrossAxisAlignment.start,
// mainAxisAlignment: MainAxisAlignment.start,
// children: [
// // RichText(
// //   text: TextSpan(
// //     text: "Description : ",
// //     style: TextStyle(
// //       fontSize: 14,
// //       fontWeight: FontWeight.w500,
// //       color: cc.black3,
// //     ),
// //     children: [
// //       TextSpan(
// //         text:
// //             "An advertisement description is a communication that promotes a product, service, or brand. It aims to attract interest, engagement, and sales",
// //         style: TextStyle(
// //           fontSize: 14,
// //           fontWeight: FontWeight.w400,
// //           color: cc.black6,
// //         ),
// //       ),
// //     ],
// //   ),
// // ),
// // SizedBox(height: 4),
// RichText(
// text: TextSpan(
// text: "Valid Upto : ",
// style: TextStyle(
// fontSize: 14,
// fontWeight: FontWeight.w500,
// color: cc.black3,
// ),
// children: [
// TextSpan(
// text: "1 Apr 2025",
// style: TextStyle(
// fontSize: 14,
// fontWeight: FontWeight.w400,
// color: cc.black6,
// ),
// ),
// ],
// ),
// ),
// SizedBox(height: 4),
// RichText(
// text: TextSpan(
// text: "Status : ",
// style: TextStyle(
// fontSize: 14,
// fontWeight: FontWeight.w500,
// color: cc.black3,
// ),
// children: [
// TextSpan(
// text: "Active",
// style: TextStyle(
// fontSize: 14,
// fontWeight: FontWeight.w400,
// color: cc.successColor,
// ),
// ),
// ],
// ),
// ),
// ],
// ),
// ),
// Icon(
// Icons.disabled_by_default,
// color: cc.errorColor,
// ),
// ],
// ),
// ));
// },
// )
