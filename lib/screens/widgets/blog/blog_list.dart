import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:toeic_learning_app/models/blog_model.dart';

import 'blog_card.dart';

class BlogList extends StatefulWidget {
  final int? lengthListView;
  final List<Blog> blogs;
  final String? authorization;
  const BlogList({
    Key? key,
    required this.blogs,
    this.lengthListView,
    this.authorization,
  }) : super(key: key);

  @override
  State<BlogList> createState() => _BlogListState();
}

class _BlogListState extends State<BlogList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: widget.lengthListView != null
          ? const NeverScrollableScrollPhysics()
          : null,
      itemCount: widget.lengthListView ?? widget.blogs.length,
      itemBuilder: (context, index) {
        Blog blog = widget.blogs[index];
        return AnimationConfiguration.staggeredList(
          position: index,
          child: SlideAnimation(
            child: FadeInAnimation(
                child: BlogCard(
              blog: blog,
              authorization: widget.authorization,
            )),
          ),
        );
      },
    );
  }
}
