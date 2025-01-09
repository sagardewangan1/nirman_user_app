import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/app_string_service.dart';
import 'package:qixer/service/jobs_service/create_job_service.dart';
import 'package:qixer/view/booking/components/textarea_field.dart';
import 'package:qixer/view/jobs/components/create_job_image_upload.dart';
import 'package:qixer/view/jobs/components/job_create_dropdowns.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/constant_styles.dart';
import 'package:qixer/view/utils/custom_input.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:qixer/view/utils/responsive.dart';

class CreateJobPage extends StatefulWidget {
  const CreateJobPage({super.key});

  @override
  _CreateJobPageState createState() => _CreateJobPageState();
}

class _CreateJobPageState extends State<CreateJobPage> {
  @override
  void initState() {
    super.initState();
  }

  ConstantColors cc = ConstantColors();

  int selectedIndex = 0;

  final titleController = TextEditingController();
  final budgetController = TextEditingController();
  final descController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101),
        locale: Locale(rtlProvider.langSlug.substring(0, 2)));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var onlyDate = selectedDate.toString().split(' ');

    return Scaffold(
      appBar: CommonHelper().appbarCommon('Create Job', context, () {
        Navigator.pop(context);
      }),
      backgroundColor: cc.bgColor,
      body: SingleChildScrollView(
        physics: physicsCommon,
        child: Consumer<CreateJobService>(
          builder: (context, provider, child) => Consumer<AppStringService>(
            builder: (context, asProvider, child) => Container(
              padding:
                  EdgeInsets.symmetric(horizontal: screenPadding, vertical: 10),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        for (int i = 0; i < onlineOffline.length; i++)
                          InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              setState(() {
                                selectedIndex = i;
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 10),
                              margin: const EdgeInsets.only(right: 20),
                              decoration: BoxDecoration(
                                  color: selectedIndex == i
                                      ? cc.primaryColor
                                      : Colors.white,
                                  border: Border.all(
                                      color: selectedIndex == i
                                          ? Colors.transparent
                                          : cc.borderColor),
                                  borderRadius: BorderRadius.circular(6)),
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 13,
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      lnProvider.getString(onlineOffline[i]),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: selectedIndex == i
                                            ? Colors.white
                                            : cc.greyParagraph,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),

                    // ============>
                    sizedBoxCustom(25),
                    const JobCreateDropdowns(),

                    sizedBoxCustom(20),

                    // Title
                    //============>
                    CommonHelper().labelCommon(asProvider.getString("Title")),

                    CustomInput(
                      controller: titleController,
                      validation: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a title';
                        }
                        return null;
                      },
                      hintText: asProvider.getString("Title"),
                      paddingHorizontal: 15,
                      textInputAction: TextInputAction.next,
                      maxLength: 190,
                    ),
                    sizedBoxCustom(20),

                    // Title
                    //============>
                    CommonHelper().labelCommon(asProvider.getString("Budget")),

                    CustomInput(
                      controller: budgetController,
                      isNumberField: true,
                      validation: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your budget';
                        }
                        return null;
                      },
                      hintText: asProvider.getString("Budget"),
                      textInputAction: TextInputAction.next,
                      paddingHorizontal: 15,
                    ),
                    sizedBoxCustom(20),

                    CommonHelper()
                        .labelCommon(asProvider.getString('Description')),
                    TextareaField(
                      hintText: asProvider.getString('Description'),
                      notesController: descController,
                    ),

                    //UPload image
                    sizedBoxCustom(10),
                    const CreateJobUploadImage(),

                    sizedBoxCustom(20),

                    // pick date
                    //===========>
                    CommonHelper().labelCommon("End date"),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: Stack(
                        children: [
                          TextField(
                            showCursor: false,
                            readOnly: true,
                            onTap: () {
                              _selectDate(context);
                            },
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ConstantColors().greyFive),
                                    borderRadius: BorderRadius.circular(9)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ConstantColors().primaryColor)),
                                errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ConstantColors().warningColor)),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ConstantColors().primaryColor)),
                                hintText: onlyDate[0],
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 16)),
                          ),
                          Positioned(
                              right: 0,
                              top: 2,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 12),
                                child: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: cc.greyPrimary,
                                ),
                              ))
                        ],
                      ),
                    ),

                    sizedBoxCustom(25),

                    CommonHelper().buttonOrange('Create job', () {
                      if (provider.isLoading == true) return;

                      if (double.tryParse(budgetController.text.trim()) ==
                          null) {
                        //if not integer value
                        OthersHelper().showSnackBar(context,
                            'You must enter a valid budget', Colors.red);
                        return;
                      }

                      if (_formKey.currentState!.validate()) {
                        provider.createJob(context,
                            title: titleController.text,
                            desc: descController.text,
                            onlineOrOffline: selectedIndex,
                            price: budgetController.text,
                            deadline: onlyDate[0]);
                      }
                    }, bgColor: cc.successColor, isloading: provider.isLoading),

                    sizedBoxCustom(30),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List onlineOffline = ['Offline', 'Online'];
}
