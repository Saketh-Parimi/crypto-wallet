import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_wallet/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  final authController = Get.put(AuthenticationController());

  RxDouble bitcoin = 0.0.obs;
  RxDouble ethereum = 0.0.obs;
  RxDouble tether = 0.0.obs;

  Future<double> getPrice(String id) async {
    try {
      final url = "https://api.coingecko.com/api/v3/coins/$id";
      var response = await http.get(Uri.parse(url));
      var json = jsonDecode(response.body);
      var value = json['market_data']['current_price']['usd'].toString();
      return double.parse(value);
    } catch (e) {
      Get.snackbar('Error getting price', e.toString());
      return 0.0;
    }
  }

  Future<bool> removeCoin(String id) async {
    try {
      String? uid = authController.user?.uid;
      FirebaseFirestore.instance
          .collection('Users')
          .doc(uid)
          .collection('Coins')
          .doc(id)
          .delete();
      return true;
    } catch(e) {
      Get.snackbar('Error deleting item', e.toString());
      return false;
    }
  }

  Future<bool> signOut() async {
    try {
      FirebaseAuth.instance.signOut();
      return true;
    } catch(e) {
      Get.snackbar('Error signing out', e.toString());
      return false;
    }
  }

  getValues(String id, double amount) {
    if (id == 'bitcoin') {
      return bitcoin.value * amount;
    } else if (id == 'ethereum') {
      return ethereum.value * amount;
    } else {
      return tether.value * amount;
    }
  }

  @override
  void onReady() async {
    bitcoin.value = await getPrice('bitcoin');
    ethereum.value = await getPrice('ethereum');
    tether.value = await getPrice('tether');
    super.onReady();
  }
}
