import 'dart:async';

import 'package:get/get.dart';
import 'package:web_rtc_poc_2/routes.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    startSplashScreen();
    super.onInit();
  }

  late Timer timer;

  Timer startSplashScreen() {
    var duration = const Duration(seconds: 3);
    timer = Timer(
      duration,
      () async {
        Get.offAllNamed(krHome);
      },
    );
    return timer;
  }
}
