import 'package:flutter/material.dart';
import 'package:qixer/view/utils/common_helper.dart';

class PhotosTabs extends StatelessWidget {
  final provider;
  const PhotosTabs({super.key, this.provider});

  @override
  Widget build(BuildContext context) {
    List<Widget> serviceWidgets = [];
    for (var i = 0; i < 15; i++) {
      serviceWidgets.add(
        InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {},
          child: CommonHelper().profileImage(
              "https://img.freepik.com/free-photo/client-doing-hair-cut-barber-shop-salon_1303-20710.jpg",
              100,
              100), // Using profileImage widget
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        spacing: 15.0, // Horizontal space between items
        runSpacing: 15.0, // Vertical space between rows
        children: [
          for (var widget in serviceWidgets)
            SizedBox(
              width: (MediaQuery.of(context).size.width - 30) /
                  3, // Setting width to fit 3 columns
              child: widget,
            ),
        ],
      ),
    );
  }
}
