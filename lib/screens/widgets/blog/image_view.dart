import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../../../config/theme.dart';

class ImageView extends StatefulWidget {
  final List<String>? images;
  final int? currentIndex;
  const ImageView({
    Key? key,
    this.images,
    this.currentIndex = 0,
  }) : super(key: key);

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: widget.currentIndex!);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          PhotoViewGallery.builder(
            pageController: _pageController,
            itemCount: widget.images!.length,
            builder: (context, index) {
              final imageUrl = widget.images![index];
              return PhotoViewGalleryPageOptions(
                imageProvider: NetworkImage(imageUrl),
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.contained * 4,
              );
            },
          ),
          Positioned(
            left: 10,
            // bottom: 0,
            top: 60,
            child: GestureDetector(
              onTap: () {
                Navigator.of(_scaffoldKey.currentContext!).pop();
              },
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: blackColor,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Icon(
                  Icons.arrow_back,
                  color: whiteColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
