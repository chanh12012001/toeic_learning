import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toeic_learning_app/screens/screens.dart';
import '../config/theme.dart';
import '../models/user_model.dart';
import '../preferences/lecture_type_preference.dart';
import '../providers/auth_provider.dart';
import '../providers/lecture_type_provider.dart';
import '../providers/user_provider.dart';
import '../services/toast_service.dart';
import 'widgets/widgets.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const LoginScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  ToastService toast = ToastService();
  LectureTypePreferences lectureTypePreferences = LectureTypePreferences();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    AuthProvider auth = Provider.of<AuthProvider>(context);

    _login(phone, pass) {
      String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
      RegExp regExp = RegExp(pattern);
      if (phone == '' || pass == '') {
        toast.showToast(
          context: context,
          message: 'Vui lòng nhập đầy đủ thông tin',
          icon: Icons.error,
          backgroundColor: Colors.redAccent,
        );
      } else if (!regExp.hasMatch(phone)) {
        toast.showToast(
          context: context,
          message: 'Số điện thoại không đúng định dạng',
          icon: Icons.error,
          backgroundColor: Colors.redAccent,
        );
      } else {
        final Future<Map<String, dynamic>> successfulMessage =
            auth.login(phone, pass);

        successfulMessage.then((response) async {
          if (response['status']) {
            lectureTypePreferences
                .saveGrammarLectureId(await _getLectureTypeIdByName('grammar'));
            lectureTypePreferences.saveListeningLectureId(
                await _getLectureTypeIdByName('listening'));
            User user = response['user'];
            Provider.of<UserProvider>(context, listen: false).setUser(user);
            Navigator.pushNamedAndRemoveUntil(
                context, HomeScreen.routeName, (route) => false);
            toast.showToast(
              context: context,
              message: 'Đăng nhập thành công',
              icon: Icons.check,
              backgroundColor: Colors.green,
            );
          } else {
            toast.showToast(
              context: context,
              message: 'SĐT hoặc Mật khẩu không chính xác',
              icon: Icons.error,
              backgroundColor: Colors.redAccent,
            );
          }
        });
      }
    }

    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/images/text_logo.png',
                width: MediaQuery.of(context).size.width / 3.3,
              ),
              Image.asset(
                "assets/images/book.gif",
                height: size.height * 0.3,
              ),
              SizedBox(height: size.height * 0.03),
              RoundedInputField(
                controller: phoneController,
                hintText: "Số điện thoại",
                onChanged: (value) => {},
              ),
              RoundedPasswordField(
                controller: passwordController,
                hintText: 'Mật khẩu',
                onChanged: (value) => {},
              ),
              auth.loggedInStatus == Status.authenticating
                  ? const ColorLoader()
                  : RoundedButton(
                      width: 0.8,
                      text: "ĐĂNG NHẬP",
                      onPressed: () {
                        _login(phoneController.text, passwordController.text);
                      },
                    ),
              SizedBox(
                width: size.width * 0.8,
                height: size.width * 0.08,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, ForgotPasswordScreen.routeName);
                      },
                      child: const Text(
                        'Quên mật khẩu?',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.05),
              AlreadyHaveAnAccountCheck(
                textLeft: "Bạn chưa có tài khoản ? ",
                textRight: "Đăng kí",
                onTap: () {
                  Navigator.pushReplacementNamed(
                      context, RegisterScreen.routeName);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _getLectureTypeIdByName(name) async {
    LectureTypeProvider lectureTypeProvider =
        Provider.of<LectureTypeProvider>(context, listen: false);
    String id = await lectureTypeProvider.getIdLectureTypeByName(name);
    return id;
  }

  @override
  void dispose() {
    passwordController.dispose();
    phoneController.dispose();
    super.dispose();
  }
}
