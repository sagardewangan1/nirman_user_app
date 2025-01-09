import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/country_states_service.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/others_helper.dart';

import '../../../../service/app_string_service.dart';

class AreaDropdown extends StatelessWidget {
  const AreaDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    final cc = ConstantColors();

    return Consumer<CountryStatesService>(
      builder: (context, provider, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          provider.areaDropdownList.isNotEmpty &&
                  provider.selectedStateId != null
              ? Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    border: Border.all(color: cc.greyFive),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      // menuMaxHeight: 200,
                      // isExpanded: true,
                      hint: Consumer<AppStringService>(
                          builder: (context, asProvider, child) {
                        return Text(
                          asProvider.getString("Select area"),
                          style:
                              TextStyle(color: cc.greyPrimary.withOpacity(.8)),
                        );
                      }),
                      value: provider.areaDropdownList
                              .contains(provider.selectedArea)
                          ? provider.selectedArea
                          : null,
                      icon: Icon(Icons.keyboard_arrow_down_rounded,
                          color: cc.greyFour),
                      iconSize: 26,
                      elevation: 17,
                      style: TextStyle(color: cc.greyFour),
                      onChanged: (newValue) {
                        provider.setAreaValue(newValue);

                        //setting the id of selected value
                        provider.setSelectedAreaId(
                            provider.areaDropdownIndexList[
                                provider.areaDropdownList.indexOf(newValue)]);
                      },
                      items: provider.areaDropdownList
                          .map<DropdownMenuItem<String>>((value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(
                                color: cc.greyPrimary.withOpacity(.8)),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [OthersHelper().showLoading(cc.primaryColor)])
        ],
      ),
    );
  }
}
