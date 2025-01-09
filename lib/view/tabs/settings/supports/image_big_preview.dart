import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:qixer/view/utils/responsive.dart';

class ImageBigPreviewPage extends StatelessWidget {
  const ImageBigPreviewPage(
      {super.key, this.networkImgLink, this.assetImgLink});

  final networkImgLink;
  final assetImgLink;
  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> bigPagekey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: bigPagekey,
      // appBar: AppBar(),
      body: Stack(
        children: [
          networkImgLink != null
              ?
              //show network image
              Container(
                  alignment: Alignment.center,
                  child: CachedNetworkImage(
                    imageUrl: networkImgLink,
                    placeholder: (context, url) {
                      return Image.asset('assets/images/loading_image.png');
                    },
                    height: screenHeight - 150,
                    width: screenWidth,
                    // fit: BoxFit.fitHeight,
                  ),
                )
              : // else show asset image,
              Container(
                  alignment: Alignment.center,
                  child: Image.file(
                    File(assetImgLink),
                    height: screenHeight - 150,
                    width: screenWidth,
                    // fit: BoxFit.cover,
                  )),
        ],
      ),
    );
  }
}
