import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WError extends StatelessWidget {
  final String error;
  const WError({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(error),
          Lottie.asset('assets/error.json'),
        ],
      )
    );
  }
}
