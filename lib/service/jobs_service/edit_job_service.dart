import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/all_services_service.dart';
import 'package:qixer/service/dropdowns_services/country_dropdown_service.dart';
import 'package:qixer/service/jobs_service/my_jobs_service.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../dropdowns_services/area_dropdown_service.dart';
import '../dropdowns_services/state_dropdown_services.dart';

class EditJobService with ChangeNotifier {
  bool isLoading = false;

  setLoadingStatus(bool status) {
    isLoading = status;
    notifyListeners();
  }

  var pickedImage;

  final ImagePicker _picker = ImagePicker();

  Future pickAddressImage(BuildContext context) async {
    pickedImage = await _picker.pickImage(source: ImageSource.gallery);

    notifyListeners();
  }

  setImageNull() {
    pickedImage = null;
    notifyListeners();
  }

  Future<bool> editJob(BuildContext context,
      {required title,
      required desc,
      required onlineOrOffline,
      required price,
      required deadline,
      required jobId,
      required imagelink}) async {
    var selectedCategoryId =
        Provider.of<AllServicesService>(context, listen: false)
            .selectedCategoryId;

    var selectedSubCategoryId =
        Provider.of<AllServicesService>(context, listen: false)
            .selectedSubcatId;

    var selectedCountryId =
        Provider.of<CountryDropdownService>(context, listen: false)
            .selectedCountryId;
    var selectedStateId =
        Provider.of<StateDropdownService>(context, listen: false)
            .selectedStateId;
    var selectedAreaId =
        Provider.of<AreaDropdownService>(context, listen: false).selectedAreaId;

    if (pickedImage == null && imagelink == null) {
      OthersHelper()
          .showSnackBar(context, 'You must select an image', Colors.red);
      return false;
    }

    if (selectedCategoryId == 0 || selectedSubCategoryId == 0) {
      OthersHelper().showSnackBar(
          context, 'You must select category & subcategory', Colors.red);
      return false;
    }

    var isOnline = onlineOrOffline == 0 ? 0 : 1;

    setLoadingStatus(true);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('shashaktnirmantoken');

    FormData formData;
    var dio = Dio();
    dio.options.headers['Content-Type'] = 'multipart/form-data';
    dio.options.headers['Accept'] = 'application/json';
    dio.options.headers['Authorization'] = "Bearer $token";

    if (pickedImage == null) {
      formData = FormData.fromMap({
        'category': selectedCategoryId,
        'subcategory': selectedSubCategoryId,
        'country_id': selectedCountryId,
        'city_id': selectedStateId,
        'title': title,
        'description': desc,
        'is_job_online': isOnline,
        'price': price,
        'dead_line': deadline,
      });
    } else {
      formData = FormData.fromMap({
        'category': selectedCategoryId,
        'subcategory': selectedSubCategoryId,
        'country_id': selectedCountryId,
        'city_id': selectedStateId,
        'title': title,
        'description': desc,
        'is_job_online': isOnline,
        'price': price,
        'dead_line': deadline,
        'image': await MultipartFile.fromFile(pickedImage.path,
            filename: 'campaing${pickedImage.path}.jpg'),
      });
    }

    var response = await dio.post(
      '$baseApi/user/job/edit-job/$jobId',
      data: formData,
      options: Options(
        validateStatus: (status) {
          return true;
        },
      ),
    );

    setLoadingStatus(false);
    setImageNull();
    final data = response.data;

    if (response.statusCode == 201 && data.containsKey('msg')) {
      OthersHelper().showToast('Job updated successfully', Colors.black);

      Provider.of<MyJobsService>(context, listen: false).setDefault();

      Provider.of<MyJobsService>(context, listen: false).fetchMyJobs(context);

      Navigator.pop(context);

      return true;
    } else {
      OthersHelper().showToast('Something went wrong', Colors.black);
      return false;
    }
  }

  //================>

  fillInitialCategorySubcategory(BuildContext context, jobIndex) async {
    Future.delayed(const Duration(seconds: 1), () async {
      //set category id
      var categoryId = Provider.of<MyJobsService>(context, listen: false)
          .myJobsListMap[jobIndex]['categoryId'];

      Provider.of<AllServicesService>(context, listen: false)
          .setSelectedCategoryId(categoryId);

      //set category name
      var categoryList = Provider.of<AllServicesService>(context, listen: false)
          .categoryDropdownList;
      var categoryIndexList =
          Provider.of<AllServicesService>(context, listen: false)
              .categoryDropdownIndexList;

      var categoryName = categoryList[categoryIndexList.indexOf(categoryId)];

      Provider.of<AllServicesService>(context, listen: false)
          .setCategoryValue(categoryName);

      //set subcategory id
      var subCategoryId = Provider.of<MyJobsService>(context, listen: false)
          .myJobsListMap[jobIndex]['subcategoryId'];

      await Provider.of<AllServicesService>(context, listen: false)
          .fetchSubcategory(categoryId);

      Provider.of<AllServicesService>(context, listen: false)
          .setSelectedSubcatsId(subCategoryId);
      var subcategoryList =
          Provider.of<AllServicesService>(context, listen: false)
              .subcatDropdownList;
      var subcategoryIndexList =
          Provider.of<AllServicesService>(context, listen: false)
              .subcatDropdownIndexList;

      var subcategoryName =
          subcategoryList[subcategoryIndexList.indexOf(subCategoryId)];

      Provider.of<AllServicesService>(context, listen: false)
          .setSubcatValue(subcategoryName);
    });
  }
}
