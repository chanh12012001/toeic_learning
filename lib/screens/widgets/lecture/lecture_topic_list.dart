import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';

import '../../../models/topic.dart';
import '../../../providers/topic_provider.dart';
import 'video_trainning.dart';
import 'lecture_topic_card.dart';

class LectureList extends StatefulWidget {
  final String? authorization;

  final String lectureTypeId;
  final List<Topic> topics;

  const LectureList({
    Key? key,
    required this.topics,
    required this.lectureTypeId,
    this.authorization,
  }) : super(key: key);

  @override
  State<LectureList> createState() => _LectureListState();
}

class _LectureListState extends State<LectureList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TopicProvider>(
      builder: ((context, topicProvider, child) {
        var topics = topicProvider.getTopics;
        return Padding(
          padding: const EdgeInsets.only(top: 25),
          child: ListView.builder(
            itemCount: topics.length,
            itemBuilder: (context, index) {
              Topic topic = topics[index];
              return AnimationConfiguration.staggeredList(
                position: index,
                child: SlideAnimation(
                  child: FadeInAnimation(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VideoTrainning(
                              topic: topic,
                            ),
                          ),
                        );
                      },
                      child: LectureTopicCard(
                        topic: topic,
                        authorization: widget.authorization!,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
