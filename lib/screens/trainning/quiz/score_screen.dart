import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toeic_learning_app/screens/quiz_screen.dart';
import 'package:toeic_learning_app/screens/trainning/quiz/QuestionCard.dart';
import 'package:toeic_learning_app/screens/widgets/quiz/process_controller.dart';

class ScoreScreen extends StatelessWidget {
  const ScoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    QuestionController _qnController = Get.put(QuestionController());
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
                Text(
                  "${_qnController.numberOfCorrectAns * 10}/${_qnController.questions.length * 10}",
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 179, 176, 176),
                  ),
                ),
                Spacer(),
                InkWell(
                  onTap: () {
                    _qnController.resetQuestionNumber();
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    // _qnController.resert() ;
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
