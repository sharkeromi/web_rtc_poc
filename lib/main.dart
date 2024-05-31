import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_rtc_poc_2/controllers/binder.dart';
import 'package:web_rtc_poc_2/routes.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: false,
          fontFamily: 'Poppins',
        ),
        initialRoute: krSplash,
        getPages: routes,
        initialBinding: BinderController(),
      ),
    );
  }
}


