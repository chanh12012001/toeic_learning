import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toeic_learning_app/screens/trainning/quiz/quiz_body.dart';
import 'package:toeic_learning_app/screens/widgets/quiz/process_controller.dart';

class TestQuiz extends StatefulWidget {
  static const String routeName = '/test-quiz';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const TestQuiz(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const TestQuiz({Key? key}) : super(key: key);

  @override
  State<TestQuiz> createState() => _TestQuizState();
}

class _TestQuizState extends State<TestQuiz> {
  QuestionController _controller = Get.put(QuestionController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
         ),
      body: quizBody(),
    );
  }
}
