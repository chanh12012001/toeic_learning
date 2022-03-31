import 'package:flutter/material.dart';
import 'package:toeic_learning_app/screens/trainning/quiz/test_quiz.dart';
import 'package:websafe_svg/websafe_svg.dart';

class QuizTrainning extends StatefulWidget {
  static const String routeName = '/quiz-trainning';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const QuizTrainning(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const QuizTrainning({Key? key}) : super(key: key);

  @override
  State<QuizTrainning> createState() => _QuizTrainningState();
}

class _QuizTrainningState extends State<QuizTrainning> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Spacer(),
                  Text(
                    "Let's test",
                    style: TextStyle(
                      color: Color.fromARGB(255, 15, 143, 247),
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                    ),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, TestQuiz.routeName);
                    },
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          colors: [
                            Color.fromARGB(255, 123, 186, 238),
                            Color.fromARGB(255, 30, 103, 230)
                          ],
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "Click here to start",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
