import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/common_service.dart';
import 'package:qixer/service/jobs_service/my_jobs_service.dart';
import 'package:qixer/service/rtl_service.dart';
import 'package:qixer/view/jobs/components/overview_box.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/constant_styles.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:qixer/view/utils/responsive.dart';

class JobDetailsPage extends StatefulWidget {
  const JobDetailsPage({
    super.key,
    required this.imageLink,
    required this.jobId,
  });

  final imageLink;
  final jobId;

  @override
  State<JobDetailsPage> createState() => _JobDetailsPageState();
}

class _JobDetailsPageState extends State<JobDetailsPage> {
  @override
  void initState() {
    super.initState();

    Provider.of<MyJobsService>(context, listen: false)
        .fetchJobDetails(widget.jobId, context);
  }

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();
    final rtlProvider = Provider.of<RtlService>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonHelper().appbarCommon('', context, () {
        Navigator.pop(context);
      }),
      body: SingleChildScrollView(
          child: Consumer<MyJobsService>(
        builder: (context, provider, child) => provider.loadingOrderDetails ==
                false
            ? Container(
                padding: EdgeInsets.symmetric(horizontal: screenPadding),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          height: 180,
                          width: double.infinity,
                          imageUrl: widget.imageLink,
                          errorWidget: (context, url, error) => Padding(
                            padding: const EdgeInsets.all(24),
                            child: Image.asset(
                              'assets/images/icon.png',
                              color: Colors.white.withOpacity(.5),
                              colorBlendMode: BlendMode.lighten,
                            ),
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      sizedBoxCustom(22),
                      Text(
                        provider.jobDetails.title.toString(),
                        style: TextStyle(
                            color: cc.greyFour,
                            fontSize: 18,
                            height: 1.4,
                            fontWeight: FontWeight.bold),
                      ),
                      sizedBoxCustom(22),
                      //Overview
                      Row(
                        children: [
                          OverviewBox(
                            title: lnProvider.getString('Budget'),
                            subtitle: rtlProvider.currencyDirection == 'left'
                                ? '${rtlProvider.currency}${provider.jobDetails.price}'
                                : '${provider.jobDetails.price}${rtlProvider.currency}',
                          ),
                          const SizedBox(
                            width: 15,
                          ),

                          OverviewBox(
                            title: lnProvider.getString('Deadline'),
                            subtitle:
                                '${getDate(provider.jobDetails.deadLine)}',
                          ),

                          // const OverviewBox(
                          //   title: 'Location',
                          //   subtitle: 'Dhaka, Bangladesh',
                          // ),
                        ],
                      ),

                      sizedBoxCustom(14),

                      //Overview
                      // Row(
                      //   children: [
                      //     OverviewBox(
                      //       title: 'Deadline',
                      //       subtitle:
                      //           '${getDate(provider.jobDetails.deadLine)}',
                      //     ),
                      //     const SizedBox(
                      //       width: 15,
                      //     ),
                      //     // const OverviewBox(
                      //     //   title: 'Category',
                      //     //   subtitle: 'Medical',
                      //     // ),
                      //   ],
                      // ),

                      //Description
                      // ===============>
                      // sizedBoxCustom(15),

                      HtmlWidget('''${provider.jobDetails.description}'''),
                      // CommonHelper().paragraphCommon(
                      //     provider.jobDetails.description.toString(),
                      //     TextAlign.left),

                      sizedBoxCustom(20),
                    ]),
              )
            : Container(
                height: screenHeight - 120,
                alignment: Alignment.center,
                child: OthersHelper().showLoading(cc.primaryColor),
              ),
      )),
    );
  }
}
