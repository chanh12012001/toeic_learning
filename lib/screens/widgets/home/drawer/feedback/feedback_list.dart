import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toeic_learning_app/models/feedback_model.dart';
import 'package:toeic_learning_app/providers/feedback_provider.dart';

import '../../../../../config/theme.dart';
import '../../../loader.dart';
import 'feedback_card.dart';

class FeedbackList extends StatefulWidget {
  const FeedbackList({Key? key}) : super(key: key);

  @override
  State<FeedbackList> createState() => _FeedbackListState();
}

class _FeedbackListState extends State<FeedbackList> {
  @override
  Widget build(BuildContext context) {
    FeedbackProvider feedbackProvider = Provider.of<FeedbackProvider>(context);
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: blackCoffeeColor),
        elevation: 0,
        backgroundColor: whiteColor,
        title: Text(
          'Feedback List',
          style: TextStyle(color: blackColor),
        ),
      ),
      body: FutureBuilder<List<FeedbackModel>>(
        future: feedbackProvider.getFeedbacksList(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return FeedbackCard(feedback: snapshot.data![index]);
                  },
                )
              : const Center(
                  child: ColorLoader(),
                );
        },
      ),
    );
  }
}
