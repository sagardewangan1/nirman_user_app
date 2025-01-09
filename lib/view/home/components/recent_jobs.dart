import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/app_string_service.dart';
import 'package:qixer/service/jobs_service/my_jobs_service.dart';
import 'package:qixer/service/jobs_service/recent_jobs_service.dart';
import 'package:qixer/service/rtl_service.dart';
import 'package:qixer/view/home/components/section_title.dart';
import 'package:qixer/view/jobs/components/my_jobs_card.dart';
import 'package:qixer/view/jobs/job_details_page.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/constant_styles.dart';
import 'package:qixer/view/utils/responsive.dart';

class RecentJobs extends StatelessWidget {
  const RecentJobs({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cc = ConstantColors();

    return Consumer<RecentJobsService>(
        builder: (context, provider, child) => Consumer<AppStringService>(
              builder: (context, asProvider, child) => provider.recentJobs !=
                          null &&
                      provider.recentJobs.isNotEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        sizedBoxCustom(30),
                        SectionTitle(
                          cc: cc,
                          title: lnProvider.getString('Recent jobs'),
                          hasSeeAllBtn: false,
                          pressed: () {},
                        ),
                        sizedBoxCustom(18),
                        Container(
                          margin: const EdgeInsets.only(top: 5),
                          height: 150,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            clipBehavior: Clip.none,
                            children: [
                              //
                              for (int i = 0;
                                  i < provider.recentJobs.length;
                                  i++)
                                //
                                InkWell(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () {
                                    //         ['id']
                                    //     .toString());

                                    Provider.of<MyJobsService>(context,
                                            listen: false)
                                        .setOrderDetailsLoadingStatus(true);

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute<void>(
                                        builder: (BuildContext context) =>
                                            JobDetailsPage(
                                          imageLink:
                                              provider.recentJobsImages.length >
                                                      i
                                                  ? provider.recentJobsImages[i]
                                                      .imgUrl
                                                  : '',
                                          jobId: provider.recentJobs[i].id,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.only(right: 20),
                                    width: 320,
                                    decoration: BoxDecoration(
                                        border:
                                            Border.all(color: cc.borderColor),
                                        borderRadius: BorderRadius.circular(9)),
                                    padding:
                                        const EdgeInsets.fromLTRB(13, 0, 13, 4),
                                    child: Column(
                                      children: [
                                        sizedBoxCustom(13),
                                        MyJobsCardContents(
                                          cc: cc,
                                          imageLink:
                                              provider.recentJobsImages.length >
                                                      i
                                                  ? provider.recentJobsImages[i]
                                                      .imgUrl
                                                  : '',
                                          title: provider.recentJobs[i].title,
                                          viewCount:
                                              provider.recentJobs[i].view,
                                          price: provider.recentJobs[i].price,
                                        ),
                                        sizedBoxCustom(10),
                                        CommonHelper().dividerCommon(),
                                        sizedBoxCustom(8),
                                        Row(
                                          children: [
                                            AutoSizeText(
                                              '${asProvider.getString('Starts from')}:',
                                              textAlign: TextAlign.start,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color:
                                                    cc.greyFour.withOpacity(.6),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 6,
                                            ),
                                            Consumer<RtlService>(
                                              builder: (context, rtlP, child) =>
                                                  AutoSizeText(
                                                rtlP.currencyDirection == 'left'
                                                    ? '${rtlP.currency} ${provider.recentJobs[i].price}'
                                                    : '${provider.recentJobs[i].price}${rtlP.currency}',
                                                textAlign: TextAlign.start,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: cc.greyFour,
                                                  fontSize: 19,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                )
                            ],
                          ),
                        ),
                      ],
                    )
                  : Container(),
            ));
  }
}
