import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:toeic_learning_app/models/video_model.dart';
import 'package:toeic_learning_app/providers/video_provider.dart';
import '../../../../services/toast_service.dart';
import '../widgets.dart';

class DetailVideoInfoDialog extends StatefulWidget {
  final Video? video;
  final String topicId;
  const DetailVideoInfoDialog({
    Key? key,
    this.video,
    required this.topicId,
  }) : super(key: key);

  @override
  State<DetailVideoInfoDialog> createState() => _DetailVideoInfoDialogState();
}

class _DetailVideoInfoDialogState extends State<DetailVideoInfoDialog> {
  ToastService toast = ToastService();
  bool _loading = false;
  File? file;

  final TextEditingController _videoTitleController = TextEditingController();
  final TextEditingController _videoUrlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      return Dialog(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          height: 360,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                widget.video != null ? 'Cập nhật Video' : "Thêm Video mới",
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
                icon: Icons.title,
                hintText: 'Tiêu đề bài giảng',
                onChanged: (value) {
                  if (widget.video != null) {
                    widget.video!.title = value;
                  }
                },
                controller: widget.video != null
                    ? TextEditingController(text: widget.video!.title)
                    : _videoTitleController,
              ),
              const SizedBox(
                height: 10,
              ),
              RoundedInputField(
                icon: Icons.video_call,
                hintText: 'Link bài giảng',
                onChanged: (value) {
                  if (widget.video != null) {
                    widget.video!.videoUrl = value;
                  }
                },
                controller: widget.video != null
                    ? TextEditingController(text: widget.video!.videoUrl)
                    : _videoUrlController,
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
                              Video video = Video(
                                topicId: widget.topicId,
                                title: _videoTitleController.text,
                                videoUrl: _videoUrlController.text,
                              );
                              widget.video != null
                                  ? _updateVideo(widget.video!)
                                  : _addVideo(video);
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

  _addVideo(Video video) async {
    VideoProvider videoProvider =
        Provider.of<VideoProvider>(context, listen: false);

    if (video.title == '' || video.videoUrl == '') {
      toast.showToast(
        context: context,
        message: 'Vui lòng nhập đầy đủ thông tin',
        icon: Icons.error,
        backgroundColor: Colors.redAccent,
      );
    } else {
      videoProvider.createNewVideo(video).then((value) {
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

  _updateVideo(Video video) {
    VideoProvider videoProvider =
        Provider.of<VideoProvider>(context, listen: false);
    Map<String, dynamic> params = <String, dynamic>{};
    params['id'] = video.id;
    params['title'] = video.title;
    params['videoUrl'] = video.videoUrl;
    videoProvider.updateVideo(params).then(
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
