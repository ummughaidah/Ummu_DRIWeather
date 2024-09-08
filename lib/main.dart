import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/modules/maps/controllers/maps_controller.dart';
import 'app/routes/app_pages.dart';

void main() {
  Get.put(MapsController());
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          useMaterial3: false,
          scrollbarTheme: const ScrollbarThemeData(
              thumbColor: MaterialStatePropertyAll(Colors.white))),
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
