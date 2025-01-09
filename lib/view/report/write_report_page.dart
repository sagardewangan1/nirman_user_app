// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/leave_feedback_service.dart';
import 'package:qixer/service/profile_service.dart';
import 'package:qixer/view/booking/components/textarea_field.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/constant_styles.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:qixer/view/utils/responsive.dart';

class WriteReportPage extends StatefulWidget {
  const WriteReportPage({
    super.key,
    required this.serviceId,
    required this.orderId,
  });

  final serviceId;
  final orderId;
  @override
  State<WriteReportPage> createState() => _WriteReportPageState();
}

class _WriteReportPageState extends State<WriteReportPage> {
  double rating = 1;
  TextEditingController reportController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonHelper().appbarCommon('Report', context, () {
        Navigator.pop(context);
      }),
      body: SingleChildScrollView(
        physics: physicsCommon,
        child: Consumer<ProfileService>(
          builder: (context, profileProvider, child) => Container(
            padding: EdgeInsets.symmetric(horizontal: screenPadding),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(
                height: 15,
              ),
              sizedBox20(),
              Text(
                lnProvider.getString('What went wrong?'),
                style: TextStyle(
                    color: cc.greyFour,
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 14,
              ),
              TextareaField(
                notesController: reportController,
                hintText: lnProvider.getString('Write the issue'),
              ),
              sizedBox20(),
              Consumer<LeaveFeedbackService>(
                builder: (context, lfProvider, child) =>
                    CommonHelper().buttonOrange('Submit Report', () {
                  if (lfProvider.reportLoading == false) {
                    if (reportController.text.trim().isEmpty) {
                      OthersHelper().showToast(
                          'You must write something to submit report',
                          Colors.black);
                      return;
                    }
                    lfProvider.leaveReport(context,
                        message: reportController.text,
                        orderId: widget.orderId,
                        serviceId: widget.serviceId);
                  }
                }, isloading: lfProvider.reportLoading),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
