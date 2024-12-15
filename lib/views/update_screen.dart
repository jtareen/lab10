import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/post_controller.dart';


// Update Screen UI
class UpdateScreen extends StatelessWidget {
  final Map<String, dynamic> post;
  UpdateScreen({super.key, required this.post});

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final PostController postController = Get.find();
  // File? selectedImage;

  @override
  Widget build(BuildContext context) {
    titleController.text = post['title'];
    descriptionController.text = post['description'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Post'),
      ),
      body: Obx(() {
        if (postController.isLoading.value == true) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
                // ElevatedButton(
                //   onPressed: () async {
                //     final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                //     if (pickedFile != null) {
                //       selectedImage = File(pickedFile.path);
                //     }
                //   },
                //   child: const Text('Change Image'),
                // ),
                // if (selectedImage != null)
                //   Image.file(selectedImage!, height: 100, width: 100, fit: BoxFit.cover),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    postController.editPost(
                      post['id'],
                      titleController.text.trim(),
                      descriptionController.text.trim(),
                    );
                    Get.back();
                  },
                  child: const Text('Update'),
                ),
              ],
            ),
          );
        }
      })
    );
  }
}
