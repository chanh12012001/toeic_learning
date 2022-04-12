import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioQuiz extends StatefulWidget {
  final String audio;
  final bool end;
  const AudioQuiz({Key? key, required this.audio, required this.end})
      : super(key: key);

  @override
  State<AudioQuiz> createState() => _AudioQuizState();
}

class _AudioQuizState extends State<AudioQuiz> {
  AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  String currentTime = "00:00";
  String completeTime = "00:00";

  @override
  void initState() {
        super.initState();
    _audioPlayer.onAudioPositionChanged.listen((Duration duration) {
      setState(() {
        currentTime = duration.toString().split('.').first.padLeft(8, "0");
      });
    });
    _audioPlayer.onDurationChanged.listen((Duration duration) {
      setState(() {
        completeTime = duration.toString().split('.').first.padLeft(8, "0");
      });
    });
    if (widget.end) {
      setState(() {
        _audioPlayer.stop();
      });
    }
  }

  @override
  void dispose() {
    _audioPlayer.stop();
    _isPlaying = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 60,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(50)),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () async {
              if (_isPlaying == false) {
                if (currentTime == "00:00") {
                  _audioPlayer.play(widget.audio, isLocal: true);
                  setState(() {
                    _isPlaying = true;
                  });
                } else {
                  _audioPlayer.resume();
                  setState(() {
                    _isPlaying = true;
                  });
                }
              } else {
                _audioPlayer.pause();
                setState(() {
                  _isPlaying = false;
                });
              }
            },
            icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
          ),
          SizedBox(
            width: 16,
          ),
          IconButton(
            onPressed: () {
              _audioPlayer.stop();
              setState(() {
                _isPlaying = false;
                currentTime = "00:00";
              });
            },
            icon: Icon(Icons.stop),
          ),
          Text(
            currentTime,
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          Text("|"),
          Text(
            completeTime,
            style: TextStyle(fontWeight: FontWeight.w300),
          ),
        ],
      ),
    );
  }
}
