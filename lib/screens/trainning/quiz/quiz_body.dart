import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toeic_learning_app/models/quiz_model.dart';
import 'package:toeic_learning_app/screens/trainning/quiz/QuestionCard.dart';
import 'package:toeic_learning_app/screens/widgets/quiz/process_bar.dart';
import 'package:toeic_learning_app/screens/widgets/quiz/process_controller.dart';

class quizBody extends StatelessWidget {
  const quizBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    QuestionController _questionController = Get.put(QuestionController());
    return Stack(
      children: [
        SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: ProcessBar(),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Obx(
                  () => Text.rich(
                    TextSpan(
                      text: 'Question ${_questionController.questionNumber.value}',
                      style: TextStyle(
                        fontSize: 25,
                        color: Color.fromARGB(255, 109, 106, 106),
                      ),
                      children: [
                        TextSpan(
                          text: "/${_questionController.questions.length}",
                          style: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 109, 106, 106),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Divider(
                thickness: 1.5,
              ),
              SizedBox(
                height: 15,
              ),
              Expanded(
                child: PageView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  controller: _questionController.pageController,
                  onPageChanged: _questionController.updateTheQnNum,
                  itemCount: _questionController.questions.length,
                  itemBuilder: (context, index) => QuestionCard(
                    quiz: _questionController.questions[index],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
