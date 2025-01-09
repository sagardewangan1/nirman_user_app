import 'package:flutter/material.dart';

class CustomFutureWidget extends StatelessWidget {
  final child;
  final shimmer;
  final isLoading;
  final function;
  const CustomFutureWidget(
      {
      required this.child,
      this.function,
      this.shimmer,
      this.isLoading});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: function,
      builder: (context, snapshot) {
        if ((snapshot.connectionState == ConnectionState.waiting &&
                shimmer != null) ||
            isLoading == true) {
          return shimmer;
        }

        return child;
      },
    );
  }
}
