import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:toeic_learning_app/config/theme.dart';
import 'package:toeic_learning_app/models/vocabulary_model.dart';

class VocabularyCard extends StatefulWidget {
  final Vocabulary vocabulary;
  const VocabularyCard({Key? key, required this.vocabulary}) : super(key: key);

  @override
  State<VocabularyCard> createState() => _VocabularyCardState();
}

class _VocabularyCardState extends State<VocabularyCard> {
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  void dispose() {
    super.dispose();
    audioPlayer.release();
    audioPlayer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        backgroundColor: Colors.redAccent,
        child: Icon(
          Icons.wordpress,
          color: Colors.white,
        ),
      ),
      title: Text(
        widget.vocabulary.name!,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 20,
          color: Colors.green[700],
        ),
      ),
      subtitle: Container(
        margin: const EdgeInsets.only(top: 7),
        child: Text(
          "(" +
              widget.vocabulary.partOfSpeech! +
              ") " +
              widget.vocabulary.meaning!,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(color: blackColor, fontSize: 18),
        ),
      ),
      trailing: GestureDetector(
        onTap: () {
          audioPlayer.play(widget.vocabulary.audioUrl!);
        },
        child: Icon(
          Icons.volume_up,
          color: blackColor,
          size: 28,
        ),
      ),
    );
  }
}
