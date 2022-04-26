import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toeic_learning_app/models/qa_model.dart';
import 'package:toeic_learning_app/providers/qa_provider.dart';
import 'package:toeic_learning_app/screens/widgets/QA/question_qa.dart';
import 'package:toeic_learning_app/screens/widgets/loader.dart';

class QAScreen extends StatefulWidget {
  const QAScreen({Key? key}) : super(key: key);
  static const String routeName = '/QA-screen';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const QAScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  @override
  State<QAScreen> createState() => _QAScreenState();
}

class _QAScreenState extends State<QAScreen> {
  bool isVisible = false;
  bool isChecked = false;
  String valueFilterSelected = "";
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    QAProvider qaProvider = Provider.of<QAProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 58, 122, 182),
        elevation: 0,
      ),
      body: FutureBuilder<List<QA>>(
          future: valueFilterSelected == ""
              ? qaProvider.getAllQuestionList()
              : qaProvider.getAllQuestionByKeyWord(valueFilterSelected),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return snapshot.hasData
                ? Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 120,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 58, 122, 182),
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(70))),
                        child: Column(
                          children: [
                            Text(
                              'Q & A',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: "San Francisco",
                                fontSize: 50,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Row(
                            children: [
                              Container(
                                width: 100,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 58, 122, 182),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    filterQuestion(snapshot.data!);
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Spacer(),
                                      Icon(
                                        Icons.filter_alt,
                                        color: Colors.white,
                                      ),
                                      Spacer(),
                                      Text(
                                        'Filter',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "San Francisco",
                                          fontSize: 20,
                                        ),
                                      ),
                                      Spacer(),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.4,
                              ),
                              valueFilterSelected != ''
                                  ? Container(
                                      width: 120,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Color.fromARGB(255, 58, 122, 182)
                                            .withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            valueFilterSelected = '';
                                          });
                                        },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Spacer(),
                                            Text(
                                              valueFilterSelected,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: "San Francisco",
                                                fontSize: 21,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Spacer(),
                                            Icon(
                                              Icons.clear,
                                              color: Colors.black,
                                            ),
                                            Spacer(),
                                          ],
                                        ),
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                          child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) => QuestionQA(
                          qa: snapshot.data![index],
                        ),
                      )),
                    ],
                  )
                : const Center(child: ColorLoader());
          }),
    );
  }

  Future filterQuestion(List<QA> qa) {
    return showDialog(
        context: context,
        builder: (context) => Dialog(
            insetPadding: const EdgeInsets.all(30),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: ListView.builder(
              itemCount: count(qa) == 0 ? 1 : count(qa),
              shrinkWrap: true,
              itemBuilder: (context, index) => CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                value: isChecked,
                onChanged: (value) {
                  setState(() {
                    isChecked = value!;
                    Navigator.pop(context);
                    isChecked = false;
                    valueFilterSelected = nextKeyword(qa)[index];
                  });
                },
                title: Text(nextKeyword(qa)[index]),
              ),
            )));
  }
}

int count(List<QA> qa) {
  List<String> filterValue = [];
  filterValue.add(qa[0].keyword!);
  for (int i = 1; i < qa.length; i++) {
    int value = 0;
    for (int j = 0; j < filterValue.length; j++) {
      if (filterValue[j] == qa[i].keyword) {
        value++;
      }
    }
    if (value == 0) {
      filterValue.add(qa[i].keyword!);
    }
  }
  return filterValue.length;
}

List nextKeyword(List<QA> qa) {
  List<String> filterValue = [];
  filterValue.add(qa[0].keyword!);
  for (int i = 1; i < qa.length; i++) {
    int value = 0;
    for (int j = 0; j < filterValue.length; j++) {
      if (filterValue[j] == qa[i].keyword) {
        value++;
      }
    }
    if (value == 0) {
      filterValue.add(qa[i].keyword!);
    }
  }
  return filterValue;
}
