import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../providers/loading_provider.dart';
import 'loader.dart';

class MyAlertDialog extends StatelessWidget {
  final String title;
  final String subTitle;
  final Function action;
  const MyAlertDialog({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoadingProvider loadingProvider =
        Provider.of<LoadingProvider>(context, listen: false);
    return StatefulBuilder(
      builder: (context, setState) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: [
              SizedBox(
                height: 230,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 75, 20, 10),
                  child: Column(
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        subTitle,
                        style: GoogleFonts.lato(
                          textStyle: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      loadingProvider.loading == true
                          ? const ColorLoader()
                          : Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  _buildButton(
                                    text: 'Huỷ bỏ',
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    backgroundColor: Colors.grey,
                                  ),
                                  _buildButton(
                                    text: 'OK',
                                    onPressed: () {
                                      action();
                                      setState(() {
                                        loadingProvider.setLoading(true);
                                      });
                                    },
                                    backgroundColor: Colors.teal[300]!,
                                  ),
                                ],
                              ),
                            )
                    ],
                  ),
                ),
              ),
              const Positioned(
                  top: -60,
                  child: CircleAvatar(
                    backgroundColor: Colors.redAccent,
                    radius: 60,
                    child: Icon(
                      Icons.assistant_photo,
                      color: Colors.white,
                      size: 45,
                    ),
                  )),
            ],
          ),
        );
      },
    );
  }

  _buildButton(
      {required String text,
      required Function onPressed,
      required Color backgroundColor}) {
    return ConstrainedBox(
      constraints: const BoxConstraints.tightFor(width: 100, height: 40),
      child: ElevatedButton(
        child: Text(
          text,
          style: GoogleFonts.lato(
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        onPressed: () {
          onPressed();
        },
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsets>(
              const EdgeInsets.fromLTRB(20, 3, 20, 3)),
          backgroundColor: MaterialStateProperty.all(backgroundColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
      ),
    );
  }
}
