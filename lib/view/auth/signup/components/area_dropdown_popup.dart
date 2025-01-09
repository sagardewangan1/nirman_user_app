import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/country_states_service.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/constant_styles.dart';
import 'package:qixer/view/utils/custom_input.dart';
import 'package:qixer/view/utils/others_helper.dart';

class AreaDropdownPopup extends StatelessWidget {
  // var countryId;
  // var stateId;

  const AreaDropdownPopup({super.key});

  @override
  Widget build(BuildContext context) {
    //fetch country
    // Provider.of<CountryStatesService>(context, listen: false)
    //     .fetchArea(countryId, stateId,context);

    final cc = ConstantColors();
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Consumer<CountryStatesService>(
            builder: (context, p, child) => Column(
              children: [
                sizedBoxCustom(30),
                CustomInput(
                  hintText: 'Search country',
                  paddingHorizontal: 17,
                  icon: 'assets/icons/search.png',
                ),
                sizedBoxCustom(10),
                p.areaDropdownList.isNotEmpty
                    ? p.areaDropdownList[0] != "ConstString.selectArea"
                        ? ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 64000,
                            itemBuilder: (context, i) {
                              return InkWell(
                                onTap: () {
//                                   p.setAreaValue(p.areaDropdownList[i]);

// //                         // setting the id of selected value
//                                   p.setSelectedAreaId(p.areaDropdownIndexList[p
//                                       .areaDropdownList
//                                       .indexOf(p.areaDropdownList[i])]);

//                                   Navigator.pop(context);
                                },
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 18),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom:
                                              BorderSide(color: cc.greyFive))),
                                  child: CommonHelper().paragraphCommon(
                                      '${p.areaDropdownList[0]}'),
                                ),
                              );
                            })
                        : CommonHelper()
                            .paragraphCommon("ConstString.noAreaFound")
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [OthersHelper().showLoading(cc.primaryColor)],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
