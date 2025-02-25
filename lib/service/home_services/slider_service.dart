import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:qixer/model/slider_model.dart';
import 'package:qixer/view/utils/others_helper.dart';

class SliderService with ChangeNotifier {
  List<Map> sliderDetailsList = [];
  List<Map> sliderDetailsList2 = [];
  List sliderImageList = [];
  List sliderImageList2 = [];

  loadSlider() async {
    if (sliderDetailsList.isEmpty) {
      var response = await http.get(Uri.parse('$baseApi/slider'));
      if (response.statusCode == 201) {
        var data = SliderModel.fromJson(jsonDecode(response.body));
        sliderDetailsList.clear();
        sliderImageList.clear();
        sliderDetailsList2.clear();
        sliderImageList2.clear();
        var mainSliders =
            data.sliderDetails.where((s) => s.sliderType == "main").toList();
        for (var i = 0; i < mainSliders.length; i++) {
          sliderDetailsList.add({
            'title': mainSliders[i].title,
            'subtitle': mainSliders[i].subTitle,
            'slider_type': mainSliders[i].sliderType
          });
          if (i < data.imageUrl.length) {
            sliderImageList.add(data.imageUrl[i].imgUrl);
          }
        }
        var topSliders =
            data.sliderDetails.where((s) => s.sliderType == "top").toList();
        for (var i = 0; i < topSliders.length; i++) {
          sliderDetailsList2.add({
            'title': topSliders[i].title,
            'subtitle': topSliders[i].subTitle,
            'slider_type': topSliders[i].sliderType
          });
          if (i < data.imageUrl.length) {
            sliderImageList2.add(data.imageUrl[i].imgUrl);
          }
        }
        notifyListeners();
      }
    } else {
      print("⚠️ Sliders already loaded. Skipping API call.");
    }
  }
}
