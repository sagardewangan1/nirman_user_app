import 'package:flutter/material.dart';
import 'package:qixer/helper/extension/string_extension.dart';

extension SizedBoxExtension on int {
  Widget get toHeight {
    return SizedBox(
      height: toDouble(),
    );
  }

  Widget get toWidth {
    return SizedBox(
      width: toDouble(),
    );
  }
}

extension CurrencyExtension on num {
  String get cur {
    return toStringAsFixed(2).cur;
  }
}

extension FutureDelayFunction on int {
  Future<void> secondDelay() async {
    await Future.delayed(Duration(seconds: this));
  }
}
