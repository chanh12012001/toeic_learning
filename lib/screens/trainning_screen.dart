import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:toeic_learning_app/screens/trainning/video_trainning.dart';

class TrainningScreen extends StatefulWidget {
  static const String routeName = '/trainning';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const TrainningScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const TrainningScreen({Key? key}) : super(key: key);

  @override
  State<TrainningScreen> createState() => _TrainningScreenState();
}

class _TrainningScreenState extends State<TrainningScreen> {
  List info = [];
  _initData() async {
    await DefaultAssetBundle.of(context)
        .loadString("assets/json/info.json")
        .then((value) {
          setState(() {
            info = json.decode(value);
          });
    });
  }

  @override
  void initState() {
    super.initState();
    _initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 223, 247, 253),
      body: Container(
        padding: const EdgeInsets.only(top: 70, left: 30, right: 30),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Trainning",
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.black,
                      fontWeight: FontWeight.w700),
                ),
                Expanded(child: Container()),
                Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                  color: Colors.black,
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.calendar_today_outlined,
                  size: 20,
                  color: Colors.black,
                ),
                SizedBox(
                  width: 15,
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                  color: Colors.black,
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Text(
                  "Trainning",
                  style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 131, 131, 131),
                      fontWeight: FontWeight.w700),
                ),
                Expanded(child: Container()),
                Text(
                  "Chi tiết",
                  style: TextStyle(
                      fontSize: 20, color: Color.fromARGB(255, 29, 79, 243)),
                ),
                SizedBox(
                  width: 5,
                ),
                InkWell(
                  onTap: (){
                    Navigator.pushNamed(context, VideoTrainning.routeName);
                  },
                  child: Icon(
                    Icons.arrow_forward,
                    size: 20,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 220,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color.fromARGB(255, 66, 165, 247),
                  Color.fromARGB(255, 58, 112, 206).withOpacity(0.5)
                ]),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                  topRight: Radius.circular(80),
                ),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(5, 10),
                      blurRadius: 10,
                      color:
                          Color.fromARGB(255, 58, 112, 206).withOpacity(0.5)),
                ],
              ),
              child: Container(
                padding: const EdgeInsets.only(left: 20, top: 25, right: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Bài tập kế",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 5,
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
                      SizedBox(height: 25),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.timer, size: 20, color: Colors.white),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "120 min",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          Expanded(child: Container()),
                          Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(60),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blueAccent,
                                    blurRadius: 10,
                                    offset: Offset(4, 8),
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.play_circle_fill,
                                color: Colors.white,
                                size: 60,
                              )),
                        ],
                      ),
                    ]),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              height: 180,
              width: MediaQuery.of(context).size.width,
              child: Stack(children: [
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  width: MediaQuery.of(context).size.width,
                  height: 120,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: AssetImage("assets/images/bgBanner.png"),
                        fit: BoxFit.fill,
                      ),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 40,
                          offset: Offset(8, 10),
                          color: Color.fromARGB(255, 58, 112, 206)
                              .withOpacity(0.5),
                        ),
                        BoxShadow(
                          blurRadius: 40,
                          offset: Offset(-8, -10),
                          color: Color.fromARGB(255, 58, 112, 206)
                              .withOpacity(0.5),
                        ),
                      ]),
                ),
                Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(right: 200, bottom: 30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                Container(
                  width: double.maxFinite,
                  height: 100,
                  margin: const EdgeInsets.only(left: 150, top: 50),
                  child: Column(children: [
                    Text(
                      "Bạn đang làm rất tốt",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RichText(
                      text: TextSpan(
                        text: "Hãy tiếp tục phát huy\n",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                        children: [
                          TextSpan(text: "Duy trì hoạt động của bạn"),
                        ],
                      ),
                    ),
                  ]),
                ),
              ]),
            ),
            Row(
              children: [
                Text(
                  "Loại bài",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
              ],
            ),
            Expanded(
              child: OverflowBox(
                maxWidth: MediaQuery.of(context).size.width,
                child: MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                  child: ListView.builder(
                    itemCount: (info.length.toDouble() / 2).toInt(),
                    itemBuilder: (_, i) {
                      int a = 2 * i;
                      int b = 2 * i + 1;
                      return Row(
                        children: [
                          Container(
                            height: 220,
                            width: (MediaQuery.of(context).size.width-90)/2,
                            padding: EdgeInsets.only(
                              bottom: 15,
                            ),
                            margin: EdgeInsets.only(left: 30,bottom: 10, top: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                image: AssetImage(info[a]['img']),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 3,
                                  offset: Offset(5, 5),
                                  color: Color.fromARGB(255, 58, 112, 206)
                                      .withOpacity(0.1),
                                ),
                                BoxShadow(
                                  blurRadius: 3,
                                  offset: Offset(-5, -5),
                                  color: Color.fromARGB(255, 58, 112, 206)
                                      .withOpacity(0.1),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  info[a]['title'],
                                  style:
                                      TextStyle(fontSize: 20, color: Colors.blue),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 220,
                            width: (MediaQuery.of(context).size.width-90)/2,
                            padding: EdgeInsets.only(
                              bottom: 15,
                            ),
                             margin: EdgeInsets.only(left: 30,bottom: 10,  top: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                image: AssetImage(info[b]['img']),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 3,
                                  offset: Offset(5, 5),
                                  color: Color.fromARGB(255, 58, 112, 206)
                                      .withOpacity(0.1),
                                ),
                                BoxShadow(
                                  blurRadius: 3,
                                  offset: Offset(-5, -5),
                                  color: Color.fromARGB(255, 58, 112, 206)
                                      .withOpacity(0.1),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  info[b]['title'],
                                  style:
                                      TextStyle(fontSize: 20, color: Colors.blue),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
