import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:satua/app/common/toast_helper.dart';
import 'package:satua/app/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Future<void> registerAccount(String email, String password, String username) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await addUserDetails(email, username);
      await Future.delayed(const Duration(seconds: 1));
      Get.offNamed(Routes.LOGIN);
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'weak-password') {
        message = 'The provided password is too weak';
      } else if (e.code == 'email-already-in-use') {
        message = 'The provided email is already in use';
      }

      showToast(message);
    }
  }

  Future<void> addUserDetails(String email, String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? uid = prefs.getString('userToken');

    await FirebaseFirestore.instance.collection('users').doc(uid).set({
      'email': email,
      'username': username,
      'createdAt': DateTime.now(),
    });
  }

  Future<Map<String, String>?> getUserEmailAndUsername() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? uid = prefs.getString('userToken');

      DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

        String email = data['email'] ?? 'Email not found';
        String username = data['username'] ?? 'Username not found';

        return {
          'email': email,
          'username': username,
        };
      } else {
        return null;
      }
    } catch (e) {
      showToast('Error fetching user data: ${e.toString()}');
      return null;
    }
  }

  Future<void> loginAccount(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);

      String? idToken = await userCredential.user!.getIdToken();
      if (idToken != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('userToken', idToken);
      }

      await Future.delayed(const Duration(seconds: 1));
      Get.offAllNamed(Routes.HOME);
    } on FirebaseAuthException catch (e) {
      showToast(e.message!);
    }
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('userToken');
    await Future.delayed(const Duration(seconds: 1));
    Get.offAllNamed(Routes.LOGIN);
  }
}
