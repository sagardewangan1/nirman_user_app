import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/app_string_service.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/others_helper.dart';

class SupportHistory extends StatefulWidget {
  const SupportHistory({super.key});

  @override
  State<SupportHistory> createState() => _SupportHistoryState();
}

class _SupportHistoryState extends State<SupportHistory> {
  EnquiryType? _selectedEnquiryType;
  ConstantColors cc = ConstantColors();

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStringService>(
      builder: (context, asProvider, child) {
        return SafeArea(
          child: Scaffold(
            appBar: CommonHelper().appbarCommon(
              "Support History",
              context,
              () => Navigator.pop(context),
            ),
            body: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: cc.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                  itemBuilder: (context, index) {
                    return Container();
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
