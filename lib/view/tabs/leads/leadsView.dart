import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:qixer/helper/contactFeatures.dart';
import 'package:qixer/helper/extension/context_extension.dart';
import 'package:qixer/helper/extension/dateTimeExtension.dart';
import 'package:qixer/model/navigationModel.dart';
import 'package:qixer/service/app_string_service.dart';
import 'package:qixer/service/leadsController/leadsController.dart';
import 'package:qixer/service/profile_service.dart';
import 'package:qixer/service/vendorDashboardService/vendorDashboardService.dart';
import 'package:qixer/view/VenderDashBoard/subscriptionModule.dart';
import 'package:qixer/view/home/components/section_title.dart';
import 'package:qixer/view/tabs/leads/leadsDetailsView.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:qixer/view/utils/responsive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../model/MyLeadsDataModel.dart';
import '../../utils/login_or_register.dart';
import 'components/LeadDetailsItemCard.dart';
import 'components/LeadItemCard.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LeadsView extends StatefulWidget {
  final NavigationModel? navigationModel;
  const LeadsView({super.key, this.navigationModel});

  @override
  State<LeadsView> createState() => _LeadsViewState();
}

class _LeadsViewState extends State<LeadsView> {
  final ConstantColors cc = ConstantColors();
  bool _isSubscribed = false;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      firstLoad();
    });
    super.initState();
  }

  firstLoad() async {
    final leadController = Provider.of<LeadsController>(context, listen: false);
    if (mounted) {
      final profileController =
          Provider.of<ProfileService>(context, listen: false);
      await profileController.getProfileDetails(context: context);
      setState(() {});
      if (await checkAuth()) {
        leadController.setIsNew(false);
        leadController.getMyLeads();
        final vendorDashboardController =
            Provider.of<VendorDashboardService>(context, listen: false);
        bool result = await vendorDashboardController.checkSubscribe(index: 0);
        _isSubscribed = result;
      }
    }
  }

  bool isLoggedIn = false;
  Future<bool> checkAuth() async {
    final prefs = await SharedPreferences.getInstance();
    // Set default values instead of removing
    isLoggedIn = await prefs.getBool('shashaktnirman_is_logged_in') ?? false;
    return isLoggedIn;
  }

  @override
  Widget build(BuildContext context) {
    final leadController = Provider.of<LeadsController>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.myLeads,
          overflow: TextOverflow.visible,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: cc.greyPrimary, fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      body: !_isSubscribed
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SubscriptionModule(
                            navFrom: "Dashboard",
                          ),
                        ));
                  },
                  child: SizedBox(
                      height: 150,
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: CachedNetworkImage(
                          imageUrl:
                              "https://sashaktnirmaan.com/assets/subscription.gif",
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          fit: BoxFit.cover,
                        ),
                      )),
                ),
              ),
            )
          : StreamBuilder<MyLeadsDataModel>(
              stream: leadController.leadsStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: CircularProgressIndicator()); // Loading state
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (!snapshot.hasData || snapshot.data!.data!.isEmpty) {
                  return Container(
                    alignment: Alignment.center,
                    height: screenHeight - 140,
                    child: Image.asset(
                      "assets/images/nodata.png",
                      fit: BoxFit.contain,
                    ),
                  );
                }
                MyLeadsDataModel leadsData =
                    snapshot.data!; // ✅ Extracting data from stream
                return Column(
                  children: [
                    // ✅ Using Stream Data
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: buildCustomCard(
                              icon: Icons.insert_chart,
                              title:
                                  "${leadsData.newLeads ?? '0'} ${AppLocalizations.of(context)!.newLeads}",
                              backgroundColor: Colors.green.shade400,
                              textColor: Colors.white,
                              iconColor: Colors.white,
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: buildCustomCard(
                              icon: Icons.insert_chart_outlined,
                              title:
                                  "${leadsData.openLeads ?? '0'} ${AppLocalizations.of(context)!.openLeads}",
                              backgroundColor: Colors.red.shade400,
                              textColor: Colors.white,
                              iconColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.only(top: 3),
                        itemCount:
                            leadsData.data!.length, // ✅ Using Stream Data
                        itemBuilder: (context, index) {
                          final lead = leadsData.data![index];
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: InkWell(
                              onTap: () {
                                leadController.updateLeadStatus(
                                    leadId: lead.id.toString());
                              },
                              child: LeadsDetailItemCard(
                                cc: cc,
                                isNew:
                                    lead.status == "Open leads" ? false : true,
                                name: lead.buyer?.name ??
                                    AppLocalizations.of(context)!.notAvailable,
                                enquiryName: lead.serviceName ??
                                    AppLocalizations.of(context)!.notAvailable,
                                imageUrl:
                                    'https://i.postimg.cc/FKrHpCYL/pngwing-com-2.png' ??
                                        "",
                                leftTime: lead.createdTime ??
                                    AppLocalizations.of(context)!.notAvailable,
                                address: lead.buyer?.area != null
                                    ? lead.buyer?.area?.serviceArea ??
                                        AppLocalizations.of(context)!
                                            .notAvailable
                                    : '',
                                onTapCall: () {
                                  ContactFeatures().launchCalling(context,
                                      lead.buyer?.phone.toString() ?? '');
                                  leadController.updateLeadStatus(
                                      leadId: lead.id.toString());
                                },
                                isFav: false,
                                datetime: lead.createdAt?.toFormattedDate(),
                                onTapWhatsapp: () {
                                  ContactFeatures().launchWhatsapp(
                                      context,
                                      lead.buyer?.phone.toString() ?? '',
                                      "Hello! 👋\n\n"
                                      "Thank you for your interest in our services. "
                                      "How can I assist you today? If you have any questions or need further information, feel free to ask!\n\n"
                                      "Looking forward to hearing from you soon!");
                                  leadController.updateLeadStatus(
                                      leadId: lead.id.toString());
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
    );
  }

  // Custom Card Builder
  Widget buildCustomCard({
    required IconData icon,
    required String title,
    required Color backgroundColor,
    Color textColor = Colors.black,
    Color iconColor = Colors.black,
    List<BoxShadow>? boxShadow,
  }) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: backgroundColor,
        boxShadow: boxShadow ??
            [
              BoxShadow(
                blurRadius: 3,
                color: Colors.grey.withOpacity(0.3),
                offset: Offset(0, 2),
              ),
            ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: iconColor, size: 20),
            SizedBox(width: 6),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
