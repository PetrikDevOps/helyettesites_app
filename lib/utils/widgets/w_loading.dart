import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WLoading extends StatelessWidget {
  const WLoading({super.key});

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.all(width * 0.2),
      child: Center(
        child: Lottie.asset('assets/loading.json'),
      ),
    );
  }
}
