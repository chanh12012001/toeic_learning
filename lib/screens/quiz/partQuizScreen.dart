import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toeic_learning_app/models/quiz_model.dart';
import 'package:toeic_learning_app/providers/quiz_provider.dart';
import 'package:toeic_learning_app/screens/quiz/quiz_trainning.dart';
import 'package:toeic_learning_app/screens/widgets/loader.dart';

class QuizPartScreen extends StatefulWidget {
  final int part;
  const QuizPartScreen({Key? key, required this.part}) : super(key: key);

  @override
  State<QuizPartScreen> createState() => _QuizPartScreenState();
}

class _QuizPartScreenState extends State<QuizPartScreen> {
  @override
  Widget build(BuildContext context) {
    QuizProvider quizProvider = Provider.of<QuizProvider>(context);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 207, 206, 206),
      appBar: AppBar(
        title: Text(
          'Exam',
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
          ),
        ),
      ),
      body: FutureBuilder<List<Question>>(
          future: quizProvider.getQuizPartList(widget.part),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return snapshot.hasData
                ? ListView.builder(
                    itemCount: countExam(snapshot.data!),
                    padding: EdgeInsets.all(20),
                    itemBuilder: (context, index) => FutureBuilder<
                            List<Question>>(
                        future: quizProvider.getQuizList(
                            widget.part, snapshot.data![index].examId),
                        builder: (context, snapshot1) {
                          if (snapshot1.hasError) {
                            return Text("${snapshot1.error}");
                          }
                          return snapshot1.hasData
                              ? InkWell(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute<bool>(
                                            builder: (BuildContext context) {
                                      return QuizTrainning(
                                        exam: snapshot
                                            .data![index == 0
                                                ? index
                                                : index +
                                                    nextExamIndex(
                                                        snapshot.data!, index)]
                                            .examId!,
                                        part: widget.part,
                                      );
                                    }));
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    margin: EdgeInsets.all(10),
                                    width: MediaQuery.of(context).size.width,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          "Exam ${snapshot.data![index == 0 ? index : index + nextExamIndex(snapshot.data!, index)].examId} of Part ${widget.part}",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 30,
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Questions: ",
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            Text(
                                              "${index + nextExamIndex(snapshot.data!, index)} ",
                                              style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : Container();
                        }),
                  )
                : const Center(
                    child: ColorLoader(),
                  );
          }),
    );
  }

  int countExam(List<Question> question) {
    int value = 0;
    for (int i = 0; i < question.length - 1; i++) {
      if (question[i].examId != question[i + 1].examId) {
        value++;
      }
    }
    return value + 1;
  }

  int nextExamIndex(List<Question> question, int index) {
    int value = 0;
    for (int i = index; i < question.length - 1; i++) {
      if (question[i].examId == question[i + 1].examId) {
        value++;
      } else {
        break;
      }
    }
    return value + 1;
  }
}
