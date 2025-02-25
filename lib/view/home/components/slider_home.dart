import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../utils/constant_colors.dart';

class SliderHome extends StatelessWidget {
  const SliderHome({
    super.key,
    required this.cc,
    this.sliderDetailsList,
    this.sliderImageList,
  });

  final ConstantColors cc;
  final sliderDetailsList;
  final sliderImageList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 175,
      width: double.infinity,
      child: CarouselSlider.builder(
        itemCount: sliderDetailsList.length,
        options: CarouselOptions(
          autoPlay: true,
          enlargeCenterPage: false,
          viewportFraction: 0.9,
          aspectRatio: 2.0,
          initialPage: 1,
        ),
        itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
            Container(
          margin: const EdgeInsets.symmetric(horizontal: 6),
          width: double.infinity,
          height: double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: sliderImageList[itemIndex],
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

class SliderHome2 extends StatelessWidget {
  const SliderHome2({
    super.key,
    required this.cc,
    this.sliderDetailsList,
    this.sliderImageList,
  });

  final ConstantColors cc;
  final sliderDetailsList;
  final sliderImageList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 85,
      width: double.infinity,
      child: CarouselSlider.builder(
        itemCount: sliderDetailsList.length,
        options: CarouselOptions(
          autoPlay: true,
          enlargeCenterPage: false,
          viewportFraction: 0.9,
          aspectRatio: 2.0,
          initialPage: 1,
        ),
        itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
            Container(
          margin: const EdgeInsets.symmetric(horizontal: 6),
          width: double.infinity,
          height: double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: sliderImageList[itemIndex],
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
