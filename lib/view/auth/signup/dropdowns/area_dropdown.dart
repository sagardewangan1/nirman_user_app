import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/dropdowns_services/area_dropdown_service.dart';
import 'package:qixer/view/auth/signup/dropdowns/area_dropdown_popup.dart';
import 'package:qixer/view/auth/signup/dropdowns/country_states_dropdowns.dart';

import '../../../utils/responsive.dart';

class AreaDropdown extends StatelessWidget {
  const AreaDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AreaDropdownService>(
      builder: (context, p, child) => InkWell(
        onTap: () {
          // p.fetchArea(context, isrefresh: true);
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (BuildContext context) {
                return SizedBox(
                    height: screenHeight / 2 +
                        MediaQuery.of(context).viewInsets.bottom / 2,
                    child: const AreaDropdownPopup());
              });
        },
        child: dropdownPlaceholder(hintText: p.selectedArea),
      ),
    );
  }
}
