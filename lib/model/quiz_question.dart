class QuizQuestion {
  const QuizQuestion(this.text, this.answers);

  final String text;
  final List<dynamic> answers;

  List get ShuffledAnswer {
    final shuffledList = List.of(answers);
    shuffledList.shuffle();
    return shuffledList;
  }
}
