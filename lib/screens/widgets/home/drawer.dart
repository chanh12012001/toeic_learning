import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:toeic_learning_app/config/theme.dart';
import 'package:toeic_learning_app/models/user_model.dart';
import 'package:toeic_learning_app/preferences/notification_preference.dart';
import 'package:toeic_learning_app/preferences/user_preference.dart';
import 'package:toeic_learning_app/screens/widgets/alert_dialog.dart';
import 'package:toeic_learning_app/screens/widgets/home/drawer/feedback/add_feedback_dialog.dart';
import 'package:toeic_learning_app/screens/widgets/home/drawer/feedback/feedback_list.dart';
import 'package:toeic_learning_app/screens/widgets/home/drawer/profile.dart';
import 'package:toeic_learning_app/screens/widgets/home/drawer/terms_of_use.dart';
import 'package:toeic_learning_app/screens/widgets/widgets.dart';

import '../../../config/defaults.dart';
import '../../../preferences/lecture_type_preference.dart';
import '../../../providers/loading_provider.dart';
import '../../login_screen.dart';
import 'drawer/push_notification_dialog.dart';

var indexClicked = 0;

class DrawerScreen extends StatefulWidget {
  final User user;
  const DrawerScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<DrawerScreen> createState() => _DrawerState();
}

class _DrawerState extends State<DrawerScreen> {
  Function updateState(int index, Function action) {
    return () {
      setState(() {
        indexClicked = index;
      });
      action();
      // Navigator.pop(context);
    };
  }

  @override
  Widget build(BuildContext context) {
    LectureTypePreferences lectureTypePreferences = LectureTypePreferences();
    StateNotificationPreferences notificationPreferences =
        StateNotificationPreferences();
    UserPreferences userPreferences = UserPreferences();

    LoadingProvider loadingProvider = Provider.of<LoadingProvider>(context);
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipPath(
            clipper: WaveClipperTwo(flip: true),
            child: SizedBox(
              height: MediaQuery.of(context).size.width / 1.7,
              child: DrawerHeader(
                decoration: const BoxDecoration(
                  color: Color(0xFF23408E),
                ),
                padding: const EdgeInsets.all(0),
                child: FutureBuilder<User>(
                    future: userPreferences.getUser(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      return snapshot.hasData
                          ? Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute<void>(
                                        builder: (BuildContext context) {
                                          return Profile(user: snapshot.data!);
                                        },
                                      )).then((value) => setState(() {}));
                                    },
                                    child: CircleAvatar(
                                      radius: 42,
                                      backgroundImage: snapshot
                                                  .data!.avatarUrl !=
                                              ""
                                          ? NetworkImage(
                                              snapshot.data!.avatarUrl!)
                                          : const AssetImage(
                                                  'assets/images/lecture.png')
                                              as ImageProvider,
                                    )),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  snapshot.data!.name!,
                                  style: GoogleFonts.sanchez(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  snapshot.data!.email!,
                                  style: GoogleFonts.sanchez(
                                    fontSize: 13,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            )
                          : const Center(
                              child: ColorLoader(),
                            );
                    }),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(top: 10),
              children: [
                // AppDrawerTile(
                //   index: 0,
                //   backgroundColor: redColor!,
                //   onTap: updateState(0, () {}),
                // ),
                // nhắc nhở
                AppDrawerTile(
                  index: 0,
                  backgroundColor: redColor!,
                  onTap: updateState(1, () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return const PushNotificationDialog();
                      },
                    );
                  }),
                ),
                //góp ý
                AppDrawerTile(
                  index: 1,
                  backgroundColor: kGreen,
                  onTap: updateState(2, () {
                    widget.user.authorization == 'admin'
                        ? Navigator.push(context, MaterialPageRoute<void>(
                            builder: (BuildContext context) {
                              return const FeedbackList();
                            },
                          ))
                        : showDialog(
                            context: context,
                            builder: (context) {
                              return AddFeedbackDialog(user: widget.user);
                            },
                          );
                  }),
                ),
                AppDrawerTile(
                  index: 2,
                  backgroundColor: kIndigo,
                  onTap: updateState(3, () {}),
                ),
                // share
                AppDrawerTile(
                  index: 3,
                  backgroundColor: kPink,
                  onTap: updateState(4, () {
                    Share.share(
                        'https://www.facebook.com/groups/1446400445645839/?hoisted_section_header_type=recently_seen&multi_permalinks=3295949470690918');
                  }),
                ),
                //Điều khoản sử dụng
                AppDrawerTile(
                  index: 4,
                  backgroundColor: kPurple,
                  onTap: updateState(5, () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(
                      builder: (BuildContext context) {
                        return TermsOfUseScreen(user: widget.user);
                      },
                    ));
                  }),
                ),
                // Đăng xuất
                AppDrawerTile(
                  index: 5,
                  backgroundColor: kYellow,
                  onTap: updateState(6, () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return MyAlertDialog(
                          title: 'Warning !!!',
                          subTitle: 'Thoát khỏi ứng dụng?',
                          actionLeft: () {
                            Navigator.pop(context);
                          },
                          actionRight: () {
                            lectureTypePreferences.removeLecture();
                            notificationPreferences.removeStateNotification();
                            userPreferences.removeUser();
                            Navigator.pushReplacementNamed(
                                context, LoginScreen.routeName);
                          },
                        );
                      },
                    );
                    loadingProvider.setLoading(false);
                  }),
                ),
                const SizedBox(
                  height: 30,
                ),
                const AppDrawerDivider(),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    'Toeic Learning',
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: Defaults.drawerItemSelectedColor,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Center(
                  child: Text(
                    'Version 1.2.5',
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic,
                      fontSize: 12,
                      color: Defaults.drawerItemColor,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const AppDrawerDivider(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AppDrawerTile extends StatelessWidget {
  const AppDrawerTile({
    Key? key,
    required this.index,
    required this.onTap,
    required this.backgroundColor,
  }) : super(key: key);

  final int index;
  final Color backgroundColor;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onTap();
      },
      selected: indexClicked == index,
      selectedTileColor: Defaults.drawerSelectedTileColor,
      leading: Container(
        width: 45,
        height: 45,
        // padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: backgroundColor,
        ),
        child: Icon(
          Defaults.drawerItemIcon[index],
          size: 25,
          color: whiteColor,
        ),
      ),
      title: Text(
        Defaults.drawerItemText[index],
        style: GoogleFonts.roboto(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: indexClicked == index
              ? Defaults.drawerItemSelectedColor
              : blackCoffeeColor,
        ),
      ),
    );
  }
}

class AppDrawerDivider extends StatelessWidget {
  const AppDrawerDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 1,
      thickness: 1,
      color: Defaults.drawerItemColor,
      indent: 3,
      endIndent: 3,
    );
  }
}
