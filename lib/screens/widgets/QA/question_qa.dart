import 'package:flutter/material.dart';
import 'package:toeic_learning_app/models/qa_model.dart';

class QuestionQA extends StatefulWidget {
  final QA qa;
  const QuestionQA({Key? key, required this.qa}) : super(key: key);

  @override
  State<QuestionQA> createState() => _QuestionQAState();
}

class _QuestionQAState extends State<QuestionQA> {
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color.fromARGB(255, 58, 122, 182).withOpacity(0.4),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Text(
                  widget.qa.question!,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "San Francisco",
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    isVisible = !isVisible;
                  });
                },
                child: Icon(
                  !isVisible ? Icons.arrow_downward : Icons.arrow_upward,
                  size: 25,
                ),
              ),
            ],
          ),
        ),
        Visibility(
          visible: isVisible,
          child: Container(
            margin: EdgeInsets.only(left: 25, right: 25, top: 0),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              color: Color.fromARGB(255, 58, 122, 182).withOpacity(0.2),
            ),
            child: Text(
              widget.qa.answer!,
              style: TextStyle(
                color: Colors.black,
                fontFamily: "San Francisco",
                fontSize: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
