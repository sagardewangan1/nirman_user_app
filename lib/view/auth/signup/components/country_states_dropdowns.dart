import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/country_states_service.dart';
import 'package:qixer/view/auth/signup/dropdowns/country_dropdown.dart';
import 'package:qixer/view/auth/signup/dropdowns/state_dropdown.dart';
import 'package:qixer/view/auth/signup/dropdowns/area_dropdown.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/responsive.dart';

import '../../../utils/constant_colors.dart';

class CountryStatesDropdowns extends StatefulWidget {
  const CountryStatesDropdowns({super.key});

  @override
  State<CountryStatesDropdowns> createState() => _CountryStatesDropdownsState();
}

class _CountryStatesDropdownsState extends State<CountryStatesDropdowns> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CountryStatesService>(
        builder: (context, provider, child) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //dropdown and search box
                const SizedBox(
                  width: 17,
                ),

                // Country dropdown ===============>
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonHelper()
                        .labelCommon(lnProvider.getString("Choose country")),
                    const CountryDropdown(),
                  ],
                ),

                const SizedBox(
                  height: 25,
                ),
                // States dropdown ===============>
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonHelper()
                        .labelCommon(lnProvider.getString("Choose city")),
                    const StateDropdown(),
                  ],
                ),

                const SizedBox(
                  height: 25,
                ),

                // Area dropdown ===============>
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonHelper().labelCommon("Choose area"),
                    const AreaDropdown(),
                  ],
                )
              ],
            ));
  }

  dropdownPlaceholder({required String hintText}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 17),
      decoration: BoxDecoration(
          border: Border.all(
            color: ConstantColors().greyFive,
          ),
          borderRadius: BorderRadius.circular(8)),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        CommonHelper().paragraphCommon(hintText),
        const Icon(Icons.keyboard_arrow_down)
      ]),
    );
  }
}
