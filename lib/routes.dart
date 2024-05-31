
import 'package:get/get.dart';
import 'package:web_rtc_poc_2/screens/chatScreen.dart';
import 'package:web_rtc_poc_2/screens/home.dart';
import 'package:web_rtc_poc_2/screens/splash.dart';

const String krSplash = '/';
const String krHome = '/home';
const String krChat = "/chat";

List<GetPage<dynamic>>? routes = [
  GetPage(name: krSplash, page: () => SplashScreen(), transition: Transition.noTransition),
  GetPage(name: krHome, page: () => Home(), transition: Transition.noTransition),
  GetPage(name: krChat, page: () => ChatScreen(), transition: Transition.noTransition),
];