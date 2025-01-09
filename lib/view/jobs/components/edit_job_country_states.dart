import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/jobs_service/edit_job_country_states_service.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/others_helper.dart';

class EditJobCountryStates extends StatefulWidget {
  const EditJobCountryStates({super.key, required this.jobIndex});

  final jobIndex;

  @override
  State<EditJobCountryStates> createState() => _EditJobCountryStatesState();
}

class _EditJobCountryStatesState extends State<EditJobCountryStates> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(microseconds: 500), () {
      Provider.of<EditJobCountryStatesService>(context, listen: false)
          .getCountryState(context, jobIndex: widget.jobIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();
    return Consumer<EditJobCountryStatesService>(
        builder: (context, provider, child) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //dropdown and search box
                const SizedBox(
                  width: 17,
                ),

                // Country dropdown ===============>
                CommonHelper().labelCommon("Choose country"),
                provider.countryDropdownList.isNotEmpty
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
                            value: provider.selectedCountry,
                            icon: Icon(Icons.keyboard_arrow_down_rounded,
                                color: cc.greyFour),
                            iconSize: 26,
                            elevation: 17,
                            style: TextStyle(color: cc.greyFour),
                            onChanged: (newValue) {
                              provider.setCountryValue(newValue);

                              // setting the id of selected value
                              provider.setSelectedCountryId(
                                  provider.countryDropdownIndexList[provider
                                      .countryDropdownList
                                      .indexOf(newValue)]);

                              //fetch states based on selected country
                              provider.fetchStates(context,
                                  countryId: provider.selectedCountryId,
                                  jobIndex: widget.jobIndex);
                            },
                            items: provider.countryDropdownList
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
                        children: [OthersHelper().showLoading(cc.primaryColor)],
                      ),

                const SizedBox(
                  height: 25,
                ),
                // States dropdown ===============>
                CommonHelper().labelCommon("Choose city"),
                provider.statesDropdownList.isNotEmpty
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
                            value: provider.selectedState,
                            icon: Icon(Icons.keyboard_arrow_down_rounded,
                                color: cc.greyFour),
                            iconSize: 26,
                            elevation: 17,
                            style: TextStyle(color: cc.greyFour),
                            onChanged: (newValue) {
                              provider.setStatesValue(newValue);

                              //setting the id of selected value
                              provider.setSelectedStatesId(
                                  provider.statesDropdownIndexList[provider
                                      .statesDropdownList
                                      .indexOf(newValue)]);
                            },
                            items: provider.statesDropdownList
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
                        children: [OthersHelper().showLoading(cc.primaryColor)],
                      ),
              ],
            ));
  }
}
