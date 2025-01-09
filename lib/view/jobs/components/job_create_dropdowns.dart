import 'package:flutter/material.dart';
import 'package:qixer/view/services/components/service_filter_dropdown_helper.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';

import '../../auth/signup/dropdowns/country_dropdown.dart';
import '../../auth/signup/dropdowns/state_dropdown.dart';
import '../../utils/constant_styles.dart';

class JobCreateDropdowns extends StatefulWidget {
  const JobCreateDropdowns({super.key});

  @override
  State<JobCreateDropdowns> createState() => _JobCreateDropdownsState();
}

class _JobCreateDropdownsState extends State<JobCreateDropdowns> {
  @override
  void initState() {
    super.initState();
    //fetch country
    // Provider.of<CountryStatesService>(context, listen: false)
    //     .fetchCountries(context);

    // Provider.of<AllServicesService>(context, listen: false)
    //     .fetchCategories(context);
  }

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(
        width: 17,
      ),
      // Category dropdown ===============>
      ServiceFilterDropdownHelper().categoryDropdown(cc, context),

      const SizedBox(
        height: 25,
      ),

      // States dropdown ===============>
      ServiceFilterDropdownHelper().subCategoryDropdown(cc, context),

      const SizedBox(
        height: 25,
      ),

      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //dropdown and search box

          // Country dropdown ===============>
          CommonHelper().labelCommon("Choose country"),
          const CountryDropdown(),

          sizedBoxCustom(20),
          // States dropdown ===============>
          CommonHelper().labelCommon("Choose states"),

          const StateDropdown()

          // const SizedBox(
          //   height: 25,
          // ),
          // CommonHelper()
          //     .labelCommon(lnProvider.getString("Choose area")),
          // provider.areaDropdownList.isNotEmpty &&
          //         provider.statesDropdownList.isNotEmpty
          //     ? Container(
          //         width: double.infinity,
          //         padding: const EdgeInsets.symmetric(horizontal: 15),
          //         decoration: BoxDecoration(
          //           border: Border.all(color: cc.greyFive),
          //           borderRadius: BorderRadius.circular(6),
          //         ),
          //         child: DropdownButtonHideUnderline(
          //           child: DropdownButton<String>(
          //             // menuMaxHeight: 200,
          //             // isExpanded: true,
          //             hint: Consumer<AppStringService>(
          //                 builder: (context, asProvider, child) {
          //               return Text(
          //                 asProvider.getString("Select area"),
          //                 style: TextStyle(
          //                     color: cc.greyPrimary.withOpacity(.8)),
          //               );
          //             }),
          //             value: provider.areaDropdownList
          //                     .contains(provider.selectedArea)
          //                 ? provider.selectedArea
          //                 : null,
          //             icon: Icon(Icons.keyboard_arrow_down_rounded,
          //                 color: cc.greyFour),
          //             iconSize: 26,
          //             elevation: 17,
          //             style: TextStyle(color: cc.greyFour),
          //             onChanged: (newValue) {
          //               provider.setAreaValue(newValue);

          //               //setting the id of selected value
          //               provider.setSelectedAreaId(
          //                   provider.areaDropdownIndexList[provider
          //                       .areaDropdownList
          //                       .indexOf(newValue)]);
          //             },
          //             items: provider.areaDropdownList
          //                 .map<DropdownMenuItem<String>>((value) {
          //               return DropdownMenuItem(
          //                 value: value,
          //                 child: Text(
          //                   value,
          //                   style: TextStyle(
          //                       color: cc.greyPrimary.withOpacity(.8)),
          //                 ),
          //               );
          //             }).toList(),
          //           ),
          //         ),
          //       )
          //     : Row(
          //         mainAxisAlignment: MainAxisAlignment.start,
          //         children: [
          //             OthersHelper().showLoading(cc.primaryColor)
          //           ])
        ],
      )
    ]);
  }
}
