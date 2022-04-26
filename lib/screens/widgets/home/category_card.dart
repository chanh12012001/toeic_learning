import 'package:flutter/material.dart';
import '../../../config/theme.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final Color backgroundColor;
  final String iconUrl;
  final Function action;
  const CategoryCard({
    Key? key,
    required this.title,
    required this.backgroundColor,
    required this.iconUrl,
    required this.action,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        action();
      },
      child: SizedBox(
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              radius: size.width / 11,
              backgroundColor: backgroundColor,
              child: Image.asset(
                iconUrl,
                color: Colors.white,
                width: size.width / 10,
              ),
            ),
            Text(title, style: kTitleItem),
          ],
        ),
      ),
    );
  }
}
