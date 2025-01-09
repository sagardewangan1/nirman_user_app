import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/all_services_service.dart';
import 'package:qixer/view/services/components/service_filter_dropdown_helper.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';

import '../../auth/signup/dropdowns/country_dropdown.dart';
import '../../auth/signup/dropdowns/state_dropdown.dart';
import '../../utils/constant_styles.dart';

class JobEditDropdowns extends StatefulWidget {
  const JobEditDropdowns({super.key});

  @override
  State<JobEditDropdowns> createState() => _JobEditDropdownsState();
}

class _JobEditDropdownsState extends State<JobEditDropdowns> {
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
    return Consumer<AllServicesService>(
      builder: (context, filterProvider, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //dropdown and search box
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
            ],
          )
        ],
      ),
    );
  }
}
