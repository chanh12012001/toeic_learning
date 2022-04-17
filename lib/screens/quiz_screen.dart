import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:toeic_learning_app/models/toeic_part_model.dart';
import 'package:toeic_learning_app/screens/widgets/toeic_questions/exam_manage/exam_list.dart';
import 'package:toeic_learning_app/screens/widgets/toeic_questions/test_list_by_part.dart';
import '../config/theme.dart';
import 'widgets/toeic_questions/part_card.dart';

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
  List toeicPartsJson = [];
  List<ToeicPart> toeicParts = [];
  List<ToeicPart> toeicPartListening = [];
  List<ToeicPart> toeicPartReading = [];

  _initData() async {
    await DefaultAssetBundle.of(context)
        .loadString("assets/json/toeic-part.json")
        .then((value) {
      setState(() {
        toeicPartsJson = json.decode(value);
        toeicParts =
            toeicPartsJson.map((part) => ToeicPart.fromJson(part)).toList();
      });
      for (var part in toeicParts) {
        if (part.part! > 4) {
          toeicPartReading.add(part);
        } else {
          toeicPartListening.add(part);
        }
      }
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
        backgroundColor: whiteColor,
        appBar: AppBar(
          iconTheme: IconThemeData(color: blackCoffeeColor),
          elevation: 0,
          backgroundColor: whiteColor,
          title: Text(
            'Practice',
            style: TextStyle(color: blackColor),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute<void>(
                  builder: (BuildContext context) {
                    return const ExamsList();
                  },
                ));
              },
              icon: const Icon(Icons.list),
            ),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Practice Listening",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Flexible(
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 3 / 2.3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: toeicPartListening.length,
                    itemBuilder: (context, index) {
                      ToeicPart part = toeicPartListening[index];
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        child: SlideAnimation(
                          child: FadeInAnimation(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute<void>(
                                  builder: (BuildContext context) {
                                    return TestListByPart(
                                      part: part,
                                    );
                                  },
                                ));
                              },
                              child: PartCard(part: part),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Practice Reading",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Flexible(
                  child: GridView.builder(
                    // physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 3 / 2.3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: toeicPartReading.length,
                    itemBuilder: (context, index) {
                      ToeicPart part = toeicPartReading[index];
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        child: SlideAnimation(
                          child: FadeInAnimation(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute<void>(
                                  builder: (BuildContext context) {
                                    return TestListByPart(part: part);
                                  },
                                ));
                              },
                              child: PartCard(part: part),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Expanded(child: Container())
              ],
            ),
          ),
        ));
  }
}
