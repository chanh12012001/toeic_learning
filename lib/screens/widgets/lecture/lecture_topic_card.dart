import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import '../../../../config/theme.dart';
import '../../../models/topic.dart';
import '../../../providers/loading_provider.dart';
import '../../../providers/topic_provider.dart';
import '../../../services/toast_service.dart';
import '../alert_dialog.dart';
import 'detail_topic_dialog.dart.dart';

class LectureTopicCard extends StatefulWidget {
  final String authorization;
  final Topic topic;
  const LectureTopicCard({
    Key? key,
    required this.topic,
    required this.authorization,
  }) : super(key: key);

  @override
  State<LectureTopicCard> createState() => _LectureTopicCardState();
}

class _LectureTopicCardState extends State<LectureTopicCard> {
  ToastService toast = ToastService();

  @override
  Widget build(BuildContext context) {
    double radius = 20;
    return Slidable(
        // key: const ValueKey(0),
        endActionPane: widget.authorization == 'admin'
            ? ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return MyAlertDialog(
                            title: 'Warning !!!',
                            subTitle: 'Bạn có chắc chắn muốn xoá ?',
                            action: () {
                              _deleteTopic(widget.topic);
                            },
                          );
                        },
                      );
                    },
                    backgroundColor: redColor!,
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Xoá',
                  ),
                  SlidableAction(
                    onPressed: (context) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return DetailTopicDialog(topic: widget.topic);
                        },
                      );
                    },
                    backgroundColor: blueColor!,
                    foregroundColor: Colors.white,
                    icon: Icons.save,
                    label: 'Chỉnh sửa',
                  ),
                ],
              )
            : null,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(bottom: 15),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(radius),
            ),
            child: Row(
              children: [
                Center(
                  child: Container(
                    width: 150,
                    height: 100,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(widget.topic.image!),
                          fit: BoxFit.fill,
                        ),
                        border: Border.all(color: Colors.blueAccent),
                        borderRadius: BorderRadius.circular(radius)),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.topic.name!,
                        maxLines: 2,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        "0 bài giảng",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  _deleteTopic(Topic topic) {
    LoadingProvider loadingProvider =
        Provider.of<LoadingProvider>(context, listen: false);
    TopicProvider topicProvider =
        Provider.of<TopicProvider>(context, listen: false);
    topicProvider.deleteTopic(topic).then(
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
