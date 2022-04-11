import 'package:flutter/material.dart';
import 'package:toeic_learning_app/screens/quiz_screen.dart';
import 'package:toeic_learning_app/screens/trainning/quiz/QuestionCard.dart';

import '../../../models/quiz_model.dart';

class ScoreScreen extends StatefulWidget {
  final int? numberOfCorrectAns;
  final List<Question>? questions;
  const ScoreScreen({Key? key, this.numberOfCorrectAns, this.questions})
      : super(key: key);

  @override
  State<ScoreScreen> createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              children: [
                Spacer(),
                Text(
                  "Score",
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 179, 176, 176),
                  ),
                ),
                Spacer(),
                (widget.numberOfCorrectAns != null && widget.questions != null)
                    ? Text(
                        "${widget.numberOfCorrectAns! * 10}/${widget.questions!.length * 10}",
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 179, 176, 176),
                        ),
                      )
                    : Text(
                        "You don't finish your test.\n Try again. \nTry your best!",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 179, 176, 176),
                        ),
                        textAlign: TextAlign.center,
                      ),
                Spacer(),
                InkWell(
                  onTap: () {
                    //resert Quiz
                    Navigator.pushNamed(context, QuizScreen.routeName);
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
                      "Finished",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
