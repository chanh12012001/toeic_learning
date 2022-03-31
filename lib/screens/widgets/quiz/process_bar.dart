import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toeic_learning_app/screens/widgets/quiz/process_controller.dart';

class ProcessBar extends StatelessWidget {
  const ProcessBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 35,
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromARGB(255, 201, 200, 200),width: 3
        ),
        borderRadius: BorderRadius.circular(50),
      ),
      child: GetBuilder<QuestionController>(
        init: QuestionController(),
        builder: (controller) {
          return Stack(
            children: [
              LayoutBuilder(builder:(context, constraints) => Container(
                width: constraints.maxWidth*controller.animation.value,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                    Color.fromARGB(255, 123, 186, 238),
                    Color.fromARGB(255, 30, 103, 230)
                  ],
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
              ) ),
              Positioned.fill(
                child: 
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Text("${(controller.animation.value * 30).round()}sec"),
                  Icon(Icons.lock_clock),
                ],),
              ))
            ],
          );
        }
      ),
    );
  }
}