import 'package:flutter/material.dart';
import 'package:toeic_learning_app/screens/trainning/quiz/quiz_body.dart';

class QuizTrainning extends StatefulWidget {
  final int exam;
  final int part;

  const QuizTrainning({Key? key, required this.exam, required this.part}) : super(key: key);

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
                      Navigator.push(
                        context,
                        MaterialPageRoute<bool>(
                            builder: (BuildContext context) {
                          return quizBody(
                            exam: widget.exam,
                            part: widget.part,
                          );
                        }),
                      );
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
