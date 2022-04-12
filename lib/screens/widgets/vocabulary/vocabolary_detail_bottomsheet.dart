import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:toeic_learning_app/models/vocabulary_model.dart';

import '../../../config/theme.dart';

class VocabularyDetailBotttomSheet extends StatefulWidget {
  final Vocabulary vocabulary;
  const VocabularyDetailBotttomSheet({
    Key? key,
    required this.vocabulary,
  }) : super(key: key);

  @override
  State<VocabularyDetailBotttomSheet> createState() =>
      _VocabularyDetailBotttomSheetState();
}

class _VocabularyDetailBotttomSheetState
    extends State<VocabularyDetailBotttomSheet> {
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  void dispose() {
    super.dispose();
    audioPlayer.release();
    audioPlayer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => Navigator.pop(context),
      child: GestureDetector(
        onTap: () {},
        child: DraggableScrollableSheet(
          initialChildSize: 0.5,
          minChildSize: 0.3,
          maxChildSize: 0.8,
          builder: (_, controller) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.amberAccent,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    height: 50,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: ListView(
                        shrinkWrap: true,
                        controller: controller,
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  audioPlayer.play(widget.vocabulary.audioUrl!);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: blueColor!,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Icon(
                                      Icons.volume_down,
                                      color: blueColor,
                                      size: 25,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.vocabulary.name!,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20,
                                      color: Colors.green[700],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    widget.vocabulary.phonetic!,
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
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
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Definition: " + widget.vocabulary.definition!,
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            widget.vocabulary.partOfSpeech!,
                            style: const TextStyle(
                              fontSize: 18,
                              decoration: TextDecoration.underline,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            widget.vocabulary.meaning!,
                            style: TextStyle(
                              fontSize: 18,
                              color: blueColor!,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const Text(
                            "Example",
                            style: TextStyle(
                                fontSize: 18,
                                fontStyle: FontStyle.italic,
                                color: Colors.grey),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            widget.vocabulary.examples!.example!,
                            style: TextStyle(
                              fontSize: 18,
                              color: blackColor!,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            widget.vocabulary.examples!.meaning!,
                            style: TextStyle(
                              fontSize: 18,
                              color: blackColor!,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
