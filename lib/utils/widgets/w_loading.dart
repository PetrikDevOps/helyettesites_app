import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WLoading extends StatelessWidget {
  const WLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset('assets/loading.json'),
    );
  }
}
