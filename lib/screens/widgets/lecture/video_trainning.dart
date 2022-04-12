import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toeic_learning_app/models/topic.dart';
import 'package:toeic_learning_app/models/video_model.dart';
import 'package:toeic_learning_app/providers/video_provider.dart';
import '../loader.dart';
import 'video_list.dart';

class VideoTrainning extends StatefulWidget {
  final Topic topic;

  const VideoTrainning({
    Key? key,
    required this.topic,
  }) : super(key: key);

  @override
  State<VideoTrainning> createState() => _VideoTrainningState();
}

class _VideoTrainningState extends State<VideoTrainning> {
  @override
  Widget build(BuildContext context) {
    VideoProvider _videoProvider = Provider.of<VideoProvider>(context);
    var videos = _videoProvider.getVideosList(widget.topic.id);
    return Scaffold(
      body: FutureBuilder<List<Video>>(
        future: videos,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return snapshot.hasData
              ? snapshot.data!.isNotEmpty
                  ? VideoList(
                      videos: snapshot.data!,
                      topic: widget.topic,
                    )
                  : Scaffold(
                      appBar: AppBar(),
                      body: const Center(
                        child: Text('Chưa có bài giảng nào'),
                      ),
                    )
              : const Center(
                  child: ColorLoader(),
                );
        },
      ),
    );
  }
}
