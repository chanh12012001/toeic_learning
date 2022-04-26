import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toeic_learning_app/providers/blog_provider.dart';
import 'package:toeic_learning_app/providers/exam_provider.dart';
import 'package:toeic_learning_app/providers/feedback_provider.dart';
import 'package:toeic_learning_app/providers/quiz_provider.dart';
import 'package:toeic_learning_app/providers/terms_of_use_provider.dart';
import 'package:toeic_learning_app/providers/video_provider.dart';
import 'package:toeic_learning_app/providers/vocabulary_lesson_provider.dart';
import 'package:toeic_learning_app/providers/vocabulary_provider.dart';
import 'package:toeic_learning_app/screens/screens.dart';
import 'config/app_router.dart';
import 'config/theme.dart';
import 'providers/auth_provider.dart';
import 'providers/lecture_type_provider.dart';
import 'providers/loading_provider.dart';
import 'providers/topic_provider.dart';
import 'providers/user_provider.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoadingProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => TopicProvider()),
        ChangeNotifierProvider(create: (_) => LectureTypeProvider()),
        ChangeNotifierProvider(create: (_) => VocabularyLessonProvider()),
        ChangeNotifierProvider(create: (_) => VideoProvider()),
        ChangeNotifierProvider(create: (_) => VocabularyProvider()),
        ChangeNotifierProvider(create: (_) => QuizProvider()),
        ChangeNotifierProvider(create: (_) => ExamProvider()),
        ChangeNotifierProvider(create: (_) => BlogProvider()),
        ChangeNotifierProvider(create: (_) => TermsOfUseProvider()),
        ChangeNotifierProvider(create: (_) => FeedbackProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Personal Notebook',
        theme: theme(),
        routes: {BlogScreen.routeName: (context) => const BlogScreen()},
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: SplashScreen.routeName,
      ),
    );
  }
}
