import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/rtl_service.dart';
import 'package:qixer/view/utils/others_helper.dart';

class ImageBig extends StatelessWidget {
  const ImageBig(
      {super.key,
      required this.serviceName,
      required this.imageLink,
      this.fit = BoxFit.cover});
  final serviceName;
  final imageLink;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
            height: 295,
            width: double.infinity,
            child: CachedNetworkImage(
              fit: fit,
              imageUrl: imageLink,
              placeholder: (context, url) => Image.network(placeHolderUrl),
              errorWidget: (context, url, error) =>
                  Image.network(placeHolderUrl),
            )),
        Container(
          height: 295,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(.7),
                  Colors.black.withOpacity(.1)
                ]),
          ),
        ),
        Consumer<RtlService>(
          builder: (context, rtlP, child) => Positioned(
              left: 10,
              top: 30,
              right: rtlP.direction == 'ltr' ? 30 : 10,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios_rounded),
                    color: Colors.white,
                    iconSize: 19,
                  ),
                  Spacer(),
                ],
              )),
        )
      ],
    );
  }
}
