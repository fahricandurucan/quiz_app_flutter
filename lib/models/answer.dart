class Answer {
  final String text;
  final bool isCorrect;
  bool? isSelected;
  bool? isJokerSelected;

  Answer({required this.text, required this.isCorrect, this.isSelected, this.isJokerSelected});
}
