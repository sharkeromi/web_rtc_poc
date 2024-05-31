import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_rtc_poc_2/controllers/pslashController.dart';

class SplashScreen extends StatelessWidget {
   SplashScreen({super.key});
  final SplashScreenController splashScreenController = Get.find<SplashScreenController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(248, 243, 207, 1.0),
      body: Center(
        child: Image.asset(
          'assets/images/cat.jpg',
          filterQuality: FilterQuality.high,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      ),
    );
  }
}