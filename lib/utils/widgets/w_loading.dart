import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WLoading extends StatelessWidget {
  const WLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.network("https://lottie.host/d61eb996-fd02-423a-9be9-9ae70547b85f/LsPU4bMLrK.json")
    );
  }
}
