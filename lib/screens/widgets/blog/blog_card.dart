import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:toeic_learning_app/config/theme.dart';
import 'package:toeic_learning_app/models/blog_model.dart';
import 'package:toeic_learning_app/providers/blog_provider.dart';
import 'package:toeic_learning_app/services/toast_service.dart';

import '../../../providers/loading_provider.dart';
import '../alert_dialog.dart';
import 'photo_grid.dart';

class BlogCard extends StatefulWidget {
  final Blog blog;
  final String? authorization;
  const BlogCard({
    Key? key,
    required this.blog,
    this.authorization,
  }) : super(key: key);

  @override
  State<BlogCard> createState() => _BlogCardState();
}

class _BlogCardState extends State<BlogCard> {
  List<String> imagesUrl = [];
  ToastService toast = ToastService();
  bool descTextShowFlag = false;

  @override
  void initState() {
    super.initState();
    widget.blog.images?.forEach((image) {
      imagesUrl.add(image.imageUrl!);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: blackColor,
                    borderRadius: BorderRadius.circular(50),
                    image: const DecorationImage(
                      image: AssetImage(
                        'assets/images/text_logo.png',
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  'Toeic Learning Blog',
                  style: GoogleFonts.roboto(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                widget.authorization == 'admin'
                    ? Expanded(
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return MyAlertDialog(
                                    title: 'Warning !!!',
                                    subTitle: 'Bạn có chắc chắn muốn xoá ?',
                                    actionLeft: () {
                                      Navigator.pop(context);
                                    },
                                    actionRight: () {
                                      _deleteBlog(widget.blog);
                                    },
                                  );
                                },
                              );
                            },
                            icon: const Icon(
                              Icons.delete_outline,
                            ),
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
            const SizedBox(height: 15),
            Text(
              widget.blog.title!,
              style: GoogleFonts.roboto(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.blog.content!,
                  maxLines: descTextShowFlag ? 100 : 2,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 17),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        descTextShowFlag = !descTextShowFlag;
                      });
                    },
                    child: descTextShowFlag
                        ? Text(
                            "Rút gọn",
                            style: TextStyle(
                              color: greyColor!,
                              fontSize: 17,
                            ),
                          )
                        : widget.blog.content!.length >= 75
                            ? Text(
                                "Xem thêm",
                                style: TextStyle(
                                  color: greyColor,
                                  fontSize: 17,
                                ),
                              )
                            : const Text(''),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: size.width,
              height: imagesUrl.isEmpty
                  ? 5
                  : imagesUrl.length == 2
                      ? size.width / 2
                      : size.width,
              child: PhotoGrid(
                maxImages: 4,
                imageUrls: imagesUrl,
                onExpandClicked: () {},
                onImageClicked: (int i) {},
              ),
            )
          ],
        ),
      ),
    );
  }

  _deleteBlog(Blog blog) {
    LoadingProvider loadingProvider =
        Provider.of<LoadingProvider>(context, listen: false);
    BlogProvider blogProvider =
        Provider.of<BlogProvider>(context, listen: false);
    blogProvider.deleteBlog(blog).then(
      (response) {
        if (response['status']) {
          Navigator.pop(context);
          loadingProvider.setLoading(false);
          toast.showToast(
            context: context,
            message: response['message'],
            icon: Icons.error,
            backgroundColor: Colors.green,
          );
        } else {
          toast.showToast(
            context: context,
            message: response['message'],
            icon: Icons.error,
            backgroundColor: Colors.redAccent,
          );
        }
      },
    );
  }
}
