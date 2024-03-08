abstract class AnswerTemplate {
  bool checkMyself(var input);
}

class MarkedAnswer extends AnswerTemplate {
  final String answer;
  final bool isCorrect;
  MarkedAnswer(this.answer, this.isCorrect);
  @override
  bool checkMyself(input) {
    return isCorrect == input;
  }

  MarkedAnswer.fromJson(Map<String, dynamic> json)
      : answer = json['answer'],
        isCorrect = json['isCorrect'];
}

class InputAnswer extends AnswerTemplate {
  final String answer;
  InputAnswer(this.answer);

  @override
  bool checkMyself(input) {
    return answer.toLowerCase() == input.toString().toLowerCase();
  }

  InputAnswer.fromJson(Map<String, dynamic> json) : answer = json['answer'];
}
