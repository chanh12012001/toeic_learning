import 'package:flutter/material.dart';
import 'package:toeic_learning_app/models/topic.dart';
import 'package:toeic_learning_app/screens/widgets/lecture/detail_video_info_dialog.dart';
import 'package:toeic_learning_app/screens/widgets/lecture/video_card.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../../config/theme.dart';
import '../../../models/video_model.dart';
import '../../../preferences/user_preference.dart';

class VideoList extends StatefulWidget {
  final List<Video> videos;
  final Topic topic;
  const VideoList({
    Key? key,
    required this.videos,
    required this.topic,
  }) : super(key: key);

  @override
  State<VideoList> createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {
  YoutubePlayerController? controller;
  String authorization = '';

  @override
  void deactivate() {
    controller?.pause();
    super.deactivate();
  }

  @override
  void initState() {
    super.initState();
    String url = widget.videos.isNotEmpty ? widget.videos[0].videoUrl! : '';
    controller = YoutubePlayerController(
      flags: const YoutubePlayerFlags(
        mute: false,
        disableDragSeek: true,
        hideThumbnail: true,
      ),
      initialVideoId: YoutubePlayer.convertUrlToId(url)!,
    );
  }

  @override
  Widget build(BuildContext context) {
    UserPreferences userPreferences = UserPreferences();

    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: controller!,
      ),
      builder: (context, player) {
        return Scaffold(
          backgroundColor: whiteColor,
          appBar: AppBar(
            iconTheme: IconThemeData(color: blackCoffeeColor),
            elevation: 0,
            backgroundColor: whiteColor,
            title: Text(
              widget.topic.name!,
              style: TextStyle(color: blackColor),
            ),
            titleSpacing: 20,
            actions: [
              FutureBuilder<String>(
                future: userPreferences.getAuthorization(),
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return Container();
                  }
                  if (snapshot.data! == 'admin') {
                    authorization = snapshot.data!;
                    return IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return DetailVideoInfoDialog(
                              topicId: widget.topic.id!,
                            );
                          },
                        );
                      },
                    );
                  }
                  return Container();
                },
              ),
            ],
          ),
          body: Column(
            children: [
              player,
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(70)),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Row(
                        children: [
                          const Icon(Icons.filter_list),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            "Danh sách bài giảng",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Expanded(child: Container()),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {});
                                },
                                child: const Icon(
                                  Icons.edit,
                                  size: 30,
                                  color: Color.fromARGB(255, 80, 131, 218),
                                ),
                              ),
                              // SizedBox(
                              //   width: 10,
                              // ),
                              // Text(
                              //   "1 lần",
                              //   style: TextStyle(
                              //       fontSize: 15,
                              //       color: Color.fromARGB(192, 0, 0, 0)),
                              // ),
                            ],
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(50))),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: ListView.builder(
                      itemCount: widget.videos.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            controller?.load(YoutubePlayer.convertUrlToId(
                                widget.videos[index].videoUrl!)!);
                          },
                          child: VideoCard(
                            video: widget.videos[index],
                            authorization: authorization,
                            topicId: widget.topic.id!,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    controller?.pause();
    super.dispose();
  }
}
