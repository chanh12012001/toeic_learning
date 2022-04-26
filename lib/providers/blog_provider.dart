import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:toeic_learning_app/models/blog_model.dart';
import 'package:toeic_learning_app/repositories/blog_repository.dart';

class BlogProvider with ChangeNotifier {
  static List<Blog> blogs = [];
  BlogRepository blogRepository = BlogRepository();

  Future<Blog> createNewBlog(title, content, List<File> images) async {
    Blog blog = await blogRepository.createNewBlog(title, content, images);
    blogs.add(blog);
    notifyListeners();
    return blog;
  }

  // get all blogs
  Future<List<Blog>> getBlogsList() async {
    blogs = await blogRepository.getBlogsList();
    return blogs;
  }

  Future<Map<String, dynamic>> deleteBlog(Blog blog) async {
    Map<String, dynamic> result;
    result = await blogRepository.deleteBlog(blog);
    blogs.remove(blog);
    notifyListeners();
    return result;
  }

  // Future<Map<String, dynamic>> updateTopic(id, name, File? file) async {
  //   Map<String, dynamic> result;
  //   result = await topicRepository.updateTopic(id, name, file);
  //   notifyListeners();
  //   return result;
  // }

  // Future<File> convertUrlImageToFile(String imageUrl) async {
  //   File file = await topicRepository.urlToFile(imageUrl);
  //   notifyListeners();
  //   return file;
  // }
}
