import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:toeic_learning_app/preferences/notification_preference.dart';
import 'package:toeic_learning_app/screens/screens.dart';

import '../../../../config/theme.dart';
import '../../../../services/notification_service.dart';
import '../../input_field.dart';

class PushNotificationDialog extends StatefulWidget {
  const PushNotificationDialog({Key? key}) : super(key: key);

  @override
  State<PushNotificationDialog> createState() => _PushNotificationDialogState();
}

class _PushNotificationDialogState extends State<PushNotificationDialog> {
  String _startTime = DateFormat('HH:mm').format(DateTime.now()).toString();
  NotificationService notifyService = NotificationService();
  StateNotificationPreferences notificationPreferences =
      StateNotificationPreferences();
  bool? state;

  @override
  void initState() {
    super.initState();
    notifyService.initializeNotification(selectNotification);
    notifyService.requestIOSPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      return Dialog(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          height: 170,
          child: Column(
            children: [
              FutureBuilder<String>(
                future: notificationPreferences.getNotificationTime(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return snapshot.hasData
                      ? InputField(
                          onChanged: (value) {
                            setState(() {
                              snapshot.data!;
                            });
                          },
                          title: 'Thời gian',
                          hint: snapshot.data!,
                          widget: IconButton(
                            onPressed: () {
                              setState(() {
                                _getTimeFromUser();
                              });
                            },
                            icon: const Icon(
                              Icons.access_time_rounded,
                              color: Colors.grey,
                            ),
                          ),
                        )
                      : InputField(
                          title: 'Thời gian',
                          hint: _startTime,
                          widget: IconButton(
                            onPressed: () {
                              // _getTimeFromUser();
                            },
                            icon: const Icon(
                              Icons.access_time_rounded,
                              color: Colors.grey,
                            ),
                          ),
                        );
                },
              ),
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Bật/Tắt',
                      style: titleStyle,
                    ),
                    SizedBox(
                      width: 50,
                      height: 70,
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: FutureBuilder<bool>(
                          future:
                              notificationPreferences.getStateNotification(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Text("${snapshot.error}");
                            }
                            return snapshot.hasData
                                ? Switch(
                                    value: snapshot.data!,
                                    onChanged: (value) {
                                      setState(() {
                                        notificationPreferences
                                            .saveStateNotification(value);
                                        state = !(snapshot.data!);
                                      });

                                      if (value) {
                                        _noticationBody();
                                      } else {
                                        notifyService.cancelAllNotification();
                                      }
                                    },
                                  )
                                : Switch(
                                    value: false,
                                    onChanged: (value) {},
                                  );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  _getTimeFromUser() async {
    var pickedTime = await _showTimePicker();
    if (pickedTime == null) {
      debugPrint('Time cancel');
    } else {
      DateTime tempDate = DateFormat("HH:mm").parse(
          pickedTime.hour.toString() + ":" + pickedTime.minute.toString());
      var dateFormat = DateFormat("HH:mm"); // you can change the format here
      String _formatedDate = dateFormat.format(tempDate);

      setState(() {
        _startTime = _formatedDate;
      });
      if (state == true) {
        _noticationBody();
      }
      notificationPreferences.saveNotificationTime(_startTime);
    }
  }

  _noticationBody() {
    var inputFormat = DateFormat('HH:mm');
    var inputDate = inputFormat.parse(_startTime);
    var myTime = DateFormat("HH:mm").format(inputDate);
    notifyService.scheduledNotification(
      int.parse(myTime.toString().split(":")[0]),
      int.parse(myTime.toString().split(":")[1]),
      "Học cùng Toeic Learning",
      'Luyện tập 30 phút mỗi ngày để nâng cao số điểm bạn nhé. Vào App ngay!',
    );
  }

  Future<TimeOfDay?> _showTimePicker() {
    return showTimePicker(
      builder: (context, childWidget) {
        return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: childWidget!);
      },
      context: context,
      initialTime: TimeOfDay(
        hour: int.parse(_startTime.split(":")[0]),
        minute: int.parse(_startTime.split(":")[1].split(" ")[0]),
      ),
    );
  }

  selectNotification(String? payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    } else {
      debugPrint('Notification Done');
    }
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const HomeScreen();
    }));
  }
}
