import 'package:flutter/material.dart';
import 'package:qixer/view/services/components/desc_from_html.dart';


class MemberShipTabs extends StatelessWidget {
  final desc;
  final cc;
  const MemberShipTabs({super.key, required this.desc, this.cc});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DescInHtml(
        cc: cc,
        desc: desc,
      ),
    );
  }
}
