import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toeic_learning_app/config/theme.dart';
import 'package:toeic_learning_app/models/user_model.dart';
import 'package:toeic_learning_app/providers/feedback_provider.dart';
import 'package:toeic_learning_app/services/toast_service.dart';

class AddFeedbackDialog extends StatefulWidget {
  final User user;
  const AddFeedbackDialog({Key? key, required this.user}) : super(key: key);

  @override
  State<AddFeedbackDialog> createState() => _AddFeedbackDialogState();
}

class _AddFeedbackDialogState extends State<AddFeedbackDialog> {
  ToastService toast = ToastService();
  final TextEditingController _contentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      return Dialog(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          height: 300,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                const Text(
                  'Please take few minutes to give us your feedback',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _contentController,
                  minLines:
                      6, // any number you need (It works as the rows for the textarea)
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: greyColor!, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: greyColor!, width: 1.0),
                    ),
                    hintText: 'Nhập nội dung',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    _addFeedback(_contentController.text, widget.user.userId);
                  },
                  child: Container(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 10),
                    decoration: BoxDecoration(
                      color: blueColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      'Gửi',
                      style: TextStyle(
                        color: whiteColor,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  _addFeedback(content, userId) async {
    FeedbackProvider feedbackProvider =
        Provider.of<FeedbackProvider>(context, listen: false);

    if (content == '') {
      Navigator.pop(context);
    } else {
      feedbackProvider.createNewFeedback(content, userId).then((value) {
        Navigator.pop(context);
        toast.showToast(
          context: context,
          message: 'Cảm ơn đã phản hồi',
          icon: Icons.error,
          backgroundColor: Colors.green,
        );
      });
    }
  }
}
