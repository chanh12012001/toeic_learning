import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toeic_learning_app/models/quiz_model.dart';
import 'package:toeic_learning_app/providers/quiz_provider.dart';
import 'package:toeic_learning_app/screens/quiz/QuestionCard.dart';
import 'package:toeic_learning_app/screens/quiz/audioQuiz.dart';
import 'package:toeic_learning_app/screens/widgets/loader.dart';
import 'package:toeic_learning_app/screens/widgets/quiz/process_bar.dart';


class quizBody extends StatefulWidget {
  final int exam;
  final int part;
  const quizBody({
    Key? key,
    required this.exam,
    required this.part,
  }) : super(key: key);

  @override
  State<quizBody> createState() => _quizBodyState();
}

class _quizBodyState extends State<quizBody> {
  PageController _pageController = PageController();
  PageController _pageControllerAudio = PageController();
  int currentPage = 0;
  bool isCompleted = false;
  static const maxSeconds = 30;
  int seconds = maxSeconds;
  int numberofCorrectAnswer = 0;
  int countSelected = 0;
  bool end = false;
  int page = 1;
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
              end = true;
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
      body: Column(
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
         Expanded(
            flex: 2,
            child: FutureBuilder<List<Question>>(
                future: quizProvider.getQuizList(widget.exam, widget.part),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return snapshot.hasData
                      ? PageView.builder(
                          controller: _pageControllerAudio,
                          itemCount: count(snapshot.data!) == 0
                              ? snapshot.data!.length
                              : count(snapshot.data!),
                          itemBuilder: (context, index) => FutureBuilder<
                                  List<Question>>(
                              future: quizProvider.getQuizGroupList(widget.exam,
                                  snapshot.data![index].groupQuestion),
                              builder: (context, snapshot1) {
                                if (snapshot1.hasError) {
                                  return Text("${snapshot1.error}");
                                }
                                return snapshot1.hasData
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text.rich(
                                            TextSpan(
                                              text:
                                                  'Question ${countSelected}',
                                              style: TextStyle(
                                                fontSize: 25,
                                                color: Colors.white,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text:
                                                      "/${snapshot.data!.length}",
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          (widget.part == 4 || widget.part == 3)
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10, bottom: 10),
                                                  child: AudioQuiz(
                                                      audio: snapshot1
                                                          .data![0].audio!,
                                                      end: end),
                                                )
                                              : Container(),
                                          widget.part == 6
                                              ? Text(
                                                  snapshot.data![0].question!,
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white,
                                                  ),
                                                )
                                              : Container(),
                                          Text(
                                            snapshot.data![0].paragraph!,
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      )
                                    : const Center(
                                        child: ColorLoader(),
                                      );
                              }))
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
          Expanded(
            flex: 7,
            child: FutureBuilder<List<Question>>(
              future: quizProvider.getQuizList(widget.exam, widget.part),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return snapshot.hasData
                    ? PageView.builder(
                        controller: _pageController,
                        onPageChanged: (value) {
                          setState(() {
                            currentPage = value;
                            if (currentPage == snapshot.data!.length - 1) {
                              isCompleted = true;
                            }
                            _pageControllerAudio.jumpToPage(value);
                          });
                        },
                        itemCount: count(snapshot.data!) == 0
                            ? snapshot.data!.length
                            : count(snapshot.data!),
                        itemBuilder: (context, index) =>
                            FutureBuilder<List<Question>>(
                          future: quizProvider.getQuizGroupList(
                              widget.exam, snapshot.data![index].groupQuestion),
                          builder: (context, snapshot1) {
                            if (snapshot1.hasError) {
                              return Text("${snapshot1.error}");
                            }
                            return snapshot1.hasData
                                ? ListView.builder(
                                    itemCount: snapshot1.data!.length,
                                    padding: EdgeInsets.only(
                                      bottom: 10,
                                    ),
                                    itemBuilder: (context, index1) =>
                                        QuestionCard(
                                      quiz: snapshot1.data![index1],
                                      questions: snapshot1.data!,
                                      allQuestions: snapshot.data!,
                                      currentPage: currentPage,
                                      part: widget.part,
                                      number: (bool val) => setState(() {
                                        if (val) {
                                          numberofCorrectAnswer++;
                                        }
                                      }),
                                      isSelected: (bool val) => setState(() {
                                        if (val) {
                                          countSelected++;
                                        }
                                      }),
                                      countSelected: countSelected,
                                      numberOfCorrectAns: numberofCorrectAnswer,
                                    ),
                                  )
                                : const Center(
                                    child: ColorLoader(),
                                  );
                          },
                        ),
                      )
                    : const Center(
                        child: ColorLoader(),
                      );
              },
            ),
          ),
        ],
      ),
    );
  }

  int count(List<Question> question) {
    int value = 0;
    for (int i = 0; i < question.length - 1; i++) {
      if (question[i].groupQuestion == question[i + 1].groupQuestion) {
        value++;
      }
    }
    return value;
  }
}
