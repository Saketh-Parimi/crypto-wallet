import 'package:crypto_wallet/app/modules/authentication/bindings/authentication_binding.dart';
import 'package:crypto_wallet/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: FirebaseAuth.instance.authStateChanges() == null ? Routes.AUTHENTICATION : Routes.HOME,
      initialBinding: AuthenticationBinding(),
      getPages: AppPages.routes,
    ),
  );
}
