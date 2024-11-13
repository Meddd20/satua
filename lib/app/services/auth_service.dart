import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:satua/app/common/toast_helper.dart';
import 'package:satua/app/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Future<void> registerAccount(String email, String password, String username) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String? uid = userCredential.user?.uid;
      if (uid != null) {
        await FirebaseFirestore.instance.collection('users').doc(uid).set({
          'email': email,
          'username': username,
          'createdAt': DateTime.now(),
        });
      }

      await Future.delayed(const Duration(seconds: 1));
      Get.offNamed(Routes.LOGIN);
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'weak-password') {
        message = 'Kata sandi terlalu lemah';
      } else if (e.code == 'email-already-in-use') {
        message = 'Email sudah terdaftar';
      }

      showToast(message);
    }
  }

  Future<void> updateUsername(String username) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        showToast('Pengguna tidak terautentikasi');
        return;
      }

      String uid = user.uid;
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'username': username,
      });

      await prefs.setString('username', username);
    } catch (e) {
      showToast('Kesalahan memperbarui username: ${e.toString()}');
    }
  }

  Future<void> loginAccount(String email, String password) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      String? uid = userCredential.user?.uid;
      DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      final data = snapshot.data();
      if (data != null) {
        final userData = data as Map<String, dynamic>;
        await prefs.setString('username', userData['username']);
      }
      await prefs.setBool('isShowUsername', true);

      String? idToken = await userCredential.user!.getIdToken();
      if (idToken != null) {
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
    await prefs.remove('username');
    await Future.delayed(const Duration(seconds: 1));
    Get.offAllNamed(Routes.LOGIN);
  }
}
