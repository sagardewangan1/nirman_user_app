// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:qixer/service/serachbar_with_dropdown_service.dart';
// import 'package:qixer/view/utils/constant_colors.dart';

// class AllCityDropdown extends StatelessWidget {
//   const AllCityDropdown({Key? key, required this.searchText}) : super(key: key);
//   final searchText;

//   @override
//   Widget build(BuildContext context) {
//     final cc = ConstantColors();

//     return Consumer<SearchBarWithDropdownService>(
//       builder: (context, provider, child) => Column(
//         children: [
//           // dropdown ===========
//           // provider.userStateId == null
//           //     ?
//           provider.cityDropdownList.isNotEmpty
//               ? Row(
//                   children: [
//                     const SizedBox(
//                       width: 17,
//                     ),
//                     Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 15),
//                       decoration: BoxDecoration(
//                         color: const Color(0xffF5F5F5),
//                         boxShadow: [
//                           BoxShadow(
//                               color: Colors.black.withOpacity(0.01),
//                               spreadRadius: -2,
//                               blurRadius: 13,
//                               offset: const Offset(0, 13)),
//                         ],
//                         borderRadius: BorderRadius.circular(6),
//                       ),
//                       child: DropdownButtonHideUnderline(
//                         child: DropdownButton<String>(
//                           // menuMaxHeight: 200,
//                           // isExpanded: true,
//                           value: provider.selectedCity,
//                           icon: Icon(Icons.keyboard_arrow_down_rounded,
//                               color: cc.greyFour),
//                           iconSize: 26,
//                           elevation: 17,
//                           style: const TextStyle(color: Color(0xff646464)),
//                           onChanged: (newValue) {
//                             provider.setCityValue(newValue);

//                             // setting the id of selected value
//                             provider.setSelectedCityId(provider
//                                     .cityDropdownIndexList[
//                                 provider.cityDropdownList.indexOf(newValue!)]);

//                             provider.fetchService(
//                               context,
//                               searchText,
//                             );
//                           },
//                           items: provider.cityDropdownList
//                               .map<DropdownMenuItem<String>>((value) {
//                             return DropdownMenuItem(
//                               value: value,
//                               child: Text(
//                                 value,
//                                 style: TextStyle(
//                                     color: cc.greyPrimary.withOpacity(.8)),
//                               ),
//                             );
//                           }).toList(),
//                         ),
//                       ),
//                     ),
//                   ],
//                 )
//               : Container()
//         ],
//       ),
//     );
//   }
// }
