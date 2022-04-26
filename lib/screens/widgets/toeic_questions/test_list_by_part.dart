import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toeic_learning_app/models/exam_model.dart';
import 'package:toeic_learning_app/models/toeic_part_model.dart';
import 'package:toeic_learning_app/providers/exam_provider.dart';
import 'package:toeic_learning_app/screens/widgets/loader.dart';

import '../../../config/theme.dart';
import 'test_part_card.dart';

class TestListByPart extends StatefulWidget {
  final ToeicPart part;
  const TestListByPart({
    Key? key,
    required this.part,
  }) : super(key: key);

  @override
  State<TestListByPart> createState() => _TestListByPartState();
}

class _TestListByPartState extends State<TestListByPart> {
  @override
  Widget build(BuildContext context) {
    ExamProvider examProvider = Provider.of<ExamProvider>(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: blackCoffeeColor),
        elevation: 0,
        backgroundColor: whiteColor,
        centerTitle: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Part ${widget.part.part}',
                style: TextStyle(color: blackColor),
                textAlign: TextAlign.start),
            Text(
              widget.part.title!,
              style: TextStyle(
                color: blueColor,
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.start,
            ),
          ],
        ),
      ),
      body: FutureBuilder<List<Exam>>(
        future: examProvider.getExamsList(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: ((context, index) {
                    Exam exam = snapshot.data![index];
                    return TestPartCard(
                      part: widget.part,
                      exam: exam,
                    );
                  }),
                )
              : const Center(
                  child: ColorLoader(),
                );
        },
      ),
    );
  }
}
