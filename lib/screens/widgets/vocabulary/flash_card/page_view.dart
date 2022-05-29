import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toeic_learning_app/config/theme.dart';
import 'package:toeic_learning_app/models/vocabulary_model.dart';
import '../../../../providers/loading_provider.dart';
import '../../alert_dialog.dart';
import 'vocabulary_flash_card.dart';

class PageViewVocabularyCard extends StatefulWidget {
  final List<Vocabulary> vocabularies;
  const PageViewVocabularyCard({
    Key? key,
    required this.vocabularies,
  }) : super(key: key);

  @override
  State<PageViewVocabularyCard> createState() => _PageViewVocabularyCardState();
}

class _PageViewVocabularyCardState extends State<PageViewVocabularyCard> {
  late PageController _pageController = PageController();
  int _currentPage = 0;
  static const _kDuration = Duration(milliseconds: 300);
  static const _kCurve = Curves.ease;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: _currentPage,
      viewportFraction: 0.8,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  late List<Vocabulary> vocabularyList = List.from(widget.vocabularies);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    LoadingProvider loadingProvider = Provider.of<LoadingProvider>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size.width / 4,
          height: 50,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.grey,
          ),
          child: Center(
            child: Text(
              '${_currentPage + 1}/${vocabularyList.length}',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 22,
                color: whiteColor,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 50,
        ),
        SizedBox(
          height: size.width / 1.3,
          child: PageView.builder(
            itemCount: vocabularyList.length,
            controller: _pageController,
            onPageChanged: (value) {
              setState(() {
                _currentPage = value;
              });
            },
            itemBuilder: (context, index) {
              return AnimatedBuilder(
                animation: _pageController,
                builder: (context, child) {
                  double value = 0.0;
                  if (_pageController.position.haveDimensions) {
                    value = index.toDouble() - (_pageController.page ?? 0);
                    value = (value * 0.038).clamp(-1, 1);
                  }
                  return Transform.rotate(
                    angle: pi * value,
                    child: VocabularyFlashCard(
                      vocabulary: vocabularyList[index],
                    ),
                  );
                },
              );
            },
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Text(
          'Do you remember?',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 25,
            color: Colors.blue[900],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Ink(
              decoration: const ShapeDecoration(
                color: Colors.red,
                shape: CircleBorder(),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: IconButton(
                  icon: Icon(
                    Icons.close,
                    color: whiteColor,
                  ),
                  iconSize: 40,
                  onPressed: () {
                    _pageController.nextPage(
                        duration: _kDuration, curve: _kCurve);
                  },
                ),
              ),
            ),
            Ink(
              decoration: const ShapeDecoration(
                color: Colors.green,
                shape: CircleBorder(),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: IconButton(
                  icon: Icon(
                    Icons.check,
                    color: whiteColor,
                  ),
                  iconSize: 40,
                  onPressed: () {
                    debugPrint(_currentPage.toString());
                    if (_currentPage >= 0) {
                      if (_currentPage == vocabularyList.length - 1) {
                        vocabularyList.remove(vocabularyList[_currentPage]);

                        setState(() {
                          _currentPage = _currentPage - 1;
                        });
                      } else {
                        setState(() {
                          vocabularyList.remove(vocabularyList[_currentPage]);
                        });
                      }
                    }
                    if (vocabularyList.isEmpty) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return MyAlertDialog(
                            title: 'Chúc mừng bạn đã hoàn thành bài học !!!',
                            actionLeft: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            actionRight: () {
                              setState(() {
                                vocabularyList = List.from(widget.vocabularies);
                                _currentPage = 0;
                                loadingProvider.setLoading(false);
                              });

                              Navigator.pop(context);
                            },
                            icon: Icons.check,
                            backgroundColorIcon: Colors.green,
                            textButtonRight: "Học lại",
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
