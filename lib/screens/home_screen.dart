import 'package:flutter/material.dart';
import 'package:toeic_learning_app/screens/QA_screen.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:provider/provider.dart';
import 'package:toeic_learning_app/config/theme.dart';
import 'package:toeic_learning_app/screens/dictionary_screen.dart';
import 'package:toeic_learning_app/screens/quiz_screen.dart';
import 'package:toeic_learning_app/screens/widgets/blog/blog_list.dart';
import 'package:toeic_learning_app/screens/widgets/home/drawer.dart';
import 'package:toeic_learning_app/screens/widgets/loader.dart';
import '../models/blog_model.dart';
import '../models/user_model.dart';
import '../providers/blog_provider.dart';
import 'screens.dart';
import 'widgets/home/category_card.dart';
import 'widgets/home/custom_list_tile.dart';

class HomeScreen extends StatelessWidget {
  // static const String routeName = '/home';

  // static Route route() {
  //   return MaterialPageRoute(
  //     builder: (_) => const HomeScreen(),
  //     settings: const RouteSettings(name: routeName),
  //   );
  // }

  final User? user;

  const HomeScreen({
    Key? key,
    this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    BlogProvider blogProvider = Provider.of<BlogProvider>(context);
    return Scaffold(
      drawer: Drawer(
        child: DrawerScreen(user: user!),
      ),
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              ClipPath(
                clipper: OvalBottomBorderClipper(),
                child: Container(
                  width: double.infinity,
                  height: size.width / 1.5,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 40, 42, 130),
                    image: DecorationImage(
                      image: AssetImage("assets/images/banner.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppBar(
                        backgroundColor:
                            const Color.fromARGB(31, 53, 63, 6).withOpacity(.0),
                        elevation: 0,
                      ),
                      // const Spacer(),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            width: 70,
                            decoration: BoxDecoration(
                                color: whiteColor,
                                borderRadius: BorderRadius.circular(10)),
                            // color: Colors.amberAccent,
                            child: const Text(
                              'Tham gia ngay!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15.0),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 25.0),
              const CustomListTile(
                title: "Nguồn học",
                isViewAll: false,
              ),
              const SizedBox(height: 25.0),
              SizedBox(
                width: double.infinity,
                height: size.width / 3.2,
                child: GridView.custom(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                  ),
                  childrenDelegate: SliverChildListDelegate(
                    [
                      CategoryCard(
                        title: 'Lecture',
                        backgroundColor: kPurple,
                        iconUrl: 'assets/images/lecture.png',
                        action: () {
                          Navigator.pushNamed(context, LectureScreen.routeName);
                        },
                      ),
                      CategoryCard(
                        title: 'Vocabulary',
                        backgroundColor: kGreen,
                        iconUrl: 'assets/images/vocabulary.png',
                        action: () {
                          Navigator.pushNamed(
                              context, VocabularyLessonScreen.routeName);
                        },
                      ),
                      CategoryCard(
                        title: 'Practice',
                        backgroundColor: kYellow,
                        iconUrl: 'assets/images/practice.png',
                        action: () {
                          Navigator.push(
                          context,
                          MaterialPageRoute<bool>(
                              builder: (BuildContext context) {
                            return QuizScreen(
                              user: user!,
                            );
                          }),
                        );
                        },
                      ),
                      CategoryCard(
                        title: 'Translate',
                        backgroundColor: kPink,
                        iconUrl: 'assets/images/translate.png',
                        action: () {
                          Navigator.pushNamed(
                              context, DictionaryScreen.routeName);
                        },
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15.0),
              CustomListTile(
                title: "Blogs",
                action: () {
                  Navigator.pushNamed(
                    context,
                    BlogScreen.routeName,
                    arguments: {'auth': '${user!.authorization}'},
                  );
                },
              ),
              const SizedBox(height: 15.0),
              FutureBuilder<List<Blog>>(
                future: blogProvider.getBlogsList(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return snapshot.hasData
                      ? BlogList(
                          blogs: snapshot.data!,
                          lengthListView: 4,
                        )
                      : const Center(
                          child: ColorLoader(),
                        );
                },
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    BlogScreen.routeName,
                    arguments: {'auth': '${user!.authorization}'},
                  );
                },
                child: Card(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      'XEM THÊM',
                      style: TextStyle(
                        color: greyColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
