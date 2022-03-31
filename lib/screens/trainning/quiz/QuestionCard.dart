import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toeic_learning_app/models/quiz_model.dart';
import 'package:toeic_learning_app/screens/trainning/quiz/Option.dart';
import 'package:toeic_learning_app/screens/widgets/quiz/process_controller.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({
    Key? key,
    required this.quiz,
  }) : super(key: key);

  final Quiz quiz;

  

  @override
  Widget build(BuildContext context) {
    QuestionController _controller = Get.put(QuestionController());
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 169, 208, 240),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
          Text(
            quiz.question,
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          ...List.generate(
            quiz.options.length,
            (index) => Option(
              index: index,
              text: quiz.options[index],
              press: () => _controller.checkAns(quiz, index),
            ),
          ),
        ],
      ),
    );
  }
}
