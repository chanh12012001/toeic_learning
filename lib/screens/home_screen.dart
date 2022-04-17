import 'package:flutter/material.dart';
import 'package:toeic_learning_app/screens/dictionary_screen.dart';
import 'package:toeic_learning_app/screens/quiz_screen.dart';
import 'package:toeic_learning_app/screens/widgets/rounded_button.dart';
import '../preferences/lecture_type_preference.dart';
import 'screens.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const HomeScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LectureTypePreferences lectureTypePreferences = LectureTypePreferences();
    return Scaffold(
      appBar: AppBar(
        title: const Text("HOME"),
        elevation: 0.1,
        leading: GestureDetector(
          onTap: () {},
          child: const Icon(Icons.person),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              lectureTypePreferences.removeLecture();
              Navigator.pushReplacementNamed(context, LoginScreen.routeName);
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 15),
              child: Icon(Icons.logout),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RoundedButton(
              text: 'Lecture',
              onPressed: () {
                Navigator.pushNamed(context, LectureScreen.routeName);
              },
              width: 0.4,
            ),
            RoundedButton(
              text: 'Vocabulary',
              color: Colors.black,
              onPressed: () {
                Navigator.pushNamed(context, VocabularyLessonScreen.routeName);
              },
              width: 0.4,
            ),
            RoundedButton(
              text: 'Quiz',
              color: Colors.black,
              onPressed: () {
                Navigator.pushNamed(context, QuizScreen.routeName);
              },
              width: 0.4,
            ),
            RoundedButton(
              text: 'Dictionary',
              color: Colors.pink,
              onPressed: () {
                Navigator.pushNamed(context, DictionaryScreen.routeName);
              },
              width: 0.4,
            ),
          ],
        ),
      ),
    );
  }
}
