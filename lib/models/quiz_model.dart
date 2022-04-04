class Quiz {
  final int id, answer;
  final String question;
  final List<String> options;
  final String explain;

  Quiz(
      {required this.id,
      required this.question,
      required this.answer,
      required this.options,
      required this.explain,
      });
  static const List sample_data = [
    {
      "id": 1,
      "question": "A_ple",
      "options": ['p', 'c', 'd', 'e'],
      "answer_index": 1,
      "explain":"Because ......"
    },
    {
      "id": 2,
      "question": "A_ple",
      "options": ['p', 'c', 'd', 'e'],
      "answer_index": 1,
      "explain":"Because ......"
    },
    {
      "id": 3,
      "question": "Appl_",
      "options": ['p', 'c', 'd', 'e'],
      "answer_index": 3,
      "explain":"Because ......"
    },
    {
      "id": 4,
      "question": "A_ple",
      "options": ['p', 'c', 'd', 'e'],
      "answer_index": 1,
      "explain":"Because ......"
    },
    {
      "id": 5,
      "question": "A_ple",
      "options": ['p', 'c', 'd', 'e'],
      "answer_index": 0,
      "explain":"Because ......"
    },
    {
      "id": 6,
      "question": "Appl_",
      "options": ['p', 'c', 'd', 'e'],
      "answer_index": 3,
      "explain":"Because ......"
    },
  ];
}
