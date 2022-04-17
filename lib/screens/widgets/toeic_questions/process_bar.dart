import 'dart:async';
import 'package:flutter/material.dart';
import 'package:toeic_learning_app/config/theme.dart';
import 'package:toeic_learning_app/models/quiz_model.dart';
import 'quiz/score_screen.dart';

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
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (seconds > 0 && !widget.isCompleted) {
        setState(() {
          seconds--;
        });
      } else if (seconds == 0) {
        timer?.cancel();
        Navigator.push(
          context,
          MaterialPageRoute<bool>(builder: (BuildContext context) {
            return const ScoreScreen(
              numberOfCorrectAns: null,
              questions: null,
            );
          }),
        );
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Time: ',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w500,
            color: greyColor,
          ),
        ),
        Text(
          '$seconds',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w500,
            color: tealColor,
          ),
        ),
      ],
    );
  }
}
