import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String id;
  final String title;
  final String description;
  final String? imageUrl;
  final Timestamp createdAt;

  Post({
    required this.id,
    required this.title,
    required this.description,
    this.imageUrl,
    required this.createdAt
  });

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      imageUrl: map['image'],
      createdAt: map['createdAt'] ?? ''
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image': imageUrl,
      'createdAt': createdAt
    };
  }

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['image'],
      createdAt: json['createdAt'] ?? ''
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image': imageUrl,
      'createdAt': createdAt
    };
  }

  Post copyWith({
    String? id,
    String? title,
    String? description,
    String? imageUrl,
    Timestamp? createdAt,
  }) {
    return Post(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}