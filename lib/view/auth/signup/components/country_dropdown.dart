import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/country_states_service.dart';
import 'package:qixer/service/searchbar_with_dropdown_service.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/others_helper.dart';

class CountryDropdown extends StatelessWidget {
  const CountryDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    //fetch country
    Provider.of<CountryStatesService>(context, listen: false)
        .fetchCountries(context);

    final cc = ConstantColors();

    return Consumer<CountryStatesService>(
      builder: (context, provider, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                      isExpanded: true,
                      value: provider.selectedCountry,
                      icon: Icon(Icons.keyboard_arrow_down_rounded,
                          color: cc.greyFour),
                      iconSize: 26,
                      elevation: 17,
                      style: TextStyle(color: cc.greyFour),
                      onChanged: (newValue) {
                        provider.setCountryValue(newValue);

                        // setting the id of selected value
                        provider.setSelectedCountryId(provider
                                .countryDropdownIndexList[
                            provider.countryDropdownList.indexOf(newValue)]);

                        //fetch states based on selected country
                        provider.fetchStates(
                            provider.selectedCountryId, context);
                        Provider.of<SearchBarWithDropdownService>(context,
                                listen: false)
                            .fetchService(context);
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
        ],
      ),
    );
  }
}
