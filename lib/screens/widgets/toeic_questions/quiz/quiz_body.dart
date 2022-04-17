import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toeic_learning_app/config/theme.dart';
import 'package:toeic_learning_app/models/exam_model.dart';
import 'package:toeic_learning_app/models/quiz_model.dart';
import 'package:toeic_learning_app/models/toeic_part_model.dart';
import 'package:toeic_learning_app/providers/quiz_provider.dart';
import 'package:toeic_learning_app/screens/widgets/loader.dart';

import '../process_bar.dart';
import 'audio_quiz.dart';
import 'question_card.dart';

class QuizBody extends StatefulWidget {
  final Exam exam;
  final ToeicPart part;
  final List<Question> quizList;
  const QuizBody({
    Key? key,
    required this.exam,
    required this.part,
    required this.quizList,
  }) : super(key: key);

  @override
  State<QuizBody> createState() => _QuizBodyState();
}

class _QuizBodyState extends State<QuizBody> {
  PageController _pageController = PageController();
  PageController _pageControllerAudio = PageController();
  int currentPage = 0;
  int pageview = 0;
  bool isCompleted = false;
  static const maxSeconds = 30;
  int seconds = maxSeconds;
  int numberofCorrectAnswer = 0;
  int countSelected = 0;
  bool end = false;
  int page = 1;
  int quesionNumberGroup = 0;
  int valueKeep = 0;
  int keepValuePage = 0;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(
      initialPage: pageview,
      viewportFraction: 0.95,
    );
    _pageControllerAudio = PageController(
      initialPage: pageview,
      viewportFraction: 0.95,
    );
  }

  @override
  Widget build(BuildContext context) {
    QuizProvider quizProvider = Provider.of<QuizProvider>(context);
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        iconTheme: IconThemeData(color: blackCoffeeColor),
        elevation: 0,
        backgroundColor: whiteColor,
        centerTitle: false,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.part.title! + " " + widget.exam.exam.toString(),
              style: TextStyle(color: blackColor),
              textAlign: TextAlign.start,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 150,
                  height: 20,
                  child: PageView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.quizList.isEmpty
                        ? widget.quizList.length
                        : widget.quizList.length,
                    itemBuilder: (context, index) =>
                        FutureBuilder<List<Question>>(
                      future: quizProvider.getQuizGroupList(widget.exam.exam,
                          widget.quizList[index].groupQuestion),
                      builder: (context, snapshot1) {
                        if (snapshot1.hasError) {
                          return Text("${snapshot1.error}");
                        }
                        return snapshot1.hasData
                            ? Text(
                                snapshot1.data!.length == 1
                                    ? (currentPage != 0
                                        ? 'Question $currentPage'
                                        : 'Question ${snapshot1.data![index].questionNumber}')
                                    : (currentPage != 0
                                        ? 'Question ${questionNumber(snapshot1.data!.length, currentPage)}'
                                        : 'Question ${questionNumber(snapshot1.data!.length, snapshot1.data![index].questionNumber!)}'),
                                style: TextStyle(
                                  fontSize: 15,
                                  color: tealColor,
                                  fontFamily: "San Francisco",
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            : const Text('...');
                      },
                    ),
                  ),
                ),
                ProcessBar(
                  question: widget.quizList,
                  isCompleted: isCompleted,
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: _getFlexExpandedByPart(widget.part.part),
            child: PageView.builder(
              controller: widget.part.part == 3 ||
                      widget.part.part == 4 ||
                      widget.part.part == 6
                  ? _pageControllerAudio
                  : null,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: count(widget.quizList) == 0
                  ? widget.quizList.length
                  : count(widget.quizList),
              itemBuilder: (context, index) => FutureBuilder<List<Question>>(
                future: quizProvider.getQuizGroupList(
                    widget.exam.exam, widget.quizList[index].groupQuestion),
                builder: (context, snapshot1) {
                  if (snapshot1.hasError) {
                    return Text("${snapshot1.error}");
                  }
                  return snapshot1.hasData
                      ? SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                widget.part.part == 6
                                    ? Text(
                                        snapshot1.data![0].question!,
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: blackCoffeeColor,
                                          fontFamily: "San Francisco",
                                          fontWeight: FontWeight.w400,
                                        ),
                                      )
                                    : const Text(''),
                                Text(
                                  snapshot1.data![0].paragraph!,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: blackCoffeeColor,
                                    fontFamily: "San Francisco",
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                widget.part.part == 4 || widget.part.part == 3
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                          top: 15,
                                          left: 10,
                                          bottom: 10,
                                        ),
                                        child: AudioQuiz(
                                          audio: snapshot1.data![0].audio!,
                                          end: end,
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                        )
                      : Container();
                },
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          //List question
          Expanded(
            flex: 12,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (value) {
                setState(() {
                  if (value >= keepValuePage) {
                    valueKeep = quesionNumberGroup;
                    quesionNumberGroup =
                        groupAdd(widget.quizList, quesionNumberGroup);
                    currentPage =
                        widget.quizList[quesionNumberGroup].questionNumber!;
                    keepValuePage = value;
                  } else {
                    valueKeep = quesionNumberGroup;
                    quesionNumberGroup =
                        groupSub(widget.quizList, quesionNumberGroup);
                    currentPage = value +
                        widget.quizList[valueKeep - quesionNumberGroup]
                            .questionNumber!;
                    keepValuePage = value;
                  }

                  pageview = value;
                  if (countSelected == widget.quizList.length - 1) {
                    isCompleted = true;
                  }
                  if (widget.part.part == 3 ||
                      widget.part.part == 4 ||
                      widget.part.part == 6) {
                    _pageControllerAudio.jumpToPage(value);
                  }
                });
              },
              itemCount: count(widget.quizList) == 0
                  ? widget.quizList.length
                  : count(widget.quizList),
              itemBuilder: (context, index) => FutureBuilder<List<Question>>(
                future: quizProvider.getQuizGroupList(
                    widget.exam.exam, widget.quizList[index].groupQuestion),
                builder: (context, snapshot1) {
                  if (snapshot1.hasError) {
                    return Text("${snapshot1.error}");
                  }
                  return snapshot1.hasData
                      ? ListView.builder(
                          itemCount: snapshot1.data!.length,
                          addAutomaticKeepAlives: true,
                          padding: const EdgeInsets.only(
                            bottom: 10,
                          ),
                          itemBuilder: (context, index1) => QuestionCard(
                            quiz: snapshot1.data![index1],
                            questions: snapshot1.data!,
                            allQuestions: widget.quizList,
                            currentPage: currentPage,
                            part: widget.part.part!,
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
            ),
          ),
        ],
      ),
    );
  }

  _getFlexExpandedByPart(part) {
    switch (part) {
      case 1:
      case 2:
      case 5:
        return 1;
      case 3:
      case 4:
        return 3;
      default:
        return 4;
    }
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

  int groupAdd(List<Question> question, int valueBegin) {
    int value = 0;
    for (int i = valueBegin; i < question.length - 1; i++) {
      if (question[i].groupQuestion == question[i + 1].groupQuestion) {
        value++;
      } else {
        break;
      }
    }
    return value + 1;
  }

  int groupSub(List<Question> question, int valueBegin) {
    int value = 0;
    for (int i = valueBegin - 1; i > 0; i--) {
      if (question[i].groupQuestion == question[i - 1].groupQuestion) {
        value++;
      } else {
        break;
      }
    }
    return value + 1;
  }

  String questionNumber(int dataLength, int page) {
    String a = '';
    for (int i = 0; i < dataLength; i++) {
      a = a + (page + i).toString() + '-';
    }
    return a.substring(0, a.length - 1);
  }
}
