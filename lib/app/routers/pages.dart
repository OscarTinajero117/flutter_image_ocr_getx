// ignore_for_file: prefer_const_constructors

import 'package:get/get.dart';

import '../modules/home/home_bindings.dart';
import '../modules/home/home_page.dart';
import 'routes.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: Routes.HOME,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
  ];
}
