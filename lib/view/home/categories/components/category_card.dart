import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:qixer/view/utils/others_helper.dart';


class CategoryCard extends StatelessWidget {
  const CategoryCard(
      {super.key,
      required this.name,
      required this.id,
      required this.cc,
      required this.index,
      required this.imagelink,
      this.onTap});

  final name;
  final id;
  final cc;
  final index;
  final imagelink;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: cc.white,
            borderRadius: BorderRadius.circular(9),
            border: Border.all(width: 1, color: cc.black8)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: SizedBox(
                  height: 50,
                  // width: double.infinity,
                  child: CachedNetworkImage(
                    imageUrl: imagelink ?? placeHolderUrl,
                    errorWidget: (context, url, error) => Icon(
                      Icons.image_not_supported,
                      color: Colors.grey.shade600,
                    ),
                    fit: BoxFit.fitHeight,
                  )),
            ),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              width: 100,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3.0),
                child: AutoSizeText(
                  name,
                  softWrap: true,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  wrapWords: true,
                  style: TextStyle(
                    color: cc.greyFour,
                    fontSize: 13,
                    height: 1.4,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
