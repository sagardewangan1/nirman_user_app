import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:qixer/helper/extension/context_extension.dart';
import 'package:qixer/service/app_string_service.dart';
import 'package:qixer/view/VenderDashBoard/supportHistory.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/others_helper.dart';

class HelpSupport extends StatefulWidget {
  const HelpSupport({super.key});

  @override
  State<HelpSupport> createState() => _HelpSupportState();
}

class _HelpSupportState extends State<HelpSupport> {
  EnquiryType? _selectedEnquiryType;
  ConstantColors cc = ConstantColors();

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStringService>(
      builder: (context, asProvider, child) {
        return Scaffold(
          appBar: CommonHelper().appbarCommon(
              "Help & Support", context, () => Navigator.pop(context),
              actions: [
                IconButton(
                    onPressed: () => context.toPage(SupportHistory()),
                    icon: Icon(Icons.history))
              ]),
          body: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: cc.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                children: [
                  CommonHelper().labelCommon("Priority"),
                  DropdownSearch<EnquiryType>(
                    selectedItem: _selectedEnquiryType,
                    items: EnquiryType.values,
                    itemAsString: (EnquiryType type) => type.name,
                    onChanged: (EnquiryType? newValue) {
                      setState(() {
                        _selectedEnquiryType = newValue;
                      });
                    },
                    dropdownDecoratorProps: DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        labelText: "Set Priority",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  Gap(10),
                  CommonHelper().labelCommon("Title"),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Enter title",
                      prefixIcon: const Icon(
                        Icons.label_important,
                        size: 18,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  Gap(10),
                  CommonHelper().labelCommon("Description"),
                  TextField(
                      // controller: notesController,
                      maxLines: 6,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: ConstantColors().black5),
                              borderRadius: BorderRadius.circular(9)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: ConstantColors().primaryColor)),
                          errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: ConstantColors().warningColor)),
                          focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: ConstantColors().primaryColor)),
                          hintText: "Please Explain Your Problem",
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 18))),
                  Gap(20),
                  CommonHelper().buttonOrange(
                    "Submit",
                    () => print,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
