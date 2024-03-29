import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Fashion app',
      theme: ThemeData(
        useMaterial3: true,
        // primaryColor: ColorApp.colorBlack2,
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.black,
        ),
      ),
      initialRoute: Routes.splashScreen,
      getPages: Routes.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
