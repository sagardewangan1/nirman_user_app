import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/app_string_service.dart';
import 'package:qixer/service/jobs_service/my_jobs_service.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class MyJobsHelper {
  final cc = ConstantColors();

  deletePopup(BuildContext context, {required index, required jobId}) {
    return Alert(
        context: context,
        style: AlertStyle(
            alertElevation: 0,
            overlayColor: Colors.black.withOpacity(.6),
            alertPadding: const EdgeInsets.all(25),
            isButtonVisible: false,
            alertBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: const BorderSide(
                color: Colors.transparent,
              ),
            ),
            titleStyle: const TextStyle(),
            animationType: AnimationType.grow,
            animationDuration: const Duration(milliseconds: 500)),
        content: Container(
          margin: const EdgeInsets.only(top: 22),
          padding: const EdgeInsets.fromLTRB(14, 10, 14, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.01),
                  spreadRadius: -2,
                  blurRadius: 13,
                  offset: const Offset(0, 13)),
            ],
          ),
          child: Consumer<AppStringService>(
            builder: (context, asProvider, child) => Consumer<MyJobsService>(
              builder: (context, provider, child) => Column(
                children: [
                  Text(
                    '${asProvider.getString('Are you sure?')}',
                    style: TextStyle(color: cc.greyPrimary, fontSize: 17),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: CommonHelper().borderButtonOrange(
                              asProvider.getString('Cancel'), () {
                        Navigator.pop(context);
                      }, bgColor: Colors.grey)),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                          child: CommonHelper()
                              .buttonOrange(asProvider.getString('Delete'), () {
                        provider.deleteJob(context, index: index, jobId: jobId);
                      },
                                  bgColor: Colors.red,
                                  isloading: provider.loadingDeleteJob))
                    ],
                  )
                ],
              ),
            ),
          ),
        )).show();
  }
}
