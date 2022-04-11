import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:toeic_learning_app/screens/home_screen.dart';
import 'package:toeic_learning_app/screens/trainning/quiz/quiz_trainning.dart';
import 'package:toeic_learning_app/screens/widgets/rounded_button.dart';

class QuizScreen extends StatefulWidget {
  static const String routeName = '/quiz-screen';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const QuizScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List category = [];
  _initData() async {
    await DefaultAssetBundle.of(context)
        .loadString("assets/json/category.json")
        .then((value) {
          setState(() {
            category = json.decode(value);
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
        child: Column(children: [
          Row(
            children: [
              Text(
                "Quiz",
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                    fontWeight: FontWeight.w700),
              ),
              Expanded(child: Container()),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, HomeScreen.routeName);
                },
                child: Icon(
                  Icons.logout,
                  size: 20,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30,
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
                    itemCount: (category.length.toDouble() / 2).toInt(),
                    itemBuilder: (_, i) {
                      int a = 2 * i;
                      int b = 2 * i + 1;
                      return Row(
                        children: [
                          InkWell(
                            onTap: (() =>  Navigator.push(
          context,
          MaterialPageRoute<bool>(builder: (BuildContext context) {
            return QuizTrainning(
              exam: category[a]['exam'],
              part: category[a]['part'],
            );
          }),
        )),
                            child: Container(
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
                                  image: AssetImage(category[a]['img']),
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
                                    category[a]['title'],
                                    style:
                                        TextStyle(fontSize: 25, color: Colors.blue, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: (() => Navigator.push(
                              context,
                              MaterialPageRoute<bool>(builder: (BuildContext context) {
                                return QuizTrainning(
                                  exam: category[b]['exam'],
                                  part: category[b]['part'],
                                );
                              }),
                            )),
                            child: Container(
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
                                  image: AssetImage(category[b]['img']),
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
                                    category[b]['title'],
                                    style:
                                        TextStyle(fontSize: 25, color: Colors.blue, fontWeight: FontWeight.bold),
                                  ),
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
          
        ]),
      ),
    );
  }
}
