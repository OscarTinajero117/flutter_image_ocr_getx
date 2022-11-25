import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/modules/home/home_bindings.dart';
import 'app/modules/home/home_page.dart';
import 'app/routers/pages.dart';
import 'app/routers/routes.dart';

void main() {
  runApp(GetMaterialApp(
    title: 'Image OCR',
    debugShowCheckedModeBanner: false,
    initialRoute: Routes.HOME,
    theme: ThemeData(
      primaryColor: Colors.green,
      primarySwatch: Colors.green,
    ),
    // defaultTransition: Transition.fade,
    initialBinding: HomeBinding(),
    getPages: AppPages.pages,
    home: const HomePage(),
  ));
}
