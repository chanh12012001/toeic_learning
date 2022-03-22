import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toeic_learning_app/preferences/user_preference.dart';
import '../../../../../config/theme.dart';
import '../../../../services/toast_service.dart';
import '../../../models/topic.dart';
import '../../../providers/topic_provider.dart';
import '../loader.dart';
import 'detail_topic_dialog.dart.dart';
import 'lecture_topic_list.dart';

class LectureTab extends StatefulWidget {
  final String lectureTypeId;
  const LectureTab({
    Key? key,
    required this.lectureTypeId,
  }) : super(key: key);

  @override
  State<LectureTab> createState() => _LectureTabState();
}

class _LectureTabState extends State<LectureTab> {
  ToastService toast = ToastService();
  UserPreferences userPreferences = UserPreferences();
  String authorization = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      floatingActionButton: FutureBuilder<String>(
        future: userPreferences.getAuthorization(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Container();
          }
          if (snapshot.data! == 'admin') {
            authorization = snapshot.data!;
            return FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return DetailTopicDialog(
                        lectureTypeId: widget.lectureTypeId);
                  },
                );
              },
              backgroundColor: Colors.green,
              child: const Icon(Icons.add_box),
            );
          }
          return Container();
        },
      ),
      body: _showLecture(),
    );
  }

  _showLecture() {
    TopicProvider topicProvider =
        Provider.of<TopicProvider>(context, listen: false);
    return FutureBuilder<List<Topic>>(
      future: topicProvider.getTopicsList(widget.lectureTypeId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return snapshot.hasData
            ? LectureList(
                topics: snapshot.data!,
                lectureTypeId: widget.lectureTypeId,
                authorization: authorization)
            : const Center(
                child: ColorLoader(),
              );
      },
    );
  }
}
