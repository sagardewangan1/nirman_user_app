import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:qixer/data/network/network_api_services.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/others_helper.dart';

class TacPP extends StatelessWidget {
  final route;
  const TacPP({super.key, this.route});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cc.white,
      appBar: AppBar(),
      body: FutureBuilder(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return OthersHelper().showLoading(cc.primaryColor);
          }
          if (snapshot.data.toString() == "null" || snapshot.hasError) {
            return CommonHelper().nothingfound(context, "Nothing found");
          }
          return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: HtmlWidget(snapshot.data.toString()));
        },
      ),
    );
  }

  fetchData() async {
    final url = "$baseApi$route";

    final responseData = await NetworkApiServices().getApi(url, "");
    if (responseData != null) {
      debugPrint(responseData.toString());
      return responseData.values.toList().first?["page_content"];
    }
  }
}
