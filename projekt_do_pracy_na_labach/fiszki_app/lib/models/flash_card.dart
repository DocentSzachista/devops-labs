import 'package:fiszki_app/models/answers.dart';

class FlashCard {
  final String question;
  final List<AnswerTemplate> answers;

  FlashCard(this.question, this.answers);

  FlashCard.fromJson(Map<String, dynamic> json)
      : question = json['question'],
        answers = List.from(List<Map<String, dynamic>>.from(json['answers'])
            .map<AnswerTemplate>((json) {
          if (json.containsKey("isCorrect")) {
            return MarkedAnswer.fromJson(json);
          } else {
            return InputAnswer.fromJson(json);
          }
        }));
}
