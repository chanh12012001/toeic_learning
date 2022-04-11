import 'package:flutter/material.dart';
import 'package:toeic_learning_app/models/quiz_model.dart';

class Option extends StatelessWidget {
  const Option({
    Key? key,
    required this.text,
    required this.index,
    required this.press,
    required this.explain,
    this.selectedAns,
    required this.correctAns,
  }) : super(key: key);
  final String text;
  final int index;
  final VoidCallback press;
  final String explain;
  final String? selectedAns;
  final String correctAns;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Container(
        margin: EdgeInsets.only(top: 15),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          border: Border.all(color: getTheRightColor()),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${index + 1}. $text",
                  style: TextStyle(
                    color: getTheRightColor(),
                    fontSize: 16,
                  ),
                ),
                Container(
                  height: 26,
                  width: 26,
                  decoration: BoxDecoration(
                    color: getTheRightColor() == Colors.white
                        ? Colors.transparent
                        : getTheRightColor(),
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: getTheRightColor(),
                    ),
                  ),
                  child: getTheRightColor() == Colors.white || getTheRightColor() == Color.fromARGB(255, 5, 99, 177)
                      ? null
                      : Icon(
                          getTheRightIcon(),
                          size: 16,
                        ),
                ),
              ],
            ),
            if (getTheRightColor() == Color.fromARGB(255, 4, 172, 10))
              Container(
                padding: EdgeInsets.all(15),
                width: MediaQuery.of(context).size.width * .5,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromARGB(255, 140, 195, 240)),
                child: Text(
                  explain,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              )
            else if (getTheRightColor() == Color.fromARGB(255, 247, 129, 121))
              Container(
                padding: EdgeInsets.all(15),
                width: MediaQuery.of(context).size.width * .5,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromARGB(255, 140, 195, 240)),
                child: Text(
                  explain,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              )
            else if (getTheRightColor() == Color.fromARGB(255, 5, 99, 177))
              Container(
                padding: EdgeInsets.all(15),
                width: MediaQuery.of(context).size.width * .5,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromARGB(255, 140, 195, 240)),
                child: Text(
                  explain,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              )
            else
              Container(),
          ],
        ),
      ),
    );
  }

  Color getTheRightColor() {
    int _correctAns = -1;
    switch (correctAns) {
      case 'A':
        _correctAns = 0;
        break;
      case 'B':
        _correctAns = 1;
        break;
      case 'C':
        _correctAns = 2;
        break;
      case 'D':
        _correctAns = 3;
        break;
    }
    int _selectedAns = -1;
    switch (selectedAns) {
      case 'A':
        _selectedAns = 0;
        break;
      case 'B':
        _selectedAns = 1;
        break;
      case 'C':
        _selectedAns = 2;
        break;
      case 'D':
        _selectedAns = 3;
        break;
    }
    if (selectedAns != null) {
      if (index == _correctAns) {
        return Color.fromARGB(255, 4, 172, 10);
      } else if (index == _selectedAns && selectedAns != correctAns) {
        return Color.fromARGB(255, 247, 129, 121);
      }
      return Color.fromARGB(255, 5, 99, 177);
    }
    return Colors.white;
  }

  IconData getTheRightIcon() {
    return getTheRightColor() == Color.fromARGB(255, 247, 129, 121)
        ? Icons.close
        : Icons.done;
  }
}
