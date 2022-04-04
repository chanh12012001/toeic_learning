import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toeic_learning_app/models/quiz_model.dart';
import 'package:toeic_learning_app/screens/widgets/quiz/process_controller.dart';

class Option extends StatelessWidget {
  const Option({
    Key? key,
    required this.text,
    required this.index,
    required this.press, required this.quiz,
  }) : super(key: key);
  final String text;
  final int index;
  final VoidCallback press;
  final Quiz quiz;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuestionController>(
        init: QuestionController(),
        builder: (qncontroller) {
          Color getTheRightColor() {
            if (qncontroller.isAnswered) {
              if (index == qncontroller.correctAns) {
                return Color.fromARGB(255, 4, 172, 10);
              } else if (index == qncontroller.selectedAns &&
                  qncontroller.selectedAns != qncontroller.correctAns) {
                return Color.fromARGB(255, 247, 129, 121);
              }
            }
            return Colors.white;
          }

          IconData getTheRightIcon() {
            return getTheRightColor() == Color.fromARGB(255, 150, 2, 2)
                ? Icons.close
                : Icons.done;
          }

          return InkWell(
            onTap: press,
            child: Container(
              margin: EdgeInsets.only(top: 15),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                border: Border.all(color: getTheRightColor()),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${index + 1} $text",
                        style: TextStyle(
                          color: getTheRightColor(),
                          fontSize: 16,
                        ),
                      ),
                      Container(
                        height: 26,
                        width: 26,
                        decoration: BoxDecoration(
                          color: getTheRightColor() == Colors.white
                              ? Colors.transparent
                              : getTheRightColor(),
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                            color: getTheRightColor(),
                          ),
                        ),
                        child: getTheRightColor() == Colors.white
                            ? null
                            : Icon(
                                getTheRightIcon(),
                                size: 16,
                              ),
                      ),
                    ],
                  ),getTheRightColor() == Color.fromARGB(255, 4, 172, 10) ?
                  Container(
                    padding: EdgeInsets.all(15),
                    width: MediaQuery.of(context).size.width * .5,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color.fromARGB(255, 140, 195, 240)),
                    child: Text(
                      quiz.explain,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ):Container(),
                ],
              ),
            ),
          );
        });
  }
}
