import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:qixer/service/app_string_service.dart';
import 'package:qixer/service/jobs_service/my_jobs_service.dart';
import 'package:qixer/service/rtl_service.dart';
import 'package:qixer/view/jobs/components/my_jobs_card.dart';
import 'package:qixer/view/jobs/components/my_jobs_page_appbar.dart';
import 'package:qixer/view/jobs/components/my_jobs_popup_menu.dart';
import 'package:qixer/view/jobs/job_details_page.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/constant_styles.dart';
import 'package:qixer/view/utils/others_helper.dart';

import '../../service/all_services_service.dart';

class MyJobsPage extends StatefulWidget {
  const MyJobsPage({super.key});

  @override
  _MyJobsPageState createState() => _MyJobsPageState();
}

class _MyJobsPageState extends State<MyJobsPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<AllServicesService>(context, listen: false)
        .fetchCategories(context);
  }

  final RefreshController refreshController =
      RefreshController(initialRefresh: true);

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: MyJobsPageAppbar(),
      ),
      body: SafeArea(
        child: SmartRefresher(
          controller: refreshController,
          enablePullUp: true,
          enablePullDown:
              context.watch<MyJobsService>().currentPage > 1 ? false : true,
          onRefresh: () async {
            final result =
                await Provider.of<MyJobsService>(context, listen: false)
                    .fetchMyJobs(context);
            if (result) {
              refreshController.refreshCompleted();
            } else {
              refreshController.refreshFailed();
            }
          },
          onLoading: () async {
            final result =
                await Provider.of<MyJobsService>(context, listen: false)
                    .fetchMyJobs(context);
            if (result) {
              debugPrint('loadcomplete ran');
              //loadcomplete function loads the data again
              refreshController.loadComplete();
            } else {
              debugPrint('no more data');
              refreshController.loadNoData();

              Future.delayed(const Duration(seconds: 1), () {
                //it will reset footer no data state to idle and will let us load again
                refreshController.resetNoData();
              });
            }
          },
          footer: OthersHelper().commonRefreshFooter(context),
          child: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: screenPadding),
                clipBehavior: Clip.none,
                child: Consumer<AppStringService>(
                  builder: (context, asProvider, child) =>
                      Consumer<MyJobsService>(
                          builder: (context, provider, child) {
                    return Column(
                      children: [
                        provider.myJobsListMap.isNotEmpty
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    sizedBoxCustom(10),
                                    Column(
                                      children: [
                                        for (int i = 0;
                                            i < provider.myJobsListMap.length;
                                            i++)
                                          InkWell(
                                            splashColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () {
                                              Provider.of<MyJobsService>(
                                                      context,
                                                      listen: false)
                                                  .setOrderDetailsLoadingStatus(
                                                      true);

                                              Navigator.push(
                                                context,
                                                MaterialPageRoute<void>(
                                                  builder:
                                                      (BuildContext context) =>
                                                          JobDetailsPage(
                                                    imageLink:
                                                        provider.imageList[i],
                                                    jobId: provider
                                                        .myJobsListMap[i]['id'],
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              margin: const EdgeInsets.only(
                                                  bottom: 20),
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: cc.borderColor),
                                                  borderRadius:
                                                      BorderRadius.circular(9)),
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      13, 0, 13, 4),
                                              child: Column(
                                                children: [
                                                  //popup button
                                                  //==============>
                                                  MyJobsPopupMenu(
                                                    jobId: provider
                                                        .myJobsListMap[i]['id'],
                                                    imageLink:
                                                        provider.imageList[i],
                                                    jobIndex: i,
                                                  ),

                                                  MyJobsCardContents(
                                                    cc: cc,
                                                    imageLink:
                                                        provider.imageList[i],
                                                    title: provider
                                                            .myJobsListMap[i]
                                                        ['title'],
                                                    viewCount: provider
                                                            .myJobsListMap[i]
                                                        ['viewCount'],
                                                    price: provider
                                                            .myJobsListMap[i]
                                                        ['price'],
                                                  ),

                                                  const SizedBox(
                                                    height: 18,
                                                  ),

                                                  CommonHelper()
                                                      .dividerCommon(),
                                                  sizedBoxCustom(3),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Row(
                                                          children: [
                                                            AutoSizeText(
                                                              '${asProvider.getString('Starts from')}:',
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                color: cc
                                                                    .greyFour
                                                                    .withOpacity(
                                                                        .6),
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 6,
                                                            ),
                                                            Consumer<
                                                                RtlService>(
                                                              builder: (context,
                                                                      rtlP,
                                                                      child) =>
                                                                  Expanded(
                                                                child:
                                                                    AutoSizeText(
                                                                  rtlP.currencyDirection ==
                                                                          'left'
                                                                      ? '${rtlP.currency} ${provider.myJobsListMap[i]['price']}'
                                                                      : '${provider.myJobsListMap[i]['price']}${rtlP.currency}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style:
                                                                      TextStyle(
                                                                    color: cc
                                                                        .greyFour,
                                                                    fontSize:
                                                                        19,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),

                                                      //on off button
                                                      Row(
                                                        children: [
                                                          CommonHelper()
                                                              .paragraphCommon(
                                                            asProvider
                                                                .getString(
                                                                    'On/Off'),
                                                          ),
                                                          Switch(
                                                            // This bool value toggles the switch.
                                                            value: provider
                                                                    .myJobsListMap[
                                                                i]['isActive'],
                                                            activeColor:
                                                                cc.successColor,
                                                            onChanged:
                                                                (bool value) {
                                                              provider
                                                                  .setActiveStatus(
                                                                      value, i);
                                                              provider.jobOnOff(
                                                                  context,
                                                                  index: i,
                                                                  jobId: provider
                                                                          .myJobsListMap[
                                                                      i]['id']);
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                      ],
                                    )

                                    //
                                  ])
                            : OthersHelper()
                                .showError(context, msg: 'No jobs found'),
                      ],
                    );
                  }),
                )),
          ),
        ),
      ),
    );
  }
}
