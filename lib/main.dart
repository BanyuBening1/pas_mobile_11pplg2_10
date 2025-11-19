import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:pas_mobile_11pplg2_10/binding/app_binding.dart';
import 'package:pas_mobile_11pplg2_10/routes/pages.dart';
import 'package:pas_mobile_11pplg2_10/routes/routes.dart';

void main() {
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: AppRoutes.splashPage,
      initialBinding: AppBinding(),
      getPages: AppPages.pages,
    );
  }
}

