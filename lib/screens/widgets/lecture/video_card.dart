import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:toeic_learning_app/models/video_model.dart';
import 'package:toeic_learning_app/providers/video_provider.dart';
import 'package:toeic_learning_app/screens/widgets/lecture/detail_video_info_dialog.dart';

import '../../../config/theme.dart';
import '../../../providers/loading_provider.dart';
import '../../../services/toast_service.dart';
import '../alert_dialog.dart';

class VideoCard extends StatefulWidget {
  final String topicId;
  final Video video;
  final String authorization;
  const VideoCard({
    Key? key,
    required this.video,
    required this.authorization,
    required this.topicId,
  }) : super(key: key);

  @override
  State<VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  ToastService toast = ToastService();

  @override
  Widget build(BuildContext context) {
    double radius = 20;

    return Slidable(
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
                          actionLeft: () {
                            Navigator.pop(context);
                          },
                          actionRight: () {
                            _deleteVideo(widget.video);
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
                        return DetailVideoInfoDialog(
                          video: widget.video,
                          topicId: widget.topicId,
                        );
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
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(bottom: 15),
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 184, 202, 212),
            borderRadius: BorderRadius.circular(radius),
          ),
          child: Row(
            children: [
              Stack(
                children: [
                  Center(
                    child: Container(
                      width: 150,
                      height: 100,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            colorFilter: ColorFilter.mode(
                                Colors.grey.withOpacity(0.8),
                                BlendMode.dstATop),
                            image: NetworkImage(widget.video.thumbnail!),
                            fit: BoxFit.fill,
                          ),
                          border: Border.all(color: Colors.blueAccent),
                          borderRadius: BorderRadius.circular(radius)),
                    ),
                  ),
                  Positioned(
                    top: 30,
                    left: 55,
                    child: Image.asset(
                      "assets/images/player.gif",
                      width: 40,
                      height: 40,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.video.title!,
                      maxLines: 2,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Thời lượng: " + intToTimeLeft(widget.video.time!),
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String intToTimeLeft(int value) {
    int h, m, s;

    h = value ~/ 3600;

    m = ((value - h * 3600)) ~/ 60;

    s = value - (h * 3600) - (m * 60);

    String hourLeft =
        h.toString().length < 2 ? "0" + h.toString() : h.toString();

    String minuteLeft =
        m.toString().length < 2 ? "0" + m.toString() : m.toString();

    String secondsLeft =
        s.toString().length < 2 ? "0" + s.toString() : s.toString();

    String result = "$hourLeft:$minuteLeft:$secondsLeft";

    return result;
  }

  _deleteVideo(Video video) {
    LoadingProvider loadingProvider =
        Provider.of<LoadingProvider>(context, listen: false);
    VideoProvider videoProvider =
        Provider.of<VideoProvider>(context, listen: false);
    videoProvider.deleteVideo(video).then(
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
