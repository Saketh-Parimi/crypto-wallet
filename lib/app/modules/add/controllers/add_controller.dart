import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_wallet/app/data/models/coin_model.dart';
import 'package:crypto_wallet/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:get/get.dart';

class AddController extends GetxController {
  final authController = Get.put(AuthenticationController());

  List<String> coins = [
    "bitcoin",
    "tether",
    "ethereum",
  ];

  final RxString dropdownValue = 'bitcoin'.obs;

  Future<bool> addCoin(String id, String amount) async {
    try {
      String uid = authController.user?.uid;
      var value = double.parse(amount);
      DocumentReference documentReference = FirebaseFirestore.instance
          .collection('Users')
          .doc(uid)
          .collection('Coins')
          .doc(id);
      FirebaseFirestore.instance.runTransaction((transaction) async {
        DocumentSnapshot snapshot = await transaction.get(documentReference);
        if (!snapshot.exists) {
          documentReference.set({"Amount": value });
          return true;
        }
        double newAmount = (snapshot.data() as Map)['Amount'] + value;
        transaction.update(documentReference, {'Amount': newAmount});
        return true;
      }).then((value) {
        Get.snackbar('Successful', 'Added coin successfully');
        return true;
      });
    } catch (e) {
      Get.snackbar('Error adding coin', e.message);
      return false;
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
