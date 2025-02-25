import 'package:flutter/material.dart';

import '../../utils/common_helper.dart';

class CategorySelectCard extends StatelessWidget {
  final String? imageUrl;
  final String? title;
  final bool? isSelected;
  const CategorySelectCard({
    super.key,
    this.imageUrl,
    this.title,
    this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CommonHelper().profileImage(
            // "https://i.postimg.cc/9fPYn58n/civilworkimage.jpg",
            imageUrl.toString(),
            150,
            150),
        Container(
          alignment: Alignment.center,
          height: 150,
          width: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: Colors.black.withOpacity(0.6),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              textAlign: TextAlign.center,
              title.toString(),
              // "Plumbing / Water Supply",
              style: TextStyle(
                  fontSize: 13,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
        Positioned(
            bottom: 5,
            right: 5,
            child: Icon(
              isSelected! ? Icons.check_circle : Icons.circle_outlined,
              size: 20,
              color: isSelected! ? Colors.green : Colors.white,
            ))
      ],
    );
  }
}
