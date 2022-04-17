import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:toeic_learning_app/models/exam_model.dart';
import 'package:toeic_learning_app/providers/exam_provider.dart';
import 'package:toeic_learning_app/services/toast_service.dart';

import '../../../../config/theme.dart';
import '../../../../providers/loading_provider.dart';
import '../../alert_dialog.dart';
import '../../loader.dart';

class ExamsList extends StatefulWidget {
  const ExamsList({Key? key}) : super(key: key);

  @override
  State<ExamsList> createState() => _ExamsListState();
}

class _ExamsListState extends State<ExamsList> {
  ToastService toast = ToastService();

  @override
  Widget build(BuildContext context) {
    ExamProvider examProvider = Provider.of<ExamProvider>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: blackCoffeeColor),
        elevation: 0,
        backgroundColor: whiteColor,
        title: Text(
          'Exam Manage',
          style: TextStyle(color: blackColor),
        ),
      ),
      body: FutureBuilder<List<Exam>>(
        future: examProvider.getExamsList(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: ((context, index) {
                    Exam exam = snapshot.data![index];
                    return Card(
                      child: ListTile(
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_forever),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return MyAlertDialog(
                                  title: 'Warning !!!',
                                  subTitle: 'Bạn có chắc chắn muốn xoá ?',
                                  actionLeft: () {
                                    Navigator.of(context).pop();
                                  },
                                  actionRight: () {
                                    _deleteExam(exam);
                                  },
                                );
                              },
                            );
                          },
                        ),
                        title: Text(
                          "Test " + exam.exam.toString(),
                          style: GoogleFonts.roboto(
                            textStyle: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                )
              : const Center(
                  child: ColorLoader(),
                );
        },
      ),
    );
  }

  _deleteExam(Exam exam) {
    LoadingProvider loadingProvider =
        Provider.of<LoadingProvider>(context, listen: false);
    ExamProvider examProvider =
        Provider.of<ExamProvider>(context, listen: false);
    examProvider.deleteExam(exam).then(
      (response) {
        if (response['status']) {
          Navigator.pop(context);
          loadingProvider.setLoading(false);
          toast.showToast(
            context: context,
            message: response['message'],
            icon: Icons.error,
            backgroundColor: Colors.green,
          );
        } else {
          toast.showToast(
            context: context,
            message: response['message'],
            icon: Icons.error,
            backgroundColor: Colors.redAccent,
          );
        }
      },
    );
  }
}
