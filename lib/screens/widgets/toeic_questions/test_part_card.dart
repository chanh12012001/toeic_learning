import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:toeic_learning_app/config/theme.dart';
import 'package:toeic_learning_app/models/exam_model.dart';
import 'package:toeic_learning_app/models/quiz_model.dart';
import 'package:toeic_learning_app/models/score_model.dart';
import 'package:toeic_learning_app/models/toeic_part_model.dart';
import 'package:toeic_learning_app/models/user_model.dart';
import 'package:toeic_learning_app/providers/quiz_provider.dart';
import 'package:toeic_learning_app/providers/score_provider.dart';
import 'package:toeic_learning_app/screens/widgets/toeic_questions/quiz/quiz_body.dart';

class TestPartCard extends StatefulWidget {
  final ToeicPart part;
  final Exam exam;
  final User? user;
  const TestPartCard({
    Key? key,
    required this.part,
    required this.exam,
    this.user,
  }) : super(key: key);

  @override
  State<TestPartCard> createState() => _TestPartCardState();
}

class _TestPartCardState extends State<TestPartCard> {
  @override
  Widget build(BuildContext context) {
    ScoreProvider scoreProvider = Provider.of<ScoreProvider>(context);
    QuizProvider quizProvider = Provider.of<QuizProvider>(context);
    return FutureBuilder<List<ScoreModel>>(
        future: scoreProvider.getScoreList(widget.exam.exam, widget.part.part),
        builder: (context, snapshot1) {
          if (snapshot1.hasError) {
            return Text("${snapshot1.error}");
          }
          return snapshot1.hasData
              ? FutureBuilder<List<Question>>(
                  future: quizProvider.getQuizList(
                      widget.exam.exam, widget.part.part),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return snapshot.hasData
                        ? GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute<void>(
                                builder: (BuildContext context) {
                                  return QuizBody(
                                    exam: widget.exam,
                                    part: widget.part,
                                    quizList: snapshot.data!,
                                    user: widget.user!,
                                  );
                                },
                              ));
                            },
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          widget.part.title! +
                                              " " +
                                              widget.exam.exam.toString(),
                                          style: GoogleFonts.roboto(
                                            textStyle: const TextStyle(
                                              fontSize: 17.0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            const Icon(Icons.score_rounded),
                                            Text(
                                              " High score: ",
                                              style: GoogleFonts.roboto(
                                                textStyle: const TextStyle(
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.w300,
                                                ),
                                              ),
                                            ),
                                            Text(snapshot1.data!.isNotEmpty ?
                                              '${snapshot1.data![0].scoreRecord}' : '0',
                                              style: GoogleFonts.roboto(
                                                textStyle: TextStyle(
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.w500,
                                                  color: tealColor,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              " / ${snapshot.data!.length}",
                                              style: GoogleFonts.roboto(
                                                textStyle: const TextStyle(
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          snapshot.data!.length.toString(),
                                          style: GoogleFonts.roboto(
                                            textStyle: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.w500,
                                              color: tealColor,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          ' questions',
                                          style: GoogleFonts.roboto(
                                            textStyle: const TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: tealColor,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: const Text('ETS 2020'),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : Container();
                  },
                )
              : Container();
        });
  }
}
