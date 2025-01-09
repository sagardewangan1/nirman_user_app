import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/all_services_service.dart';
import 'package:qixer/service/dropdowns_services/country_dropdown_service.dart';
import 'package:qixer/view/auth/signup/dropdowns/country_dropdown.dart';
import 'package:qixer/view/auth/signup/dropdowns/state_dropdown.dart';
import 'package:qixer/view/services/components/service_filter_dropdown_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/constant_styles.dart';

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
    Provider.of<CountryDropdownService>(context, listen: false)
        .fetchCountries(context);

    Provider.of<AllServicesService>(context, listen: false)
        .fetchCategories(context);
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

          const CountryDropdown(),

          sizedBoxCustom(20),

          const StateDropdown()
        ],
      ),
    );
  }
}
