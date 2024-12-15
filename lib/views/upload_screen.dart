import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/post_controller.dart';

class UploadScreen extends StatelessWidget {
  UploadScreen({super.key});

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final PostController postController = Get.find();

  File? selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Post'),
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
                  controller: _titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                ),
                TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
                // ElevatedButton(
                //   onPressed: uploadController.pickImage,
                //   child: const Text('Select Image'),
                // ),
                // if (uploadController.selectedImage != null)
                //   Image.file(uploadController.selectedImage!.value, height: 100, width: 100, fit: BoxFit.cover),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    if (_titleController.text.trim().isEmpty
                        || _descriptionController.text.trim().isEmpty) {
                      Get.snackbar('Error', 'Please provide a title and description');
                    } else {
                      postController.addPost(
                          _titleController.text.trim(),
                          _descriptionController.text.trim(),
                          selectedImage
                      );
                      Get.back();
                      Get.snackbar('success', 'Post uploaded successfully');
                    }
                  },
                  child: const Text('Upload'),
                ),
              ],
            ),
          );
        }
      })
    );
  }
}