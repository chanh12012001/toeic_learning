import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:toeic_learning_app/config/theme.dart';
import 'package:toeic_learning_app/models/feedback_model.dart';
import 'package:toeic_learning_app/providers/feedback_provider.dart';
import 'package:toeic_learning_app/services/toast_service.dart';

import '../../../alert_dialog.dart';
import '../../../rounded_button.dart';

class FeedbackCard extends StatefulWidget {
  final FeedbackModel feedback;
  const FeedbackCard({Key? key, required this.feedback}) : super(key: key);

  @override
  State<FeedbackCard> createState() => _FeedbackCardState();
}

class _FeedbackCardState extends State<FeedbackCard> {
  ToastService toast = ToastService();
  @override
  Widget build(BuildContext context) {
    var inputFormat = DateFormat('yyyy-MM-ddTHH:mm:ssZ', 'en-US');
    var inputDate = inputFormat
        .parse(widget.feedback.createAt.toString()); // <-- dd/MM 24H format

    var outputFormat = DateFormat('dd/MM/yyyy HH:mm');
    var createAtDate = outputFormat.format(inputDate);

    return GestureDetector(
      onTap: () {
        _showBottomSheet(context, widget.feedback);
      },
      child: Card(
          elevation: 4,
          child: Container(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.date_range, color: blueColor!),
                    const SizedBox(width: 10),
                    Text(
                      createAtDate,
                      style: TextStyle(color: blueColor),
                    ),
                    const Expanded(child: SizedBox()),
                    widget.feedback.state == true
                        ? Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              'Ghi nhận góp ý',
                              style: TextStyle(
                                color: whiteColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  widget.feedback.content!,
                  style: const TextStyle(fontSize: 16, height: 1.5),
                ),
              ],
            ),
          )),
    );
  }

  _showBottomSheet(context, FeedbackModel feedback) {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          padding: const EdgeInsets.only(top: 6, left: 20, right: 20),
          height: feedback.state == true
              ? MediaQuery.of(context).size.height * 0.24
              : MediaQuery.of(context).size.height * 0.365,
          child: Column(
            children: [
              Container(
                height: 6,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[600],
                ),
              ),
              const Spacer(),
              feedback.state == true
                  ? Container()
                  : RoundedButton(
                      text: 'Ghi nhận góp ý',
                      onPressed: () {
                        _updateStateFeedback(feedback);
                      },
                      width: 1,
                      color: Colors.indigo[800],
                    ),
              RoundedButton(
                text: 'Delete Feedback',
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return MyAlertDialog(
                        title: 'Warning !!!',
                        subTitle: 'Bạn có chắc chắn muốn xoá ?',
                        actionLeft: () {
                          Navigator.pop(context);
                        },
                        actionRight: () {
                          _deleteFeedback(feedback);
                        },
                      );
                    },
                  );
                },
                width: 1,
                color: Colors.red[300],
              ),
              RoundedButton(
                text: 'Close',
                onPressed: () {
                  Navigator.pop(context);
                },
                width: 1,
                color: Colors.grey[500],
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        );
      },
    );
  }

  _deleteFeedback(FeedbackModel feedback) {
    FeedbackProvider feedbackProvider =
        Provider.of<FeedbackProvider>(context, listen: false);

    feedbackProvider.deleteFeedback(feedback).then((response) {
      if (response['status']) {
        Navigator.pop(context);
        Navigator.pop(context);
        toast.showToast(
          context: context,
          message: 'Thao tác thành công',
          icon: Icons.check,
          backgroundColor: Colors.green,
        );
      }
    });
  }

  _updateStateFeedback(FeedbackModel feedback) async {
    FeedbackProvider feedbackProvider =
        Provider.of<FeedbackProvider>(context, listen: false);

    feedbackProvider.updateStateFeedback(feedback).then((response) {
      if (response['status']) {
        Navigator.pop(context);
        toast.showToast(
          context: context,
          message: 'Thao tác thành công',
          icon: Icons.check,
          backgroundColor: Colors.green,
        );
      }
    });
  }
}
