import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthenticationController extends GetxController {

  FirebaseAuth _auth = FirebaseAuth.instance;
  Rx<User> _firebaseUser = Rxn<User>();

  User get user => _firebaseUser.value;

  @override
  onReady() {
    _firebaseUser.bindStream(_auth.authStateChanges());
  }

  Future<bool> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch(e) {
      Get.snackbar('Error signing in', e.message);
      return false;
    }
  }

  Future<bool> register(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return true;
    } catch(e) {
      Get.snackbar('Error registering', e.message);
      return false;
    }
  }
}
