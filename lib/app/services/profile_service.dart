import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:satua/app/common/toast_helper.dart';
import 'package:satua/app/model/profile_model.dart';

class ProfileService {
  Future<void> saveNewProfile(String childsName, DateTime birthDate, int age, String gender, String? neurodevelopmentalDisorder) async {
    Profile newProfile = Profile(
      childsName: childsName,
      birthDate: birthDate,
      age: age,
      gender: gender,
      neurodevelopmentalDisorder: neurodevelopmentalDisorder ?? null,
      createTime: DateTime.now().toString(),
      updateTime: DateTime.now().toString(),
    );

    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance.collection('users').doc(uid).collection('profiles').add(newProfile.toJson());
      await Future.delayed(const Duration(seconds: 1));
    } on FirebaseAuthException catch (e) {
      showToast(e.message!);
    }
  }

  Future<void> editProfile(String profileId, String childsName, DateTime birthDate, int age, String gender, String neurodevelopmentalDisorder) async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot profileSnapshot = await FirebaseFirestore.instance.collection('users').doc(uid).collection('profiles').doc(profileId).get();

      if (profileSnapshot.exists) {
        String existingCreateTime = profileSnapshot['createTime'];

        Profile updatedProfile = Profile(
          id: profileId,
          childsName: childsName,
          birthDate: birthDate,
          age: age,
          gender: gender,
          neurodevelopmentalDisorder: neurodevelopmentalDisorder,
          createTime: existingCreateTime,
          updateTime: DateTime.now().toString(),
        );

        await FirebaseFirestore.instance.collection('users').doc(uid).collection('profiles').doc(profileId).update(updatedProfile.toJson());
        await Future.delayed(const Duration(seconds: 1));
      } else {
        showToast("Profil tidak ditemukan.");
      }
    } on FirebaseAuthException catch (e) {
      showToast(e.message!);
    }
  }

  Future<Profile?> getProfileById(String profileId) async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('users').doc(uid).collection('profiles').doc(profileId).get();

      if (snapshot.exists) {
        return Profile.fromJson(snapshot.data() as Map<String, dynamic>);
      } else {
        return null;
      }
    } catch (e) {
      showToast('Terjadi kesalahan saat mengambil profil: ${e.toString()}');
      return null;
    }
  }

  Future<List<Profile>> getAllProfiles() async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('users').doc(uid).collection('profiles').get();

      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        final profiles = Profile.fromJson(data);
        profiles.id = doc.id;
        return profiles;
      }).toList();
    } catch (e) {
      showToast('Terjadi kesalahan saat mengambil profil: ${e.toString()}');
      return [];
    }
  }

  Future<void> deleteProfile(String profileId) async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance.collection('users').doc(uid).collection('profiles').doc(profileId).delete();
    } catch (e) {
      showToast('Terjadi kesalahan saat menghapus profil: ${e.toString()}');
    }
  }
}
