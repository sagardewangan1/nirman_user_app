import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/dropdowns_services/country_dropdown_service.dart';
import 'package:qixer/view/auth/signup/dropdowns/country_dropdown_popup.dart';
import 'package:qixer/view/auth/signup/dropdowns/country_states_dropdowns.dart';

import '../../../utils/responsive.dart';

class CountryDropdown extends StatelessWidget {
  final textWidth;
  const CountryDropdown({this.textWidth, super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CountryDropdownService>(
      builder: (context, p, child) => InkWell(
        onTap: () {
          // p.fetchCountries(context, isrefresh: true);
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (BuildContext context) {
                return SizedBox(
                    height: screenHeight / 2 +
                        MediaQuery.of(context).viewInsets.bottom / 2,
                    child: const CountryDropdownPopup());
              });
        },
        child: dropdownPlaceholder(
            hintText: p.selectedCountry, textWidth: textWidth),
      ),
    );
  }
}
