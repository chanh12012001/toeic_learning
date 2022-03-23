import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toeic_learning_app/screens/trainning_screen.dart';
import 'package:video_player/video_player.dart';

class VideoTrainning extends StatefulWidget {
  static const String routeName = '/video-train';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const VideoTrainning(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const VideoTrainning({Key? key}) : super(key: key);

  @override
  State<VideoTrainning> createState() => _VideoTrainningState();
}

class _VideoTrainningState extends State<VideoTrainning> {
  List videoTrain = [];
  bool _playArea = false;
  bool _isPlaying = false;
  bool _dispose = false;
  int _isPlayingIndex = -1;
  VideoPlayerController? _controller;
  _initData() async {
    await DefaultAssetBundle.of(context)
        .loadString("assets/json/video-train.json")
        .then((value) {
      setState(() {
        videoTrain = json.decode(value);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _initData();
  }

  @override
  void dispose() {
    _dispose = true;
    _controller?.pause();
    _controller?.dispose();
    _controller = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: _playArea == false
            ? BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 11, 136, 238),
                    Color.fromARGB(255, 11, 53, 238),
                  ],
                  begin: const FractionalOffset(0.0, 0.4),
                  end: Alignment.topRight,
                ),
              )
            : BoxDecoration(
                color: Color.fromARGB(255, 11, 53, 238),
              ),
        child: Column(children: [
          _playArea == false
              ? Container(
                  padding: EdgeInsets.only(top: 70, left: 30, right: 20),
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, TrainningScreen.routeName);
                                },
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  size: 20,
                                  color: Colors.white,
                                )),
                            Expanded(child: Container()),
                            Icon(
                              Icons.info_outline,
                              size: 20,
                              color: Colors.white,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          "Listening",
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "and Answer The Questions",
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Row(
                          children: [
                            Container(
                              width: 90,
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                  colors: [
                                    Color.fromARGB(255, 68, 163, 241),
                                    Color.fromARGB(255, 91, 153, 247),
                                  ],
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topRight,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.timer,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "15 min",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              width: 250,
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                  colors: [
                                    Color.fromARGB(255, 68, 163, 241),
                                    Color.fromARGB(255, 91, 153, 247),
                                  ],
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topRight,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.headphones,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Chủ đề về động vật",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ]),
                )
              : Container(
                  child: Column(children: [
                    Container(
                      height: 100,
                      padding:
                          const EdgeInsets.only(top: 50, left: 30, right: 30),
                      child: Row(children: [
                        InkWell(
                          onTap: () {},
                          child: Icon(Icons.arrow_back_ios,
                              size: 20, color: Colors.white),
                        ),
                        Expanded(child: Container()),
                        Icon(
                          Icons.info_outline,
                          size: 20,
                          color: Colors.white,
                        ),
                      ]),
                    ),
                    _playVideo(context),
                    _controlVideo(context),
                  ]),
                ),
          Expanded(
              child: Container(
            padding: EdgeInsets.only(left: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topRight: Radius.circular(70)),
            ),
            child: Column(children: [
              SizedBox(height: 30),
              Row(
                children: [
                  Text(
                    "Bài tập 1: Nghe và chọn đáp án",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(child: Container()),
                  Row(
                    children: [
                      Icon(
                        Icons.loop,
                        size: 30,
                        color: Color.fromARGB(255, 80, 131, 218),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "1 lần",
                        style: TextStyle(
                            fontSize: 15, color: Color.fromARGB(192, 0, 0, 0)),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 20,
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(child: _listVideo()),
            ]),
          )),
        ]),
      ),
    );
  }

  Widget _controlVideo(BuildContext context) {
    final noMute = (_controller?.value.volume ?? 0) > 0;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 40,
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(bottom: 5),
          color: Color.fromARGB(255, 11, 53, 238),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  if (noMute) {
                    _controller?.setVolume(0);
                  } else {
                    _controller?.setVolume(1);
                  }
                  setState(() {
                    
                  });
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Container(
                    decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                      BoxShadow(
                        offset: Offset(0.0, 0.0),
                        blurRadius: 4.0,
                        color: Color.fromARGB(50, 0, 0, 0),
                      ),
                    ]),
                    child: Icon(noMute? 
                      Icons.volume_up : Icons.volume_off,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              FlatButton(
                  onPressed: () async {
                    final index = _isPlayingIndex - 1;
                    if (index >= 0 && videoTrain.length >= 0) {
                      _onTapVideo(index);
                    } else {
                      Get.snackbar(
                        "Video",
                        "",
                        snackPosition: SnackPosition.BOTTOM,
                        icon: Icon(
                          Icons.face,
                          size: 30,
                          color: Colors.white,
                        ),
                        backgroundColor: Colors.blue.withOpacity(.5),
                        colorText: Colors.white,
                        messageText: Text(
                          "Không còn video nào khác",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      );
                    }
                  },
                  child: Icon(
                    Icons.fast_rewind,
                    size: 36,
                    color: Colors.white,
                  )),
              FlatButton(
                  onPressed: () async {
                    if (_isPlaying) {
                      setState(() {
                        _isPlaying = false;
                      });
                      _controller?.pause();
                    } else {
                      setState(() {
                        _isPlaying = true;
                      });
                      _controller?.play();
                    }
                  },
                  child: Icon(
                    _isPlaying ? Icons.pause : Icons.play_arrow,
                    size: 36,
                    color: Colors.white,
                  )),
              FlatButton(
                  onPressed: () async {
                    final index = _isPlayingIndex + 1;
                    if (index <= videoTrain.length) {
                      _onTapVideo(index);
                    } else {
                      Get.snackbar(
                        "Video",
                        "",
                        snackPosition: SnackPosition.BOTTOM,
                        icon: Icon(
                          Icons.face,
                          size: 30,
                          color: Colors.white,
                        ),
                        backgroundColor: Colors.blue.withOpacity(.5),
                        colorText: Colors.white,
                        messageText: Text(
                          "Bạn đã hoàn thành toàn bộ!",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      );
                    }
                  },
                  child: Icon(
                    Icons.fast_forward,
                    size: 36,
                    color: Colors.white,
                  )),
            ],
          ),
        ),
      ],
    );
  }

  Widget _playVideo(BuildContext context) {
    final controller = _controller;
    if (controller != null && controller.value.isInitialized) {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: VideoPlayer(controller),
      );
    } else {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: Center(
            child: Text(
          "Video đang tải...",
          style: TextStyle(fontSize: 20, color: Colors.white),
        )),
      );
    }
  }

  var _onControllerTime;
  void _onControllerUpdate() async {
    if (_dispose) {
      return;
    }
    _onControllerTime = 0;
    final now = DateTime.now().microsecondsSinceEpoch;
    if (_onControllerTime > now) {
      return;
    }
    _onControllerTime = now + 500;
    final controller = _controller;
    if (controller == null) {
      debugPrint("Controller is null");
      return;
    }
    if (!controller.value.isInitialized) {
      debugPrint("Controller can not be initialized");
      return;
    }
    final playing = controller.value.isPlaying;
    _isPlaying = playing;
  }

  _onTapVideo(int index) {
    final controller =
        VideoPlayerController.network(videoTrain[index]["videoUrl"]);
    final old = _controller;
    if (old != null) {
      old.removeListener(_onControllerUpdate);
      old.pause();
    }
    _controller = controller;
    setState(() {});
    controller
      ..initialize().then((_) {
        old?.dispose();
        _isPlayingIndex = index;
        controller.addListener(_onControllerUpdate);
        controller.play();
        setState(() {});
      });
  }

  _listVideo() {
    return ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        itemCount: videoTrain.length,
        itemBuilder: (_, int index) {
          return GestureDetector(
              onTap: () {
                _onTapVideo(index);
                debugPrint(index.toString());
                setState(() {
                  if (_playArea == false) {
                    _playArea = true;
                  }
                });
              },
              child: _videoCard(index));
        });
  }

  _videoCard(int index) {
    return Container(
      height: 135,
      child: Column(children: [
        Row(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 1),
                image: DecorationImage(
                    image: AssetImage(videoTrain[index]["thumbnail"]),
                    fit: BoxFit.cover),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  videoTrain[index]["title"],
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 3),
                  child: Text(
                    videoTrain[index]["time"],
                    style: TextStyle(color: Colors.grey[500]),
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 18,
        ),
        Row(
          children: [
            Container(
              width: 90,
              height: 20,
              decoration: BoxDecoration(
                color: Color(0xFFeaeefc),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  "10s suy nghĩ",
                  style: TextStyle(color: Color(0xFF839fed)),
                ),
              ),
            ),
            Row(
              children: [
                for (int i = 0; i < 70; i++)
                  i.isEven
                      ? Container(
                          width: 3,
                          height: 1,
                          decoration: BoxDecoration(
                            color: Color(0xFF839fed),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        )
                      : Container(
                          width: 3,
                          height: 1,
                          color: Colors.white,
                        ),
              ],
            ),
          ],
        ),
      ]),
    );
  }
}
