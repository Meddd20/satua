import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:satua/app/common/toast_helper.dart';
import 'package:satua/app/model/story_model.dart';

class StoryService {
  Future<void> saveNewStory(
    String title,
    String body,
    List<String> reflectiveQuestions,
    List<String> category,
    bool isRead,
    String name,
    String age,
    String language,
    String gender,
    String? neurodevelopmentalDisorder,
    String storyAbout,
    String storySetting,
    String storyFeel,
    String primaryValues,
    String? additionalCharacter,
    String? extraDetails,
  ) async {
    Story newStory = Story(
      title: title,
      body: body,
      reflectiveQuestions: reflectiveQuestions,
      category: category,
      name: name,
      age: age,
      language: language,
      gender: gender,
      neurodevelopmentalDisorder: neurodevelopmentalDisorder,
      storyAbout: storyAbout,
      storySetting: storySetting,
      storyFeel: storyFeel,
      primaryValues: primaryValues,
      additionalCharacter: additionalCharacter ?? "",
      extraDetails: extraDetails ?? "",
      isRead: isRead,
      readTime: (isRead == true) ? DateTime.now().toString() : null,
      createTime: DateTime.now().toString(),
      updateTime: DateTime.now().toString(),
    );

    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance.collection('users').doc(uid).collection('stories').add(newStory.toJson());
      await Future.delayed(const Duration(seconds: 1));
    } on FirebaseAuthException catch (e) {
      showToast(e.message!);
    }
  }

  Future<void> updateStory(
    String storyId,
    String title,
    String body,
    List<String> reflectiveQuestions,
    List<String> category,
    bool isRead,
    String name,
    String age,
    String language,
    String gender,
    String? neurodevelopmentalDisorder,
    String storyAbout,
    String storySetting,
    String storyFeel,
    String primaryValues,
    String? additionalCharacter,
    String? extraDetails,
  ) async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      DocumentReference storyRef = FirebaseFirestore.instance.collection('users').doc(uid).collection('stories').doc(storyId);
      DocumentSnapshot docSnapshot = await storyRef.get();
      Map<String, dynamic>? existingData = docSnapshot.data() as Map<String, dynamic>?;

      Map<String, dynamic> updates = {
        'title': title,
        'body': body,
        'reflectiveQuestions': reflectiveQuestions,
        'category': category,
        'isRead': isRead,
        'readTime': isRead ? DateTime.now().toString() : existingData?['readTime'],
        'updateTime': DateTime.now().toString(),
      };

      if (existingData?['name'] != name) updates['name'] = name;
      if (existingData?['age'] != age) updates['age'] = age;
      if (existingData?['language'] != language) updates['language'] = language;
      if (existingData?['gender'] != gender) updates['gender'] = gender;
      if (existingData?['neurodevelopmentalDisorder'] != neurodevelopmentalDisorder) {
        updates['neurodevelopmentalDisorder'] = neurodevelopmentalDisorder;
      }
      if (existingData?['storyAbout'] != storyAbout) updates['storyAbout'] = storyAbout;
      if (existingData?['storySetting'] != storySetting) updates['storySetting'] = storySetting;
      if (existingData?['storyFeel'] != storyFeel) updates['storyFeel'] = storyFeel;
      if (existingData?['primaryValues'] != primaryValues) updates['primaryValues'] = primaryValues;
      if (existingData?['additionalCharacter'] != additionalCharacter) {
        updates['additionalCharacter'] = additionalCharacter ?? "";
      }
      if (existingData?['extraDetails'] != extraDetails) {
        updates['extraDetails'] = extraDetails ?? "";
      }
      if (existingData?['createTime'] == null) updates['createTime'] = DateTime.now().toString();

      await storyRef.update(updates);
      showToast('Story updated successfully!');
    } catch (e) {
      showToast('Error updating story: ${e.toString()}');
    }
  }

  Future<void> updateStoryReadStatus(String storyId, bool isRead) async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      DocumentReference storyRef = FirebaseFirestore.instance.collection('users').doc(uid).collection('stories').doc(storyId);

      Map<String, dynamic> updates = {
        'isRead': isRead,
        'updateTime': DateTime.now().toString(),
      };

      if (isRead) {
        updates['readTime'] = DateTime.now().toString();
      } else {
        updates['readTime'] = FieldValue.delete();
      }

      await storyRef.update(updates);
      showToast('Story read status updated successfully.');
    } catch (e) {
      showToast('Error updating story read status: ${e.toString()}');
    }
  }

  Future<Story?> getStoryById(String storyId) async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('users').doc(uid).collection('stories').doc(storyId).get();

      if (snapshot.exists) {
        return Story.fromJson(snapshot.data() as Map<String, dynamic>);
      } else {
        return null;
      }
    } catch (e) {
      showToast('Error fetching story: ${e.toString()}');
      return null;
    }
  }

  Future<List<Story>> getAllStories() async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('users').doc(uid).collection('stories').get();

      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        final story = Story.fromJson(data);
        story.id = doc.id;
        return story;
      }).toList();
    } catch (e) {
      showToast('Error fetching stories: ${e.toString()}');
      return [];
    }
  }

  Future<void> deleteStory(String storyId) async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance.collection('users').doc(uid).collection('stories').doc(storyId).delete();
    } catch (e) {
      showToast('Error deleting story: ${e.toString()}');
    }
  }
}
