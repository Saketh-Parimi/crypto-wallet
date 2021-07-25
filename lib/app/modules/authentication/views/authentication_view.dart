import 'package:crypto_wallet/app/modules/home/views/home_view.dart';
import 'package:crypto_wallet/app/routes/app_pages.dart';
import 'package:crypto_wallet/app/widgets/submit_button.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/authentication_controller.dart';

class AuthenticationView extends GetView<AuthenticationController> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.size.width,
        height: Get.size.height,
        decoration: BoxDecoration(color: Colors.blueAccent),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: Get.size.width / 1.3,
              child: TextFormField(
                style: TextStyle(color: Colors.white),
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: "something@email.com",
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                  labelText: "Email",
                  labelStyle: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: Get.size.height / 35,
            ),
            Container(
              width: Get.size.width / 1.3,
              child: TextFormField(
                style: TextStyle(color: Colors.white),
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Password",
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                  labelText: "Password",
                  labelStyle: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: Get.size.height / 35,
            ),
            SubmitButton(
              onPressed: () async {
                bool shouldNavigate = await controller.register(
                    _emailController.text, _passwordController.text);
                if (shouldNavigate) {
                  Get.offAll(() => HomeView());
                }
              },
              child: Text("Register"),
            ),
            SizedBox(
              height: Get.size.height / 35,
            ),
            SubmitButton(
              onPressed: () async {
                bool shouldNavigate = await controller.signIn(
                    _emailController.text, _passwordController.text);
                if (shouldNavigate) {
                  Get.offAllNamed(Routes.HOME);
                }
              },
              child: Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
