import 'dart:math';

import 'package:flutter/material.dart';

import 'image_view.dart';

class PhotoGrid extends StatefulWidget {
  final int maxImages;
  final List<String> imageUrls;
  final Function(int) onImageClicked;
  final Function onExpandClicked;

  const PhotoGrid(
      {required this.imageUrls,
      required this.onImageClicked,
      required this.onExpandClicked,
      this.maxImages = 4,
      Key? key})
      : super(key: key);

  @override
  createState() => _PhotoGridState();
}

class _PhotoGridState extends State<PhotoGrid> {
  @override
  Widget build(BuildContext context) {
    var images = buildImages();

    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: images.length == 1 ? 1 : 2,
      children: images,
    );
  }

  List<Widget> buildImages() {
    int numImages = widget.imageUrls.length;
    return List<Widget>.generate(min(numImages, widget.maxImages), (index) {
      String imageUrl = widget.imageUrls[index];

      // If its the last image
      if (index == widget.maxImages - 1) {
        // Check how many more images are left
        int remaining = numImages - widget.maxImages;

        // If no more are remaining return a simple image widget
        if (remaining == 0) {
          return GestureDetector(
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
            onTap: () => openImageGalleryView(widget.imageUrls, index, context),
          );
        } else {
          // Create the facebook like effect for the last image with number of remaining  images
          return GestureDetector(
            onTap: () => openImageGalleryView(widget.imageUrls, index, context),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(imageUrl, fit: BoxFit.cover),
                Positioned.fill(
                  child: Container(
                    alignment: Alignment.center,
                    color: Colors.black54,
                    child: Text(
                      '+' + remaining.toString(),
                      style: const TextStyle(fontSize: 32, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      } else {
        return GestureDetector(
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
          ),
          onTap: () => openImageGalleryView(widget.imageUrls, index, context),
        );
      }
    });
  }

  void openImageGalleryView(images, index, BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ImageView(
          images: images,
          currentIndex: index,
        ),
      ),
    );
  }
}
