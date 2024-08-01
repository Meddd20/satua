import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:satua/app/common/toast_helper.dart';
import 'package:satua/app/model/story_model.dart';

class StoryService {
  Future<void> saveNewStory(String title, String body, List<String> reflectiveQuestions, List<String> category, bool isRead) async {
    Story newStory = Story(
      title: title,
      body: body,
      reflectiveQuestions: reflectiveQuestions,
      category: category,
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

  Future<void> editStory(String storyId, {String? title, String? body, List<String>? reflectiveQuestions, List<String>? category, bool? isRead}) async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      DocumentReference storyRef = FirebaseFirestore.instance.collection('users').doc(uid).collection('stories').doc(storyId);

      Map<String, dynamic> updates = {};
      if (title != null) updates['title'] = title;
      if (body != null) updates['body'] = body;
      if (reflectiveQuestions != null) updates['reflectiveQuestions'] = reflectiveQuestions;
      if (category != null) updates['category'] = category;
      if (isRead != null) {
        updates['isRead'] = isRead;
        if (isRead) updates['readTime'] = DateTime.now().toString();
      }
      updates['updateTime'] = DateTime.now().toString();

      await storyRef.update(updates);
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
