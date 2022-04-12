import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toeic_learning_app/providers/vocabulary_lesson_provider.dart';

import '../config/theme.dart';
import '../models/vocabulary_lesson_model.dart';
import 'widgets/loader.dart';
import 'widgets/vocabulary/lesson_list.dart';

class VocabularyLessonScreen extends StatefulWidget {
  static const String routeName = '/vocabulary';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const VocabularyLessonScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const VocabularyLessonScreen({Key? key}) : super(key: key);

  @override
  State<VocabularyLessonScreen> createState() => _VocabularyLessonScreenState();
}

class _VocabularyLessonScreenState extends State<VocabularyLessonScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    VocabularyLessonProvider _lessonProvider =
        Provider.of<VocabularyLessonProvider>(context);

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: blackCoffeeColor),
        elevation: 0,
        backgroundColor: whiteColor,
        title: Text(
          'Vocabulary',
          style: TextStyle(color: blackColor),
        ),
        titleSpacing: 20,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 180,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 120,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: const DecorationImage(
                              image: AssetImage("assets/images/bgBanner.png"),
                              fit: BoxFit.fill,
                            ),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 40,
                                color: const Color.fromARGB(255, 58, 112, 206)
                                    .withOpacity(0.2),
                              ),
                              BoxShadow(
                                blurRadius: 40,
                                color: const Color.fromARGB(255, 58, 112, 206)
                                    .withOpacity(0.1),
                              ),
                            ]),
                      ),
                      Positioned(
                        top: 35,
                        right: 20,
                        child: SizedBox(
                          width: size.width / 2,
                          child: const Text(
                            "600 từ vựng Toeic theo chủ đề",
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Image.asset(
                  'assets/images/the_world.png',
                  width: size.width / 2.2,
                ),
              ],
            ),
            FutureBuilder<List<VocabularyLesson>>(
              future: _lessonProvider.getLessonssList(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return snapshot.hasData
                    ? LessonsList(lessons: snapshot.data!)
                    : const Center(
                        child: ColorLoader(),
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}
