import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wapp_chat/app/core/theme/app_theme.dart';
import 'package:wapp_chat/app/data/provider/firebase_provider.dart';
import 'package:wapp_chat/app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: FirebaseProvider().isLoggedIn() ? Routes.HOME : Routes.LOGIN,
      getPages: AppPages.pages,
      theme: appTheme,
    );
  }
}
