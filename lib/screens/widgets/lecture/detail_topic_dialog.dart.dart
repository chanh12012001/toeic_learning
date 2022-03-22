import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:toeic_learning_app/providers/topic_provider.dart';
import '../../../../services/toast_service.dart';
import '../../../models/topic.dart';
import '../widgets.dart';

class DetailTopicDialog extends StatefulWidget {
  final String? lectureTypeId;
  final Topic? topic;
  const DetailTopicDialog({
    Key? key,
    this.topic,
    this.lectureTypeId,
  }) : super(key: key);

  @override
  State<DetailTopicDialog> createState() => _DetailTopicDialogState();
}

class _DetailTopicDialogState extends State<DetailTopicDialog> {
  ToastService toast = ToastService();
  bool _loading = false;
  File? file;

  final TextEditingController _topicNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TopicProvider topicProvider = Provider.of<TopicProvider>(context);
    return StatefulBuilder(builder: (context, setState) {
      return Dialog(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          height: 430,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                widget.topic != null ? 'Cập nhật Topic' : "Thêm Topic mới",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Image.asset(
                'assets/images/pattern.png',
                height: 20,
                width: 200,
              ),
              const SizedBox(
                height: 15,
              ),
              RoundedInputField(
                icon: Icons.photo_album,
                hintText: 'Tên chủ đề bài giảng',
                onChanged: (value) {
                  if (widget.topic != null) {
                    widget.topic!.name = value;
                  }
                },
                controller: widget.topic != null
                    ? TextEditingController(text: widget.topic!.name)
                    : _topicNameController,
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  imagePicker();
                },
                child: Container(
                  color: Colors.grey[100],
                  width: 150,
                  height: 150,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: widget.topic == null
                        ? file != null
                            ? Image.file(
                                file!,
                                height: 300,
                                fit: BoxFit.fill,
                              )
                            : const Center(
                                child: Text('chọn ảnh'),
                              )
                        : file != null
                            ? Image.file(
                                file!,
                                height: 300,
                                fit: BoxFit.fill,
                              )
                            : FutureBuilder<File>(
                                future: topicProvider.convertUrlImageToFile(
                                    widget.topic!.image!),
                                builder: (context, snapshot) {
                                  file = snapshot.data;
                                  if (snapshot.hasError) {
                                    return Text("${snapshot.error}");
                                  }
                                  return snapshot.data != null
                                      ? Image.file(
                                          snapshot.data!,
                                          height: 300,
                                          fit: BoxFit.fill,
                                        )
                                      : Container();
                                },
                              ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              _loading == true
                  ? const ColorLoader()
                  : Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              widget.topic != null
                                  ? _updateTopic(widget.topic!.id,
                                      widget.topic!.name, file)
                                  : _addTopic(_topicNameController.text,
                                      widget.lectureTypeId!, file!);
                              setState(() {
                                _loading = true;
                              });
                            },
                            backgroundColor: Colors.teal[300]!,
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

  void imagePicker() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        file = File(image.path);
      });
    }
  }

  _addTopic(String name, String lecId, File file) async {
    TopicProvider topicProvider =
        Provider.of<TopicProvider>(context, listen: false);

    if (name == '') {
      toast.showToast(
        context: context,
        message: 'Vui lòng nhập tên topic',
        icon: Icons.error,
        backgroundColor: Colors.redAccent,
      );
    } else {
      topicProvider.createNewTopic(name, lecId, file).then((value) {
        Navigator.pop(context);
        toast.showToast(
          context: context,
          message: 'Thêm thành công',
          icon: Icons.error,
          backgroundColor: Colors.green,
        );
      });
    }
    setState(() {
      _loading = false;
    });
  }

  _updateTopic(id, name, File? file1) {
    TopicProvider topicProvider =
        Provider.of<TopicProvider>(context, listen: false);

    topicProvider.updateTopic(id, name, file1!).then(
      (response) {
        if (response['status']) {
          Navigator.pop(context);
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

    setState(() {
      _loading = false;
    });
  }
}
