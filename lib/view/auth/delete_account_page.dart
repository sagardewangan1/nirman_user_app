import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../service/app_string_service.dart';
import '../../service/auth_services/delete_account_service.dart';
import '../booking/components/textarea_field.dart';
import '../utils/common_helper.dart';
import '../utils/constant_colors.dart';
import '../utils/constant_styles.dart';
import '../utils/others_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DeleteAccountPage extends StatelessWidget {
  DeleteAccountPage({super.key});

  TextEditingController descController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;

    ConstantColors cc = ConstantColors();
    return Scaffold(
      appBar: CommonHelper().appbarCommon(
          AppLocalizations.of(context)!.deleteAccount, context, () {
        Navigator.pop(context);
      }),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: screenPadding,
            ),
            height: screenHeight - 100,
            child: Consumer<AppStringService>(
              builder: (context, ln, child) => Consumer<DeleteAccountService>(
                builder: (context, provider, child) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // dropdown ======>
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonHelper().labelCommon(
                            AppLocalizations.of(context)!.chooseReason),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                            border: Border.all(color: cc.greyFive),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              // menuMaxHeight: 200,
                              // isExpanded: true,
                              value: provider.selecteddeactivateReason,
                              icon: Icon(Icons.keyboard_arrow_down_rounded,
                                  color: cc.greyFour),
                              iconSize: 26,
                              elevation: 17,
                              style: TextStyle(color: cc.greyFour),
                              onChanged: (newValue) {
                                if (newValue != null) {
                                  provider.setdeactivateReasonValue(newValue);

                                  // Get the index of the selected value in the dropdown list
                                  int index = provider
                                      .deactivateReasonDropdownList
                                      .indexOf(newValue);

                                  // Set the corresponding ID from the ID list
                                  if (index >= 0 &&
                                      index <
                                          provider
                                              .deactivateReasonDropdownIndexList
                                              .length) {
                                    provider.setSelecteddeactivateReasonId(
                                        provider.deactivateReasonDropdownIndexList[
                                            index]);
                                  }
                                }
                              },
                              items: provider.deactivateReasonDropdownList
                                  .map<DropdownMenuItem<String>>((value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: Text(
                                    ln.getString(value),
                                    style: TextStyle(
                                        color: cc.greyPrimary.withOpacity(.8)),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        )
                      ],
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                    CommonHelper().labelCommon(
                        AppLocalizations.of(context)!.shortDescription),
                    TextareaField(
                      hintText: AppLocalizations.of(context)!.description,
                      notesController: descController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // CommonHelper().labelCommon(ln.getString("Enter password")),
                    //
                    // CustomInput(
                    //   hintText: ln.getString('Enter password'),
                    //   controller: passwordController,
                    // ),
                    //
                    // const SizedBox(
                    //   height: 30,
                    // ),
                    Consumer<DeleteAccountService>(
                      builder: (context, provider, child) => CommonHelper()
                          .buttonOrange(AppLocalizations.of(context)!.delete,
                              () {
                        if (provider.isloading == false) {
                          if (descController.text.isEmpty) {
                            OthersHelper().showToast(
                                AppLocalizations.of(context)!
                                    .pleaseEnterADescription,
                                Colors.black);
                            return;
                          }
                          provider.deleteAccount(
                              context, descController.text.toString());
                        }
                      },
                              isloading:
                                  provider.isloading == false ? false : true,
                              bgColor: cc.warningColor),
                    ),
                    const SizedBox(
                      height: 30,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
