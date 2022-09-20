import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/route_manager.dart';
import 'package:notedatabase/screen/view/homescreen.dart';
import 'package:notedatabase/screen/view/splashscreen.dart';

void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(name: '/', page: ()=> Splash_Screen()),
        GetPage(name: '/home', page: ()=> Home_Page()),
      ],
    ),
  );
}
