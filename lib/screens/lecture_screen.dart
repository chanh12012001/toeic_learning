import 'package:flutter/material.dart';
import 'package:toeic_learning_app/screens/widgets/lecture/lecture_tab.dart';
import '../config/theme.dart';
import '../preferences/lecture_type_preference.dart';
import 'widgets/loader.dart';

class LectureScreen extends StatefulWidget {
  static const String routeName = '/lecture';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const LectureScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const LectureScreen({Key? key}) : super(key: key);

  @override
  State<LectureScreen> createState() => _LectureScreenState();
}

class _LectureScreenState extends State<LectureScreen> {
  dynamic file;
  @override
  Widget build(BuildContext context) {
    LectureTypePreferences lectureTypePreferences = LectureTypePreferences();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          iconTheme: IconThemeData(color: blackCoffeeColor),
          elevation: 0,
          backgroundColor: whiteColor,
          title: Text(
            'Lecture',
            style: TextStyle(color: blackColor),
          ),
          bottom: TabBar(
            padding: const EdgeInsets.only(left: 10, right: 10),
            indicator: BoxDecoration(
              color: tealColor,
              borderRadius: BorderRadius.circular(25.0),
            ),
            overlayColor: MaterialStateProperty.all(whiteColor),
            labelColor: Colors.white,
            unselectedLabelColor: Colors.black,
            tabs: const [
              Tab(icon: Icon(Icons.photo_album), text: 'Grammar'),
              Tab(icon: Icon(Icons.headphones), text: 'Listening'),
            ],
          ),
          titleSpacing: 20,
        ),
        body: TabBarView(
          children: [
            FutureBuilder<String>(
              future: lectureTypePreferences.getGrammarLectureId(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return snapshot.hasData
                    ? LectureTab(lectureTypeId: snapshot.data!)
                    : const Center(
                        child: ColorLoader(),
                      );
              },
            ),
            FutureBuilder<String>(
              future: lectureTypePreferences.getListeningLectureId(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return snapshot.hasData
                    ? LectureTab(lectureTypeId: snapshot.data!)
                    : const Center(
                        child: ColorLoader(),
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}
