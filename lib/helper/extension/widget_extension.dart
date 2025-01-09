import 'package:flutter/material.dart';

import '../../view/utils/constant_colors.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:le_monde/helper/extension/context_extension.dart';

extension WidgetExtension on Widget {
  Widget get toSliver {
    return SliverToBoxAdapter(child: this);
  }
}

extension CreateShimmerExtension on Widget {
  Widget get shim {
    return this;
    //  animate(
    //   delay: 0.ms,
    //   autoPlay: true,
    //   onPlay: (controller) => controller.repeat(),
    // ).shimmer(
    //   duration: const Duration(seconds: 1),
    //   color: Colors.white,
    // );
  }
}

extension PaddingExtension on Widget {
  Widget get hp20 {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: this,
    );
  }
}

extension DividerExtension on Widget {
  Widget divider(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        this,
        Divider(
          color: cc.black8,
          thickness: 2,
          height: 24,
        ),
      ],
    );
  }
}
