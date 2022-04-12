import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:toeic_learning_app/screens/widgets/vocabulary/vocabulary_screen.dart';
import '../../../models/vocabulary_lesson_model.dart';
import 'lesson_card.dart';

class LessonsList extends StatefulWidget {
  final List<VocabularyLesson> lessons;
  const LessonsList({
    Key? key,
    required this.lessons,
  }) : super(key: key);

  @override
  State<LessonsList> createState() => _LessonsListState();
}

class _LessonsListState extends State<LessonsList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          itemCount: widget.lessons.length,
          itemBuilder: (context, index) {
            VocabularyLesson lesson = widget.lessons[index];
            return AnimationConfiguration.staggeredList(
              position: index,
              child: SlideAnimation(
                child: FadeInAnimation(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              VocabularyScreen(lesson: lesson),
                        ),
                      );
                    },
                    child: LessonCard(
                      lesson: lesson,
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
