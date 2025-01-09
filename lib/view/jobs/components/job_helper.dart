// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:qixer/service/app_string_service.dart';
// import 'package:qixer/view/utils/common_helper.dart';
// import 'package:qixer/view/utils/constant_colors.dart';
// import 'package:rflutter_alert/rflutter_alert.dart';

// class JobHelper {
//   final cc = ConstantColors();

//   hirePopup(BuildContext context) {
//     return Alert(
//         context: context,
//         style: AlertStyle(
//             alertElevation: 0,
//             overlayColor: Colors.black.withOpacity(.6),
//             alertPadding: const EdgeInsets.all(25),
//             isButtonVisible: false,
//             alertBorder: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(8),
//               side: const BorderSide(
//                 color: Colors.transparent,
//               ),
//             ),
//             titleStyle: const TextStyle(),
//             animationType: AnimationType.grow,
//             animationDuration: const Duration(milliseconds: 500)),
//         content: Container(
//           margin: const EdgeInsets.only(top: 22),
//           padding: const EdgeInsets.fromLTRB(14, 10, 14, 0),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(7),
//             boxShadow: [
//               BoxShadow(
//                   color: Colors.black.withOpacity(0.01),
//                   spreadRadius: -2,
//                   blurRadius: 13,
//                   offset: const Offset(0, 13)),
//             ],
//           ),
//           child: Consumer<AppStringService>(
//             builder: (context, asProvider, child) => Column(
//               children: [
//                 Text(
//                   '${asProvider.getString('Are you sure?')}?',
//                   style: TextStyle(color: cc.greyPrimary, fontSize: 17),
//                 ),
//                 const SizedBox(
//                   height: 25,
//                 ),
//                 Row(
//                   children: [
//                     Expanded(
//                         child: CommonHelper().borderButtonOrange(
//                             asProvider.getString('Cancel'), () {
//                       Navigator.pop(context);
//                     })),
//                     const SizedBox(
//                       width: 16,
//                     ),
//                     Consumer<LogoutService>(
//                       builder: (context, provider, child) => Expanded(
//                           child: CommonHelper().buttonOrange(
//                               asProvider.getString('Logout'), () {
//                         if (provider.isloading == false) {
                          
//                         }
//                       },
//                               isloading:
//                                   provider.isloading == false ? false : true)),
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           ),
//         )).show();
//   }
// }
