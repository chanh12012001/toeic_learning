import 'package:flutter/material.dart';

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
        margin: const EdgeInsets.only(top: 15),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          border: Border.all(color: getTheRightColor()),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width - 150,
                  child: Text(
                    "${index + 1}. $text",
                    style: TextStyle(
                      color: getTheRightColor(),
                      fontSize: 16,
                    ),
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
                  child: getTheRightColor() == Colors.white ||
                          getTheRightColor() ==
                              const Color.fromARGB(255, 205, 241, 250)
                      ? null
                      : Icon(
                          getTheRightIcon(),
                          size: 16,
                        ),
                ),
              ],
            ),
            if (getTheRightColor() == const Color.fromARGB(255, 101, 238, 106))
              Container(
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width * .5,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromARGB(255, 140, 195, 240)),
                child: Text(
                  explain,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              )
            else if (getTheRightColor() ==
                const Color.fromARGB(255, 247, 129, 121))
              Container(
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width * .5,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromARGB(255, 140, 195, 240)),
                child: Text(
                  explain,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              )
            else if (getTheRightColor() ==
                const Color.fromARGB(255, 205, 241, 250))
              Container(
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width * .5,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromARGB(255, 140, 195, 240)),
                child: Text(
                  explain,
                  style: const TextStyle(
                    fontSize: 18,
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
        return const Color.fromARGB(255, 101, 238, 106);
      } else if (index == _selectedAns && selectedAns != correctAns) {
        return const Color.fromARGB(255, 247, 129, 121);
      }
      return const Color.fromARGB(255, 205, 241, 250);
    }
    return Colors.white;
  }

  IconData getTheRightIcon() {
    return getTheRightColor() == const Color.fromARGB(255, 247, 129, 121)
        ? Icons.close
        : Icons.done;
  }
}
