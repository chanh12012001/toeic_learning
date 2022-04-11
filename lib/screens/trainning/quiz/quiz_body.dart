import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toeic_learning_app/models/quiz_model.dart';
import 'package:toeic_learning_app/providers/quiz_provider.dart';
import 'package:toeic_learning_app/screens/trainning/quiz/QuestionCard.dart';
import 'package:toeic_learning_app/screens/widgets/quiz/process_bar.dart';

import '../../widgets/loader.dart';

class quizBody extends StatefulWidget {
  final int exam;
  final int part;
  const quizBody({
    Key? key, required this.exam, required this.part,
  }) : super(key: key);

  @override
  State<quizBody> createState() => _quizBodyState();
}

class _quizBodyState extends State<quizBody> {
  PageController _pageController = PageController();
  int currentPage = 0;
  bool isCompleted = false;
  static const maxSeconds = 30;
  int seconds = maxSeconds;
  int numberofCorrectAnswer = 0;
  @override
  void initState() {
    _pageController = PageController(
      initialPage: currentPage,
      viewportFraction: 0.8,
    );
  }

  @override
  Widget build(BuildContext context) {
    QuizProvider quizProvider = Provider.of<QuizProvider>(context);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 111, 190, 255),
      appBar: AppBar(
        //action when click done
        actions: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 10, top: 10),
              child: Text(
                "Done",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                //show process bar
                child: FutureBuilder<List<Question>>(
                    future: quizProvider.getQuizList(widget.exam, widget.part),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      return snapshot.hasData
                          ? ProcessBar(
                              question: snapshot.data!,
                              isCompleted: isCompleted,
                            )
                          : const Center(
                              child: ColorLoader(),
                            );
                    }),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                //show numbers of quiz
                child: FutureBuilder<List<Question>>(
                    future: quizProvider.getQuizList(widget.exam, widget.part),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      return snapshot.hasData
                          ? Text.rich(
                              TextSpan(
                                text: 'Question ${currentPage + 1}',
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                ),
                                children: [
                                  TextSpan(
                                    text: "/${snapshot.data!.length}",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : const Center(
                              child: ColorLoader(),
                            );
                    }),
              ),
              Divider(
                thickness: 1.5,
              ),
              SizedBox(
                height: 15,
              ),
              //List question
              FutureBuilder<List<Question>>(
                future: quizProvider.getQuizList(widget.exam, widget.part),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return snapshot.hasData
                      ? Expanded(
                          child: PageView.builder(
                            controller: _pageController,
                            onPageChanged: (value) {
                              setState(() {
                                currentPage = value;
                                if (currentPage == snapshot.data!.length - 1) {
                                  isCompleted = true;
                                }
                              });
                            },
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) => QuestionCard(
                              quiz: snapshot.data![index],
                              questions: snapshot.data!,
                              currentPage: currentPage,
                              part: widget.part,
                              number: (bool val) => setState(() {
                                if (val) {
                                  numberofCorrectAnswer++;
                                }
                              }),
                              numberOfCorrectAns: numberofCorrectAnswer,
                            ),
                          ),
                        )
                      : const Center(
                          child: ColorLoader(),
                        );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
