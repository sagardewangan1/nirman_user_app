import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/dropdowns_services/state_dropdown_services.dart';
import 'package:qixer/view/auth/signup/dropdowns/country_states_dropdowns.dart';
import 'package:qixer/view/auth/signup/dropdowns/state_dropdown_popup.dart';

import '../../../utils/responsive.dart';

class StateDropdown extends StatelessWidget {
  final textWidth;
  const StateDropdown({this.textWidth, super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<StateDropdownService>(
      builder: (context, p, child) => InkWell(
        onTap: () {
          // p.fetchStates(context, isrefresh: true);
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (BuildContext context) {
                return SizedBox(
                    height: screenHeight / 2 +
                        MediaQuery.of(context).viewInsets.bottom / 2,
                    child: const StateDropdownPopup());
              });
        },
        child: dropdownPlaceholder(
            hintText: p.selectedState, textWidth: textWidth),
      ),
    );
  }
}
