import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qixer/view/home/homepage_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';

class ViewTypeIcon extends StatelessWidget {
  const ViewTypeIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();
    return ValueListenableBuilder(
      valueListenable: HomepageHelper.viewMap,
      builder: (context, bool value, child) => InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          HomepageHelper().changeMapView(!value);
          debugPrint("Map view Changed, value is -$value".toString());
        },
        child: Container(
          height: 64,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: cc.successColor,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 3,
                blurRadius: 12,
                offset: const Offset(0, 5), // changes position of shadow
              ),
            ],
          ),
          child: SvgPicture.asset(
            value ? "assets/svg/list.svg" : 'assets/svg/map.svg',
            height: 26,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
