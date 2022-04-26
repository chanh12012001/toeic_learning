import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:toeic_learning_app/config/theme.dart';
import 'package:toeic_learning_app/providers/blog_provider.dart';
import 'package:toeic_learning_app/screens/widgets/widgets.dart';
import 'package:toeic_learning_app/services/toast_service.dart';

class AddEditBlog extends StatefulWidget {
  const AddEditBlog({Key? key}) : super(key: key);

  @override
  State<AddEditBlog> createState() => _AddEditBlogState();
}

class _AddEditBlogState extends State<AddEditBlog> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  bool loading = false;
  ToastService toast = ToastService();
  final ImagePicker _picker = ImagePicker();
  List<XFile>? imageFileList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Thêm Blog',
          style: TextStyle(color: blackColor),
        ),
        elevation: 0.7,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_a_photo),
            color: Colors.black,
            onPressed: () {
              selectImages();
            },
          ),
        ],
      ),
      floatingActionButton: loading == true
          ? const ColorLoader()
          : FloatingActionButton(
              onPressed: () {
                setState(() {
                  loading = true;
                });
                _addBlog(_titleController.text, _contentController.text);
              },
              backgroundColor: Colors.green,
              child: const Icon(Icons.save),
            ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              onChanged: (value) {},
              maxLines: null,
              textCapitalization: TextCapitalization.sentences,
              style: const TextStyle(),
              decoration: const InputDecoration(
                hintText: 'Enter Note Title',
                border: InputBorder.none,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _contentController,
              onChanged: (value) {},
              maxLines: null,
              style: const TextStyle(),
              decoration: const InputDecoration(
                hintText: 'Enter Something...',
                border: InputBorder.none,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            GridView.builder(
              shrinkWrap: true,
              itemCount: imageFileList!.length,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 2,
                crossAxisSpacing: 2,
              ),
              itemBuilder: (context, index) {
                return Image.file(
                  File(imageFileList![index].path),
                  fit: BoxFit.cover,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  _addBlog(String title, String content) async {
    BlogProvider blogProvider =
        Provider.of<BlogProvider>(context, listen: false);
    List<File> _imageFiles = [];
    if (title == '') {
      toast.showToast(
        context: context,
        message: 'Vui lòng nhập tiêu đề blog',
        icon: Icons.error,
        backgroundColor: Colors.redAccent,
      );
    } else {
      imageFileList?.forEach((xFile) {
        _imageFiles.add(File(xFile.path));
      });
      blogProvider.createNewBlog(title, content, _imageFiles).then((value) {
        imageFileList!.clear();

        Navigator.pop(context);
        toast.showToast(
          context: context,
          message: 'Thêm thành công',
          icon: Icons.error,
          backgroundColor: Colors.green,
        );
        setState(() {
          loading = false;
        });
      });
    }
  }

  void selectImages() async {
    final List<XFile>? selectedImages = await _picker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      setState(() {
        imageFileList!.addAll(selectedImages);
      });
    }
  }
}
