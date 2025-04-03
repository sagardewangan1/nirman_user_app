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

  SliderModel _sliderModel = SliderModel();
  SliderModel get sliderModel => _sliderModel;

  loadSlider() async {
    if (sliderDetailsList.isEmpty) {
      var response = await http.get(Uri.parse('$baseApi/slider'));
      // printLargeResponse(response.body);
      if (response.statusCode == 201) {
        _sliderModel = SliderModel.fromJson(jsonDecode(response.body));
        sliderDetailsList.clear();
        sliderImageList.clear();
        sliderDetailsList2.clear();
        sliderImageList2.clear();
        List<SliderDetail> mainSliders = _sliderModel.sliderDetails
                ?.where((s) => s.sliderType == "main")
                .toList() ??
            [];

        for (var i = 0; i < mainSliders.length; i++) {
          sliderDetailsList.add({
            'title': mainSliders[i].title,
            'subtitle': mainSliders[i].subTitle,
            'slider_type': mainSliders[i].sliderType
          });
          // Ensure backgroundImage is not null before parsing
          int? backgroundImageId = mainSliders[i].backgroundImage != null
              ? int.tryParse(mainSliders[i].backgroundImage.toString())
              : null;

          if (backgroundImageId != null) {
            List<ImageUrl> mainImages = _sliderModel.imageUrl
                    ?.where((s) => s.imageId == backgroundImageId)
                    .toList() ??
                [];

            if (mainImages.isNotEmpty) {
              sliderImageList.add(mainImages.first.imgUrl);
              print("✅ Main Slider Image: ${mainImages.map(
                (e) => e.imageId,
              )}"); // Print Image
            } else {
              print("⚠️ No image found for Main Slider ID: $backgroundImageId");
            }
          }
        }

        // Process top sliders
        List<SliderDetail> topSliders = _sliderModel.sliderDetails
                ?.where((s) => s.sliderType == "top")
                .toList() ??
            [];
        for (var i = 0; i < topSliders.length; i++) {
          sliderDetailsList2.add({
            'title': topSliders[i].title,
            'subtitle': topSliders[i].subTitle,
            'slider_type': topSliders[i].sliderType
          });

          int? backgroundImageId = topSliders[i].backgroundImage != null
              ? int.tryParse(topSliders[i].backgroundImage.toString())
              : null;

          if (backgroundImageId != null) {
            List<ImageUrl> topImages = _sliderModel.imageUrl
                    ?.where((s) => s.imageId == backgroundImageId)
                    .toList() ??
                [];

            if (topImages.isNotEmpty) {
              sliderImageList2.add(topImages.first.imgUrl);
              print(
                  "✅ Top Slider Image: ${topImages.first.imgUrl}"); // Print Image
            } else {
              print("⚠️ No image found for Top Slider ID: $backgroundImageId");
            }
          }
        }

        notifyListeners();
      }
    } else {
      print("⚠️ Sliders already loaded. Skipping API call.");
    }
  }
}
