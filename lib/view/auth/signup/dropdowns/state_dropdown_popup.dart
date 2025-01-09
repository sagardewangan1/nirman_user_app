import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:qixer/service/dropdowns_services/area_dropdown_service.dart';
import 'package:qixer/service/dropdowns_services/state_dropdown_services.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/constant_styles.dart';
import 'package:qixer/view/utils/custom_input.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:qixer/view/utils/responsive.dart';

import '../../../../service/searchbar_with_dropdown_service.dart';

class StateDropdownPopup extends StatelessWidget {
  const StateDropdownPopup({super.key});

  @override
  Widget build(BuildContext context) {
    final RefreshController refreshController =
        RefreshController(initialRefresh: true);

    final cc = ConstantColors();
    return Scaffold(
      body: SmartRefresher(
        controller: refreshController,
        enablePullUp: true,
        enablePullDown: context.watch<StateDropdownService>().currentPage > 1
            ? false
            : true,
        onRefresh: () async {
          final result =
              await Provider.of<StateDropdownService>(context, listen: false)
                  .fetchStates(context);
          if (result) {
            refreshController.refreshCompleted();
          } else {
            refreshController.refreshFailed();
          }
        },
        onLoading: () async {
          final result =
              await Provider.of<StateDropdownService>(context, listen: false)
                  .fetchStates(context);
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
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Consumer<StateDropdownService>(
              builder: (context, p, child) => Column(
                children: [
                  sizedBoxCustom(30),
                  CustomInput(
                    hintText: lnProvider.getString('Search state'),
                    paddingHorizontal: 17,
                    icon: 'assets/icons/search.png',
                    onChanged: (v) {
                      p.searchState(context, v, isSearching: true);
                    },
                  ),
                  sizedBoxCustom(10),
                  p.statesDropdownList.isNotEmpty
                      ? p.statesDropdownList[0] != 'Select City'
                          ? ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: p.statesDropdownList.length,
                              itemBuilder: (context, i) {
                                return InkWell(
                                  onTap: () {
                                    p.setStatesValue(p.statesDropdownList[i]);

                                    //                         // setting the id of selected value
                                    p.setSelectedStatesId(
                                        p.statesDropdownIndexList[p
                                            .statesDropdownList
                                            .indexOf(p.statesDropdownList[i])]);

                                    Navigator.pop(context);
                                    Provider.of<AreaDropdownService>(context,
                                            listen: false)
                                        .setAreaDefault();
                                    final sProvider = Provider.of<
                                            SearchBarWithDropdownService>(
                                        context,
                                        listen: false);
                                    sProvider.setCityValue(p.selectedState);
                                    sProvider
                                        .setSelectedCityId(p.selectedStateId);
                                    sProvider.fetchService(context);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 18),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: cc.greyFive))),
                                    child: CommonHelper().paragraphCommon(
                                        lnProvider.getString(
                                            '${p.statesDropdownList[i]}'),
                                        textAlign: TextAlign.left),
                                  ),
                                );
                              })
                          : CommonHelper().paragraphCommon(
                              lnProvider.getString('No city found'),
                              textAlign: TextAlign.center)
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            OthersHelper().showLoading(cc.primaryColor)
                          ],
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
