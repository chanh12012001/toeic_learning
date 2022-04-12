import 'package:audioplayers/audioplayers.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:toeic_learning_app/config/theme.dart';
import 'package:toeic_learning_app/models/vocabulary_model.dart';

class VocabularyFlashCard extends StatefulWidget {
  final Vocabulary vocabulary;
  const VocabularyFlashCard({
    Key? key,
    required this.vocabulary,
  }) : super(key: key);

  @override
  State<VocabularyFlashCard> createState() => _VocabularyFlashCardState();
}

class _VocabularyFlashCardState extends State<VocabularyFlashCard> {
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    audioPlayer.release();
    audioPlayer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
      child: Card(
        elevation: 0.0,
        margin: const EdgeInsets.only(
            left: 15.0, right: 15.0, top: 0.0, bottom: 0.0),
        color: const Color(0x00000000),
        child: FlipCard(
          direction: FlipDirection.HORIZONTAL,
          speed: 500,
          onFlipDone: (status) {
            if (status) {
              audioPlayer.play(widget.vocabulary.audioUrl!);
            }
          },
          front: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.blue,
                  Colors.blue[300]!,
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  widget.vocabulary.name!,
                  style: TextStyle(fontSize: 30, color: whiteColor),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  widget.vocabulary.phonetic!,
                  style: TextStyle(fontSize: 25, color: whiteColor),
                ),
              ],
            ),
          ),
          back: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.blue,
                  Colors.blue[300]!,
                ],
              ),
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: size.width / 3,
                    width: size.width / 2,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          widget.vocabulary.imageUrl!,
                        ),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        widget.vocabulary.partOfSpeech!,
                        style: TextStyle(
                          fontSize: 18,
                          decoration: TextDecoration.underline,
                          fontStyle: FontStyle.italic,
                          color: whiteColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.vocabulary.meaning!,
                    maxLines: 3,
                    style: TextStyle(
                      fontSize: 18,
                      color: whiteColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
