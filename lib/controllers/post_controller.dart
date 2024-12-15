import 'dart:io';

import 'package:get/get.dart';
import 'package:social_media_app/models/post_model.dart';

import '../services/firebase_service.dart';

// Controller for handling state
class PostController extends GetxController {
  RxList<Post> posts = <Post>[].obs;
  final FirebaseService _firebaseService = FirebaseService();
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPosts();
  }

  void fetchPosts() async {
    isLoading.value = true;
    posts.value = await _firebaseService.fetchPosts();
    isLoading.value = false;
  }

  Future<void> addPost(String title, String description, File? image) async {
    isLoading.value = true;
    await _firebaseService.uploadPost(title, description, image);
    fetchPosts();
    isLoading.value = false;
  }

  void editPost(String postId, String title, String description) async {
    isLoading.value = true;
    await _firebaseService.updatePost(postId, title, description);
    fetchPosts();
    isLoading.value = false;
  }

  void removePost(String postId) async {
    isLoading.value = true;
    await _firebaseService.deletePost(postId);
    fetchPosts();
    isLoading.value = false;
  }
}