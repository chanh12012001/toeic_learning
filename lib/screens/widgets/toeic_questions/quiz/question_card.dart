import 'package:flutter/material.dart';
import 'package:toeic_learning_app/models/quiz_model.dart';

import 'audio_quiz.dart';
import 'option.dart';
import 'score_screen.dart';

class QuestionCard extends StatefulWidget {
  final List<Question> questions;
  final List<Question> allQuestions;
  final int currentPage;
  final Function(bool value) number;
  final int numberOfCorrectAns;
  final Function(bool value) isSelected;
  final int countSelected;
  final int part;
  const QuestionCard({
    Key? key,
    required this.quiz,
    required this.questions,
    required this.currentPage,
    required this.number,
    required this.numberOfCorrectAns,
    required this.part,
    required this.allQuestions,
    required this.isSelected,
    required this.countSelected,
  }) : super(key: key);

  final Question quiz;

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard>
    with AutomaticKeepAliveClientMixin {
  String? selectedAns;
  bool end = false;

  @override
  bool get wantKeepAlive => true;

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    List<String> options = [
      widget.quiz.option1!,
      widget.quiz.option2!,
      widget.quiz.option3!,
      widget.quiz.option4!
    ];
    List<String> explains = [
      widget.quiz.explain1!,
      widget.quiz.explain2!,
      widget.quiz.explain3!,
      widget.quiz.explain4!
    ];
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 25, 143, 158),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
          widget.part == 1
              ? Image.network(
                  "${widget.quiz.image}",
                  fit: BoxFit.cover,
                )
              : Container(),
          const SizedBox(
            height: 15,
          ),
          (widget.part == 1 || widget.part == 2)
              ? AudioQuiz(
                  audio: widget.quiz.audio!,
                  end: end,
                )
              : Container(),
          widget.part == 2
              ? const SizedBox(
                  height: 15,
                )
              : Container(),
          widget.part != 6
              ? Text(
                  widget.quiz.question!,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                )
              : Container(),

          selectedAns != null
              ? Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 88, 173, 243),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Text(
                    widget.quiz.explainQuestion!,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                )
              : Container(),

          //show list answer and check
          ...List.generate(
            options.length,
            (index) => options[index] != ''
                ? Option(
                    selectedAns: selectedAns,
                    correctAns: widget.quiz.correctAnswer!,
                    index: index,
                    text: options[index],
                    press: selectedAns == null
                        ? () {
                            setState(() {
                              checkAns(widget.quiz, index);
                              widget.number(
                                  widget.quiz.correctAnswer == selectedAns);
                              widget.isSelected(true);
                            });
                          }
                        : () {},
                    explain: explains[index],
                  )
                : Container(),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  void checkAns(Question quiz, int selectedIndex) {
    switch (selectedIndex) {
      case 0:
        selectedAns = "A";
        break;
      case 1:
        selectedAns = "B";
        break;
      case 2:
        selectedAns = "C";
        break;
      case 3:
        selectedAns = "D";
        break;
    }
    if (widget.countSelected == widget.allQuestions.length - 1) {
      quizEnd();
    }
  }

  Future quizEnd() => showDialog(
        context: context,
        builder: (context) => Dialog(
          insetPadding: const EdgeInsets.all(20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Choose your choice',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Spacer(),
                    ElevatedButton(
                      child: const Text('Show my score'),
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(5),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () {
                        setState(() {
                          end = true;
                        });
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute<bool>(
                              builder: (BuildContext context) {
                            return ScoreScreen(
                              numberOfCorrectAns: widget.numberOfCorrectAns,
                              questions: widget.allQuestions,
                            );
                          }),
                        );
                      },
                    ),
                    const Spacer(),
                    ElevatedButton(
                      child: const Text('Show my answers'),
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(5),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    const Spacer(),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
}
