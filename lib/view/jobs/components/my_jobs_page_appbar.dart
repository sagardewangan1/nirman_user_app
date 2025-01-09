import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/app_string_service.dart';
import 'package:qixer/view/jobs/create_job_page.dart';
import 'package:qixer/view/utils/constant_colors.dart';

class MyJobsPageAppbar extends StatelessWidget {
  const MyJobsPageAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    ConstantColors cc = ConstantColors();
    return AppBar(
      iconTheme: IconThemeData(color: cc.greyPrimary),
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      title: Consumer<AppStringService>(
        builder: (context, ln, child) => Text(
          ln.getString('My jobs'),
          style: TextStyle(
              color: cc.greyPrimary, fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Icon(
          Icons.arrow_back_ios,
          size: 18,
        ),
      ),
      actions: [
        Consumer<AppStringService>(
          builder: (context, ln, child) => Container(
            width: screenWidth / 4,
            padding: const EdgeInsets.symmetric(
              vertical: 9,
            ),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const CreateJobPage(),
                  ),
                );
              },
              child: Container(
                  // width: double.infinity,

                  alignment: Alignment.center,
                  // padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                      color: cc.successColor,
                      borderRadius: BorderRadius.circular(8)),
                  child: AutoSizeText(
                    ln.getString('Create'),
                    maxLines: 1,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                    ),
                  )),
            ),
          ),
        ),
        const SizedBox(
          width: 25,
        ),
      ],
    );
  }
}
