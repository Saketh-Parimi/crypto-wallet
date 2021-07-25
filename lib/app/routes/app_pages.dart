import 'package:get/get.dart';

import 'package:crypto_wallet/app/modules/add/bindings/add_binding.dart';
import 'package:crypto_wallet/app/modules/add/views/add_view.dart';
import 'package:crypto_wallet/app/modules/authentication/bindings/authentication_binding.dart';
import 'package:crypto_wallet/app/modules/authentication/views/authentication_view.dart';
import 'package:crypto_wallet/app/modules/home/bindings/home_binding.dart';
import 'package:crypto_wallet/app/modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.AUTHENTICATION;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.AUTHENTICATION,
      page: () => AuthenticationView(),
      binding: AuthenticationBinding(),
    ),
    GetPage(
      name: _Paths.ADD,
      page: () => AddView(),
      binding: AddBinding(),
    ),
  ];
}
