import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toeic_learning_app/models/topic.dart';
import 'package:toeic_learning_app/models/video_model.dart';
import 'package:toeic_learning_app/providers/video_provider.dart';
import 'package:toeic_learning_app/screens/widgets/widgets.dart';
import 'video_list.dart';

class VideoTrainning extends StatefulWidget {
  final Topic topic;
  final List<Video>? videos;

  const VideoTrainning({
    Key? key,
    this.videos,
    required this.topic,
  }) : super(key: key);

  @override
  State<VideoTrainning> createState() => _VideoTrainningState();
}

class _VideoTrainningState extends State<VideoTrainning> {
  @override
  Widget build(BuildContext context) {
    VideoProvider _videoProvider = Provider.of<VideoProvider>(context);

    return Scaffold(
      body: FutureBuilder<List<Video>>(
          future: _videoProvider.getVideosList(widget.topic.id),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return snapshot.hasData
                ? VideoList(
                    videos: snapshot.data!,
                    topic: widget.topic,
                  )
                : const ColorLoader();
          }),
    );
  }
}
