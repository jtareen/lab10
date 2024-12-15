import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/views/update_screen.dart';
import 'package:social_media_app/views/upload_screen.dart';

import '../controllers/post_controller.dart';

// Feed Screen UI
class FeedScreen extends StatelessWidget {
  FeedScreen({super.key});

  final PostController postController = Get.put(PostController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feed', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25),),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.grey[200],
      body: Obx(
            () {
              if (postController.isLoading.value == true) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              else if (postController.posts.isEmpty) {
                return const Center(
                  child: Text('No posts available.')
                );
              }
              else {
                return ListView.builder(
                  itemCount: postController.posts.length,
                    itemBuilder: (context, index) {
                      final post = postController.posts[index].toMap();
                      return Card(
                        color: Colors.white,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          children: [
                            ListTile(
                            title: Text(post['title'],
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                                letterSpacing: 0.5,
                              ),
                            ),
                            subtitle: Text(post['description'],
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.grey[600],
                                fontStyle: FontStyle.italic,
                                height: 1.3,
                              ),
                            ),
                            leading: post['image'] != null ? Image.network(post['image'], width: 50, height: 50, fit: BoxFit.cover) : null,
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                    onPressed: () {
                                      Get.to(() => UpdateScreen(post: post));
                                    },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    postController.removePost(post['id']);
                                  },
                                ),
                              ],
                            ),
                          ),
                            const SizedBox(height: 10,),
                            GestureDetector(
                                onLongPress: () {
                                  // download logic
                                  print('Downloading image');
                                },
                                child: Image.network('https://cdn.pixabay.com/photo/2024/01/17/12/06/car-8514314_640.png')
                            ),
                            const SizedBox(height: 30,),
                          ]
                        ),
                      );
                    },
                );
              }
            },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
          onPressed: () => Get.to(() => UploadScreen()),
          child: const Icon(Icons.add),
      ),
    );
  }
}