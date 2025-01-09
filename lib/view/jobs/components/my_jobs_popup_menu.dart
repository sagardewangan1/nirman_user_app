import 'package:flutter/material.dart';
import 'package:qixer/view/jobs/components/my_jobs_helper.dart';
import 'package:qixer/view/jobs/edit_job_page.dart';
import 'package:qixer/view/utils/responsive.dart';

class MyJobsPopupMenu extends StatelessWidget {
  const MyJobsPopupMenu({
    super.key,
    required this.jobId,
    required this.imageLink,
    required this.jobIndex,
  });

  final jobId;
  final imageLink;
  final jobIndex;

  @override
  Widget build(BuildContext context) {
    List popupMenuList = ['Edit', 'Delete'];

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        PopupMenuButton(
          itemBuilder: (BuildContext context) => <PopupMenuEntry>[
            for (int i = 0; i < popupMenuList.length; i++)
              PopupMenuItem(
                onTap: () {
                  Future.delayed(Duration.zero, () {
                    navigate(i, context, jobId, imageLink, jobIndex);
                  });
                },
                child: Text(lnProvider.getString(popupMenuList[i])),
              ),
          ],
        )
      ],
    );
  }

  navigate(int i, BuildContext context, jobId, imageLink, jobIndex) {
    // if (i == 0) {
    //   return Navigator.push(
    //     context,
    //     MaterialPageRoute<void>(
    //       builder: (BuildContext context) => JobDetailsPage(
    //         imageLink: imageLink,
    //         jobId: jobId,
    //       ),
    //     ),
    //   );
    // } else
    if (i == 0) {
      return Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => EditJobPage(
            jobIndex: jobIndex,
            jobId: jobId,
          ),
        ),
      );
    } else if (i == 1) {
      MyJobsHelper().deletePopup(context, index: jobIndex, jobId: jobId);
    } else if (i == 3) {
// return Navigator.push(
//         context,
//         MaterialPageRoute<void>(
//           builder: (BuildContext context) => const JobDetailsPage(),
//         ),
//       );
    }
  }
}
