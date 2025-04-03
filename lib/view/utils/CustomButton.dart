import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:qixer/view/utils/constant_colors.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Widget leading;
  final VoidCallback? onTap;
  final ConstantColors cc;

  const CustomButton({
    super.key,
    required this.title,
    this.onTap,
    required this.leading,
    required this.cc,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: cc.primaryColor,
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 8.0, 0, 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              leading,
              const Gap(10.0),
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .labelSmall!
                    .copyWith(fontWeight: FontWeight.w600, color: cc.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
