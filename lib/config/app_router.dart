import 'package:flutter/material.dart';
import 'package:toeic_learning_app/screens/dictionary_screen.dart';
import 'package:toeic_learning_app/screens/quiz_screen.dart';
import 'package:toeic_learning_app/screens/widgets/lecture/video_trainning.dart';
import '../screens/screens.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SplashScreen.routeName:
        return SplashScreen.route();
      case HomeScreen.routeName:
        return HomeScreen.route();
      case LoginScreen.routeName:
        return LoginScreen.route();
      case RegisterScreen.routeName:
        return RegisterScreen.route();
      case OtpVerificationScreen.routeName:
        return OtpVerificationScreen.route();
      case InputPasswordScreen.routeName:
        return InputPasswordScreen.route();
      case ForgotPasswordScreen.routeName:
        return ForgotPasswordScreen.route();
      case LectureScreen.routeName:
        return LectureScreen.route();
      case VocabularyLessonScreen.routeName:
        return VocabularyLessonScreen.route();
      case QuizScreen.routeName:
        return QuizScreen.route();
      case DictionaryScreen.routeName:
        return DictionaryScreen.route();
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('error')),
      ),
      settings: const RouteSettings(name: '/error'),
    );
  }
}
