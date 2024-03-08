import 'package:fiszki_app/models/answers.dart';
import 'package:fiszki_app/models/flash_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FlashCardDetails extends StatelessWidget {
  final FlashCard flashCard;

  const FlashCardDetails({super.key, required this.flashCard});
// TODO: dostosowac grida by lepiej sie skalowal
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final double itemHeight =
        (size.height - kToolbarHeight) / (flashCard.answers.length + 1);
    final double itemWidth = size.width / flashCard.answers.length;
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          _questionTile(flashCard.question),
          const Spacer(),
          (flashCard.answers.length == 1 && flashCard.answers[0] is InputAnswer)
              ? Card(
                  child: Text(
                    (flashCard.answers[0] as InputAnswer).answer,
                    softWrap: true,
                  ),
                )
              : Expanded(
                  flex: 10,
                  child: GridView.count(
                    childAspectRatio: (itemWidth / itemHeight),
                    crossAxisCount: 2,
                    padding: EdgeInsets.all(15),
                    children: flashCard.answers
                        .map(
                            (answer) => _answerPickCard(answer as MarkedAnswer))
                        .toList(),
                  ),
                ),
        ],
      ),
    );
  }

  Widget _questionTile(String question) => Card(
        child: Container(
          margin: const EdgeInsets.all(10),
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          child: Text(
            flashCard.question,
            softWrap: true,
          ),
        ),
      );

  Widget _answerPickCard(MarkedAnswer answer) => Container(
        // width: 200,
        // height: 200,
        decoration: const BoxDecoration(boxShadow: [
          BoxShadow(
              color: Colors.black54,
              blurRadius: 10,
              blurStyle: BlurStyle.normal),
        ]),
        child: Card(
          color: answer.isCorrect ? Colors.greenAccent : Colors.redAccent,
          child: Center(
            child: Text(
              answer.answer,
            ),
          ),
        ),
      );
}
