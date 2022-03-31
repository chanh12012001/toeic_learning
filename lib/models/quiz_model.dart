class Quiz {
  final int id, answer;
  final String question;
  final List<String> options;

  Quiz({required this.id, required this.question, required this.answer, required this.options});
  static const List sample_data = [
    {
      "id": 1,
      "question": "A_ple",
      "options": ['p', 'c', 'd', 'e'],
      "answer_index": 1,
    },
    {
      "id": 2,
      "question": "A_ple",
      "options": ['p', 'c', 'd', 'e'],
      "answer_index": 1,
    },
    {
      "id": 3,
      "question": "Appl_",
      "options": ['p', 'c', 'd', 'e'],
      "answer_index": 3,
    },
     {
      "id": 4,
      "question": "A_ple",
      "options": ['p', 'c', 'd', 'e'],
      "answer_index": 1,
    },
    {
      "id": 5,
      "question": "A_ple",
      "options": ['p', 'c', 'd', 'e'],
      "answer_index": 0,
    },
    {
      "id": 6,
      "question": "Appl_",
      "options": ['p', 'c', 'd', 'e'],
      "answer_index": 3,
    },
  ];
}
