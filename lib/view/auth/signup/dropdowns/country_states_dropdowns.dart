import 'package:flutter/material.dart';
import 'package:qixer/view/auth/signup/dropdowns/area_dropdown.dart';
import 'package:qixer/view/auth/signup/dropdowns/country_dropdown.dart';
import 'package:qixer/view/auth/signup/dropdowns/state_dropdown.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/responsive.dart';

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
    return Column(
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
            CommonHelper().labelCommon("Choose country"),
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
            CommonHelper().labelCommon("Choose city"),
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
    );
  }
}

dropdownPlaceholder({required String hintText, textWidth}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
    decoration: BoxDecoration(
        border: Border.all(
          color: ConstantColors().greyFive,
        ),
        borderRadius: BorderRadius.circular(8)),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      SizedBox(
        width: textWidth,
        child: CommonHelper().paragraphCommon(lnProvider.getString(hintText),
            textAlign: TextAlign.left),
      ),
      const Icon(Icons.keyboard_arrow_down)
    ]),
  );
}
