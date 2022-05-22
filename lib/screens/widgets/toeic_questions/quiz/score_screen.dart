import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toeic_learning_app/models/user_model.dart';
import 'package:toeic_learning_app/providers/score_provider.dart';
import 'package:toeic_learning_app/screens/quiz_screen.dart';
import '../../../../models/quiz_model.dart';

class ScoreScreen extends StatefulWidget {
  final int? numberOfCorrectAns;
  final int? examId;
  final int? part;
  final User? user;
  final List<Question>? questions;
  const ScoreScreen(
      {Key? key,
      this.numberOfCorrectAns,
      this.questions,
      this.examId,
      this.part, this.user})
      : super(key: key);

  @override
  State<ScoreScreen> createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  @override
  Widget build(BuildContext context) {
    ScoreProvider scoreProvider = Provider.of<ScoreProvider>(context);
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              children: [
                const Spacer(),
                const Text(
                  "Score",
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 179, 176, 176),
                  ),
                ),
                const Spacer(),
                (widget.numberOfCorrectAns != null && widget.questions != null)
                    ? Text(
                        "${widget.numberOfCorrectAns! * 10}/${widget.questions!.length * 10}",
                        style: const TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 179, 176, 176),
                        ),
                      )
                    : const Text(
                        "You don't finish your test.\n Try again. \nTry your best!",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 179, 176, 176),
                        ),
                        textAlign: TextAlign.center,
                      ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    //resert Quiz
                    scoreProvider.addNewScore(widget.numberOfCorrectAns, widget.user?.userId,
                        widget.examId, widget.part);
                     Navigator.push(
                          context,
                          MaterialPageRoute<bool>(
                              builder: (BuildContext context) {
                            return QuizScreen(
                              user: widget.user!,
                            );
                          }),
                        );
                  },
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [
                          Color.fromARGB(255, 123, 186, 238),
                          Color.fromARGB(255, 30, 103, 230)
                        ],
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      "Finished",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
