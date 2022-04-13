import 'dart:async';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:toeic_learning_app/models/quiz_model.dart';
import 'package:toeic_learning_app/screens/quiz/score_screen.dart';

class ProcessBar extends StatefulWidget {
  final List<Question> question;
  final bool isCompleted;
  const ProcessBar({
    Key? key,
    required this.question,
    required this.isCompleted,
  }) : super(key: key);

  @override
  State<ProcessBar> createState() => _ProcessBarState();
}

class _ProcessBarState extends State<ProcessBar> {
  static const maxSeconds = 300;
  int seconds = maxSeconds;
  Timer? timer;

  @override
  void initState() {
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (seconds > 0 && !widget.isCompleted) {
        setState(() {
          seconds--;
        });
      } else if (seconds == 0) {
        timer?.cancel();
        Navigator.push(
          context,
          MaterialPageRoute<bool>(builder: (BuildContext context) {
            return ScoreScreen(
              numberOfCorrectAns: null,
              questions: null,
            );
          }),
        );
      }
    });
    super.initState();
  }

  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 65,
        height: 65,
        decoration: BoxDecoration(
          border:
              Border.all(color: Color.fromARGB(255, 131, 193, 243), width: 5),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
          child: Text(
            '$seconds',
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 140, 255)),
          ),
        ),
      ),
    );
  }
}
