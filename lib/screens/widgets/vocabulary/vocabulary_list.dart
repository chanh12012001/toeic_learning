import 'package:flutter/material.dart';
import 'package:toeic_learning_app/models/vocabulary_model.dart';
import 'package:toeic_learning_app/screens/widgets/vocabulary/vocabolary_detail_bottomsheet.dart';
import 'vocabulary_card.dart';

class VocabularyList extends StatefulWidget {
  final List<Vocabulary> vocabularies;
  const VocabularyList({
    Key? key,
    required this.vocabularies,
  }) : super(key: key);

  @override
  State<VocabularyList> createState() => _VocabularyListState();
}

class _VocabularyListState extends State<VocabularyList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.vocabularies.length,
      itemBuilder: (context, index) {
        Vocabulary vocabulary = widget.vocabularies[index];
        return GestureDetector(
          onTap: () {
            showModalBottomSheet(
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              context: context,
              builder: (context) =>
                  VocabularyDetailBotttomSheet(vocabulary: vocabulary),
            );
          },
          child: VocabularyCard(
            vocabulary: vocabulary,
          ),
        );
      },
    );
  }
}
