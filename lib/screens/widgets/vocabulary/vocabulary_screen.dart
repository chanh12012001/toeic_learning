import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toeic_learning_app/models/vocabulary_lesson_model.dart';
import 'package:toeic_learning_app/models/vocabulary_model.dart';
import 'package:toeic_learning_app/providers/vocabulary_provider.dart';
import 'package:toeic_learning_app/screens/widgets/vocabulary/flash_card/page_view.dart';
import 'package:toeic_learning_app/screens/widgets/vocabulary/vocabulary_list.dart';

import '../../../config/theme.dart';
import '../loader.dart';

class VocabularyScreen extends StatefulWidget {
  final VocabularyLesson lesson;
  const VocabularyScreen({
    Key? key,
    required this.lesson,
  }) : super(key: key);

  @override
  State<VocabularyScreen> createState() => _VocabularyScreenState();
}

class _VocabularyScreenState extends State<VocabularyScreen> {
  bool isFlashCardScreen = false;
  @override
  Widget build(BuildContext context) {
    VocabularyProvider _vocabularyProvider =
        Provider.of<VocabularyProvider>(context);
    return Scaffold(
      floatingActionButton: isFlashCardScreen
          ? Container()
          : FloatingActionButton.extended(
              onPressed: () {
                setState(() {
                  isFlashCardScreen = true;
                });
              },
              label: const Text(
                'Flashcard',
                style: TextStyle(fontSize: 16),
              ),
              icon: const Icon(Icons.flip),
              backgroundColor: Colors.pink,
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        toolbarHeight: 105,
        iconTheme: IconThemeData(color: blackCoffeeColor),
        elevation: 0,
        backgroundColor: whiteColor,
        actions: [
          isFlashCardScreen == true
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      isFlashCardScreen = false;
                    });
                  },
                  icon: const Icon(Icons.list),
                )
              : Container(),
        ],
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(widget.lesson.imageUrl!),
              maxRadius: 35,
              minRadius: 35,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.lesson.name!,
                      style: TextStyle(color: blackColor),
                      maxLines: 2,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "(" + widget.lesson.meaning! + ")",
                      style: TextStyle(color: blackCoffeeColor, fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        titleSpacing: 20,
        bottom: PreferredSize(
          child: Container(
            color: Colors.orange,
            height: 4.0,
          ),
          preferredSize: const Size.fromHeight(4.0),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 70),
        child: FutureBuilder<List<Vocabulary>>(
          future: _vocabularyProvider
              .getVocabularyList(widget.lesson.id!.toString()),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return snapshot.hasData
                ? isFlashCardScreen
                    ? PageViewVocabularyCard(vocabularies: snapshot.data!)
                    : VocabularyList(vocabularies: snapshot.data!)
                : const Center(
                    child: ColorLoader(),
                  );
          },
        ),
      ),
    );
  }
}
