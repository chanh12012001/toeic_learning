import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toeic_learning_app/config/theme.dart';
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
    _pageController = PageController(
      initialPage: pageview,
      viewportFraction: 0.8,
    );
  }

  @override
  Widget build(BuildContext context) {
    QuizProvider quizProvider = Provider.of<QuizProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
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
            flex: 3,
            child: FutureBuilder<List<Question>>(
                future: quizProvider.getQuizList(widget.exam, widget.part),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return snapshot.hasData
                      ? PageView.builder(
                          controller: widget.part == 3 ||
                                  widget.part == 4 ||
                                  widget.part == 6
                              ? _pageControllerAudio
                              : null,
                          physics: NeverScrollableScrollPhysics(),
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
                                    ? SingleChildScrollView(
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text.rich(
                                                TextSpan(
                                                  text: snapshot1
                                                              .data!.length ==
                                                          1
                                                      ? (currentPage != 0
                                                          ? 'Question ${currentPage}'
                                                          : 'Question ${snapshot1.data![index].questionNumber}')
                                                      : (currentPage != 0
                                                          ? 'Question ${questionNumber(snapshot1.data!.length, currentPage)}'
                                                          : 'Question ${questionNumber(snapshot1.data!.length, snapshot1.data![index].questionNumber!)}'),
                                                  style: TextStyle(
                                                      fontSize: 25,
                                                      color: Color.fromARGB(
                                                          255, 89, 176, 247),
                                                      fontFamily:
                                                          "San Francisco",
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontStyle:
                                                          FontStyle.italic),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              (widget.part == 4 ||
                                                      widget.part == 3)
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10,
                                                              bottom: 10),
                                                      child: AudioQuiz(
                                                          audio: snapshot1
                                                              .data![0].audio!,
                                                          end: end),
                                                    )
                                                  : Container(),
                                              widget.part == 6
                                                  ? Text(
                                                      snapshot1
                                                          .data![0].question!,
                                                      style: TextStyle(
                                                          fontSize: 30,
                                                          color: Color.fromARGB(
                                                              255, 0, 140, 255),
                                                          fontFamily:
                                                              "San Francisco",
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontStyle:
                                                              FontStyle.italic),
                                                    )
                                                  : Container(),
                                              Text(
                                                snapshot1.data![0].paragraph!,
                                                style: TextStyle(
                                                    fontSize: 25,
                                                    color: Color.fromARGB(
                                                        255, 0, 140, 255),
                                                    fontFamily: "San Francisco",
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle:
                                                        FontStyle.italic),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    : const Center(
                                        child: ColorLoader(),
                                      );
                              }),
                        )
                      : const Center(
                          child: ColorLoader(),
                        );
                }),
          ),
          Divider(
            thickness: 1.5,
            color: blueColor,
          ),
          SizedBox(
            height: 15,
          ),
          //List question
          Expanded(
            flex: 8,
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
                            if (value >= keepValuePage) {
                              valueKeep = quesionNumberGroup;
                              quesionNumberGroup =
                                  groupAdd(snapshot.data!, quesionNumberGroup);
                              currentPage = snapshot
                                  .data![quesionNumberGroup].questionNumber!;
                              keepValuePage = value;
                            } else {
                              valueKeep = quesionNumberGroup;
                              quesionNumberGroup =
                                  groupSub(snapshot.data!, quesionNumberGroup);
                              currentPage = value +
                                  snapshot.data![valueKeep - quesionNumberGroup]
                                      .questionNumber!;
                              keepValuePage = value;
                            }

                            pageview = value;
                            if (pageview == snapshot.data!.length - 1) {
                              isCompleted = true;
                            }
                            if (widget.part == 3 ||
                                widget.part == 4 ||
                                widget.part == 6) {
                              _pageControllerAudio.jumpToPage(value);
                            }
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
      a = a + (page + i).toString() + ' ';
    }
    return a;
  }
}
