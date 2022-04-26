import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toeic_learning_app/models/blog_model.dart';
import 'package:toeic_learning_app/providers/blog_provider.dart';
import 'package:toeic_learning_app/screens/widgets/blog/add_edit_blog.dart';
import 'package:toeic_learning_app/screens/widgets/blog/blog_list.dart';
import 'package:toeic_learning_app/screens/widgets/loader.dart';

import '../config/theme.dart';

class BlogScreen extends StatefulWidget {
  static const String routeName = '/blog';

  const BlogScreen({Key? key}) : super(key: key);

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  @override
  Widget build(BuildContext context) {
    final data =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;

    BlogProvider blogProvider = Provider.of<BlogProvider>(context);
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: blackCoffeeColor),
        elevation: 0,
        backgroundColor: whiteColor,
        title: Text(
          'Blog',
          style: TextStyle(color: blackColor),
        ),
        titleSpacing: 20,
        actions: [
          data['auth'] == 'admin'
              ? IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => const AddEditBlog(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.add),
                )
              : Container(),
        ],
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: FutureBuilder<List<Blog>>(
          future: blogProvider.getBlogsList(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return snapshot.hasData
                ? BlogList(
                    blogs: snapshot.data!,
                    authorization: data['auth'],
                  )
                : const Center(
                    child: ColorLoader(),
                  );
          },
        ),
      ),
    );
  }
}
