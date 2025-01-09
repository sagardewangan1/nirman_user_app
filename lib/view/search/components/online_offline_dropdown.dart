import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/searchbar_with_dropdown_service.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/responsive.dart';

class OnlineOfflineDropdown extends StatelessWidget {
  const OnlineOfflineDropdown({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cc = ConstantColors();

    return Consumer<SearchBarWithDropdownService>(
      builder: (context, provider, child) => Column(
        children: [
          // dropdown ===========
          // provider.userStateId == null
          //     ?
          provider.onlineOfflineDropdownList.isNotEmpty
              ? Consumer<SearchBarWithDropdownService>(
                  builder: (context, sProvider, child) {
                  return Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      border: Border.all(color: cc.greyFive),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        // menuMaxHeight: 200,
                        isExpanded: true,
                        value: provider.selectedonlineOffline,
                        icon: Icon(Icons.keyboard_arrow_down_rounded,
                            color: cc.greyFour),
                        iconSize: 26,
                        elevation: 17,
                        style: TextStyle(color: cc.greyFour),
                        onChanged: (newValue) {
                          provider.setOnlineOfflineValue(newValue);

                          //setting the id of selected value
                          provider.setSelectedOnlineOfflineId(
                              provider.onlineOfflineDropdownIndexList[provider
                                  .onlineOfflineDropdownList
                                  .indexOf(newValue!)]);
                          sProvider.fetchService(context);
                        },
                        items: provider.onlineOfflineDropdownList
                            .map<DropdownMenuItem<String>>((value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(
                              lnProvider.getString(value),
                              style: TextStyle(
                                  color: cc.greyPrimary.withOpacity(.8)),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  );
                })
              : Container()
        ],
      ),
    );
  }
}
