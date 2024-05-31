import 'package:get/get.dart';
import 'package:web_rtc_poc_2/controllers/homeController.dart';
import 'package:web_rtc_poc_2/controllers/pslashController.dart';

class BinderController implements Bindings {
  @override
  void dependencies() {
    Get.put<SplashScreenController>(SplashScreenController());
    Get.put<HomeController>(HomeController());
  }
}
