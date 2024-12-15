import 'dart:io';

import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/post_model.dart';

// Firebase Service
class FirebaseService {
  late final FirebaseFirestore firestore;

  FirebaseService () {
    initialize();
  }

  // Initialize Firebase here
  void initialize() async {
    firestore = FirebaseFirestore.instance;
  }

  Future<void> uploadPost(String title, String description, File? image) async {
    try {
      Map<String, dynamic> postData = {
        'title': title,
        'description': description,
        'createdAt': Timestamp.now(),
      };

      await firestore.collection('posts').add(postData);
    } catch (e) {
      Get.snackbar('Error', 'Error uploading post');
    }
  }

  Future<List<Post>> fetchPosts() async {
    try {
      final snapshot = await firestore.collection('posts').get();

      final posts = snapshot.docs.map((doc) {
        return Post.fromMap(doc.data()).copyWith(id: doc.id);
      }).toList();

      return posts;
    } catch (e) {
      Get.snackbar('Error', 'Error Fetching data');
      return [];
    }
  }

  Future<void> updatePost(String postId, String title, String description) async {
    // Update post logic
    try {
      final postRef = firestore.collection('posts').doc(postId);

      Map<String, dynamic> updatedPostData = {
        'title': title,
        'description': description,
        'updateTime': Timestamp.now()
      };

      await postRef.update(updatedPostData);
    } catch (e) {
      Get.snackbar('Error', 'Error updating post');
    }
  }

  Future<void> deletePost(String postId) async {
    // Delete post logic
    try {
      final postRef = firestore.collection('posts').doc(postId);

      await postRef.delete();

      Get.snackbar('success', 'post deleted successfully');
    } catch (e) {
      Get.snackbar('Error', 'Error deleting post');
    }
  }
}