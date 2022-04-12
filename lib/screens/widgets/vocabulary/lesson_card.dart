import 'package:flutter/material.dart';
import 'package:toeic_learning_app/models/vocabulary_lesson_model.dart';

class LessonCard extends StatelessWidget {
  final VocabularyLesson lesson;
  const LessonCard({
    Key? key,
    required this.lesson,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                lesson.imageUrl!,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 105,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(0.6),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  SizedBox(
                    width: size.width / 2.7,
                    child: Text(
                      lesson.name!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    width: size.width / 2.7,
                    child: const Text(
                      "12 word",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
