import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:qixer/model/job_request_model.dart';
import 'package:qixer/service/jobs_service/job_conversation_service.dart';
import 'package:qixer/service/jobs_service/job_request_service.dart';
import 'package:qixer/view/booking/payment_choose_page.dart';
import 'package:qixer/view/jobs/job_conversation_page.dart';
import 'package:qixer/view/jobs/job_details_page.dart';
import 'package:qixer/view/jobs/seller_info.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/constant_styles.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:qixer/view/utils/responsive.dart';

import '../../service/rtl_service.dart';

class JobRequestPage extends StatefulWidget {
  const JobRequestPage({super.key});

  @override
  _JobRequestPageState createState() => _JobRequestPageState();
}

class _JobRequestPageState extends State<JobRequestPage> {
  @override
  void initState() {
    super.initState();
  }

  ConstantColors cc = ConstantColors();
  final RefreshController refreshController =
      RefreshController(initialRefresh: true);

  List menuNames = ['View details', 'About seller', 'Conversation', 'Hire now'];

  @override
  Widget build(BuildContext context) {
    final rtlProvider = Provider.of<RtlService>(context, listen: false);
    return WillPopScope(
      onWillPop: () async {
        Provider.of<JobRequestService>(context, listen: false)
            .setShowJobDescriptionId(null);
        return true;
      },
      child: Scaffold(
        appBar: CommonHelper().appbarCommon('Job Requests', context, () {
          Provider.of<JobRequestService>(context, listen: false)
              .setShowJobDescriptionId(null);
          Navigator.pop(context);
        }),
        backgroundColor: cc.bgColor,
        body: SmartRefresher(
          controller: refreshController,
          enablePullUp: true,
          enablePullDown: true,
          onRefresh: () async {
            final result =
                await Provider.of<JobRequestService>(context, listen: false)
                    .fetchJobRequestList(context);
            if (result) {
              refreshController.refreshCompleted();
            } else {
              refreshController.refreshFailed();
            }
          },
          onLoading: () async {
            final result =
                await Provider.of<JobRequestService>(context, listen: false)
                    .fetchJobRequestList(context);
            if (result) {
              debugPrint('load complete ran');
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
            physics: physicsCommon,
            child: Consumer<JobRequestService>(
              builder: (context, provider, child) => provider
                      .jobReqList.isNotEmpty
                  ? Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenPadding, vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          for (int i = 0; i < provider.jobReqList.length; i++)
                            InkWell(
                              child: provider.jobReqList[i].job?.title ==
                                          null ||
                                      provider.jobReqList[i].seller == null
                                  ? const SizedBox()
                                  : Container(
                                      margin: const EdgeInsets.only(bottom: 16),
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 16),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(9)),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (ctx) {
                                                          final element =
                                                              provider
                                                                  .jobReqList[i];
                                                          final seller = provider
                                                              .jobReqList[i]
                                                              .seller as Seller;
                                                          return AlertDialog(
                                                              // title: Text(
                                                              //     lnProvider
                                                              //         .getString(
                                                              //             '')),
                                                              content:
                                                                  SellerInfo(
                                                            sellerId: seller.id,
                                                            sellerName:
                                                                seller.name ??
                                                                    '-',
                                                            imgUrl: element
                                                                .sellerImage,
                                                            sellerCountry: element
                                                                    .sellerCountry ??
                                                                '-',
                                                            sellerCity: element
                                                                    .sellerCity ??
                                                                '',
                                                            sellerCompleteOrder:
                                                                element
                                                                    .completedOrder,
                                                            completeOrder: element
                                                                .completedOrder,
                                                            orderCompletionRate:
                                                                element
                                                                    .orderCompletionRate,
                                                            createdAt: seller
                                                                    .createdAt ??
                                                                DateTime.now(),
                                                          ));
                                                        },
                                                      );
                                                    },
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          height: 30,
                                                          width: 30,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                              border: Border.all(
                                                                  color: cc
                                                                      .borderColor)),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                            child:
                                                                CachedNetworkImage(
                                                              fit: BoxFit.cover,
                                                              imageUrl: provider
                                                                      .jobReqList[
                                                                          i]
                                                                      .sellerImage ??
                                                                  '',
                                                              placeholder: (context,
                                                                      url) =>
                                                                  Image.asset(
                                                                      'assets/images/avatar.png'),
                                                              errorWidget:
                                                                  (context, url,
                                                                          error) =>
                                                                      Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(5),
                                                                child: Image.asset(
                                                                    'assets/images/icon.png'),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 8),
                                                        CommonHelper().titleCommon(
                                                            provider
                                                                    .jobReqList[
                                                                        i]
                                                                    .sellerName ??
                                                                '-',
                                                            fontsize: 14),
                                                      ],
                                                    ),
                                                  ),
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            // horizontal: 20,
                                                            vertical: 6),
                                                    child: Divider(),
                                                  ),
                                                  CommonHelper().titleCommon(
                                                      provider.jobReqList[i].job
                                                              ?.title ??
                                                          '-',
                                                      fontsize: 15),
                                                  sizedBoxCustom(8),
                                                  CommonHelper()
                                                      .paragraphCommon(
                                                    lnProvider.getString(
                                                            'Your offer') +
                                                        ': ' +
                                                        (rtlProvider.currencyDirection ==
                                                                'left'
                                                            ? '${rtlProvider.currency}${provider.jobReqList[i].job?.price ?? 0}'
                                                            : '${provider.jobReqList[i].job.price}${rtlProvider.currency}'),
                                                  ),
                                                  sizedBoxCustom(6),
                                                  CommonHelper().paragraphCommon(
                                                      lnProvider.getString(
                                                              'Seller offer') +
                                                          ': ' +
                                                          (rtlProvider.currencyDirection ==
                                                                  'left'
                                                              ? '${rtlProvider.currency}${provider.jobReqList[i].expectedSalary}'
                                                              : '${provider.jobReqList[i].expectedSalary}${rtlProvider.currency}'),
                                                      color: cc.successColor),
                                                  if (provider
                                                          .showJobDescriptionId ==
                                                      provider.jobReqList[i].id)
                                                    sizedBoxCustom(6),
                                                  if (provider
                                                          .showJobDescriptionId ==
                                                      provider.jobReqList[i].id)
                                                    CommonHelper()
                                                        .paragraphCommon(
                                                      lnProvider.getString(
                                                              'Description') +
                                                          ': ' +
                                                          ('${provider.jobReqList[i].coverLetter}'),
                                                    ),
                                                  sizedBoxCustom(6),
                                                  GestureDetector(
                                                    onTap: () {
                                                      if (provider
                                                              .showJobDescriptionId ==
                                                          provider.jobReqList[i]
                                                              .id) {
                                                        provider
                                                            .setShowJobDescriptionId(
                                                                null);
                                                        return;
                                                      }
                                                      provider
                                                          .setShowJobDescriptionId(
                                                              provider
                                                                  .jobReqList[i]
                                                                  .id);
                                                    },
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          provider.showJobDescriptionId ==
                                                                  provider
                                                                      .jobReqList[
                                                                          i]
                                                                      .id
                                                              ? Icons
                                                                  .keyboard_arrow_up_rounded
                                                              : Icons
                                                                  .keyboard_arrow_down,
                                                          color:
                                                              cc.primaryColor,
                                                        ),
                                                        const SizedBox(
                                                            width: 8),
                                                        CommonHelper().titleCommon(
                                                            provider.showJobDescriptionId ==
                                                                    provider
                                                                        .jobReqList[
                                                                            i]
                                                                        .id
                                                                ? "Hide Description"
                                                                : "Show Description",
                                                            color:
                                                                cc.primaryColor,
                                                            fontsize: 14),
                                                      ],
                                                    ),
                                                  )
                                                  // TextButton(
                                                  //   onPressed: () {},
                                                  //   style: TextButton.styleFrom(
                                                  //       backgroundColor: cc.primaryColor
                                                  //           .withOpacity(0.03)),
                                                  //   child: CommonHelper().labelCommon(
                                                  //     "Show Description",
                                                  //   ),
                                                  // )
                                                ]),
                                          ),
                                          Column(
                                            children: [
                                              PopupMenuButton(
                                                itemBuilder:
                                                    (BuildContext context) =>
                                                        <PopupMenuEntry>[
                                                  //View details
                                                  PopupMenuItem(
                                                    onTap: () {
                                                      Future.delayed(
                                                          Duration.zero, () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute<
                                                              void>(
                                                            builder: (BuildContext
                                                                    context) =>
                                                                JobDetailsPage(
                                                              imageLink: provider
                                                                      .jobReqList[
                                                                          i]
                                                                      .jobImage ??
                                                                  '',
                                                              jobId: provider
                                                                  .jobReqList[i]
                                                                  .job
                                                                  .id,
                                                            ),
                                                          ),
                                                        );
                                                      });
                                                    },
                                                    child: Text(
                                                        lnProvider.getString(
                                                            menuNames[0])),
                                                  ),

                                                  //About seller
                                                  PopupMenuItem(
                                                    onTap: () async {
                                                      await Future.delayed(
                                                          const Duration(
                                                              microseconds:
                                                                  10));
                                                      showDialog(
                                                        context: context,
                                                        builder: (ctx) {
                                                          final element =
                                                              provider
                                                                  .jobReqList[i];
                                                          final seller = provider
                                                              .jobReqList[i]
                                                              .seller as Seller;
                                                          return AlertDialog(
                                                              // title: Text(
                                                              //     lnProvider
                                                              //         .getString(
                                                              //             '')),
                                                              content:
                                                                  SellerInfo(
                                                            sellerId: seller.id,
                                                            sellerName:
                                                                seller.name ??
                                                                    '-',
                                                            imgUrl: element
                                                                .sellerImage,
                                                            sellerCountry: element
                                                                    .sellerCountry ??
                                                                '-',
                                                            sellerCity: element
                                                                    .sellerCity ??
                                                                '',
                                                            sellerCompleteOrder:
                                                                element
                                                                    .completedOrder,
                                                            completeOrder: element
                                                                .completedOrder,
                                                            orderCompletionRate:
                                                                element
                                                                    .orderCompletionRate,
                                                            createdAt: seller
                                                                    .createdAt ??
                                                                DateTime.now(),
                                                          ));
                                                        },
                                                      );
                                                    },
                                                    child: Text(
                                                        lnProvider.getString(
                                                            menuNames[1])),
                                                  ),
                                                  PopupMenuItem(
                                                    onTap: () {
                                                      Future.delayed(
                                                          Duration.zero, () {
                                                        //fetch message
                                                        Provider.of<JobConversationService>(
                                                                context,
                                                                listen: false)
                                                            .fetchMessages(
                                                                jobRequestId:
                                                                    provider
                                                                        .jobReqList[
                                                                            i]
                                                                        .id);

                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute<
                                                              void>(
                                                            builder: (BuildContext
                                                                    context) =>
                                                                JobConversationPage(
                                                              title: provider
                                                                  .jobReqList[i]
                                                                  .job
                                                                  .title,
                                                              jobRequestId:
                                                                  provider
                                                                      .jobReqList[
                                                                          i]
                                                                      .id,
                                                              sellerId: provider
                                                                  .jobReqList[i]
                                                                  .sellerId,
                                                            ),
                                                          ),
                                                        );
                                                      });
                                                    },
                                                    child: Text(
                                                        lnProvider.getString(
                                                            menuNames[2])),
                                                  ),

                                                  //Hire now
                                                  PopupMenuItem(
                                                    onTap: () {
                                                      //set price
                                                      Provider.of<JobRequestService>(
                                                              context,
                                                              listen: false)
                                                          .setSelectedJobPriceAndId(
                                                              price: provider
                                                                  .jobReqList[i]
                                                                  .expectedSalary,
                                                              id: provider
                                                                  .jobReqList[i]
                                                                  .id);

                                                      Future.delayed(
                                                          Duration.zero, () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute<
                                                              void>(
                                                            builder: (BuildContext
                                                                    context) =>
                                                                const PaymentChoosePage(
                                                              isFromHireJob:
                                                                  true,
                                                            ),
                                                          ),
                                                        );
                                                      });
                                                    },
                                                    child: Text(
                                                        lnProvider.getString(
                                                            menuNames[3])),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                            ),
                        ],
                      ),
                    )
                  : OthersHelper().showError(context, msg: 'No request found'),
            ),
          ),
        ),
      ),
    );
  }
}
