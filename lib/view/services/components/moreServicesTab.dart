import 'package:flutter/material.dart';

import '../service_details_page.dart';

class MoreServicesTab extends StatelessWidget {
  const MoreServicesTab({super.key, required this.provider});
  final provider;

  @override
  Widget build(BuildContext context) {
    List<Widget> serviceWidgets = [];
    for (var i = 0; i < 15; i++) {
      serviceWidgets.add(
        InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => const ServiceDetailsPage(),
              ),
            );
          },
          child: ListTile(
            title: Text("Shashakt Nirman ${i + 1}, Work On Process "),
          ),
        ),
      );
    }
    return Column(
      children: serviceWidgets,
    );
  }
}
