import 'package:flutter/material.dart';

import '/helper/extension/context_extension.dart';
import 'constant_colors.dart';

class FieldLabel extends StatelessWidget {
  final String label;
  const FieldLabel({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        label,
        style: context.titleMedium!
            .copyWith(color: cc.black5, fontWeight: FontWeight.w600),
      ),
    );
  }
}
