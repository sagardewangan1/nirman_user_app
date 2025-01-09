import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:qixer/service/dropdowns_services/area_dropdown_service.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/constant_styles.dart';
import 'package:qixer/view/utils/custom_input.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:qixer/view/utils/responsive.dart';

class AreaDropdownPopup extends StatelessWidget {
  const AreaDropdownPopup({super.key});

  @override
  Widget build(BuildContext context) {
    final RefreshController refreshController =
        RefreshController(initialRefresh: true);

    final cc = ConstantColors();
    return Scaffold(
      body: SmartRefresher(
        controller: refreshController,
        enablePullUp: true,
        enablePullDown:
            context.watch<AreaDropdownService>().currentPage > 1 ? false : true,
        onRefresh: () async {
          final result =
              await Provider.of<AreaDropdownService>(context, listen: false)
                  .fetchArea(context);
          if (result) {
            refreshController.refreshCompleted();
          } else {
            refreshController.refreshFailed();
          }
        },
        onLoading: () async {
          final result =
              await Provider.of<AreaDropdownService>(context, listen: false)
                  .fetchArea(context);
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
            child: Consumer<AreaDropdownService>(
              builder: (context, p, child) => Column(
                children: [
                  sizedBoxCustom(30),
                  CustomInput(
                    hintText: lnProvider.getString('Search area'),
                    paddingHorizontal: 17,
                    icon: 'assets/icons/search.png',
                    onChanged: (v) {
                      p.searchArea(context, v, isSearching: true);
                    },
                  ),
                  sizedBoxCustom(10),
                  p.areaDropdownList.isNotEmpty
                      ? p.areaDropdownList[0] != 'Select Area'
                          ? ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: p.areaDropdownList.length,
                              itemBuilder: (context, i) {
                                return InkWell(
                                  onTap: () {
                                    p.setAreaValue(p.areaDropdownList[i]);

                                    //                         // setting the id of selected value
                                    p.setSelectedAreaId(p.areaDropdownIndexList[
                                        p.areaDropdownList
                                            .indexOf(p.areaDropdownList[i])]);

                                    Navigator.pop(context);
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
                                            '${p.areaDropdownList[i]}'),
                                        textAlign: TextAlign.left),
                                  ),
                                );
                              })
                          : CommonHelper().paragraphCommon(
                              lnProvider.getString('No area found'),
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
