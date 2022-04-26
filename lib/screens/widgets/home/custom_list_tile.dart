import 'package:flutter/material.dart';
import '../../../config/theme.dart';

class CustomListTile extends StatelessWidget {
  final String? title;
  final Function? action;
  final bool isViewAll;
  const CustomListTile(
      {Key? key, this.title, this.action, this.isViewAll = true})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title!, style: kTitleStyle),
          isViewAll
              ? GestureDetector(
                  onTap: () {
                    action!();
                  },
                  child: Text("View all", style: kSubtitleStyle),
                )
              : Container()
        ],
      ),
    );
  }
}
