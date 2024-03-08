import 'package:fiszki_app/backend_communication/api_communication.dart';
import 'package:fiszki_app/backend_communication/api_mocks.dart';
import 'package:fiszki_app/models/flash_card.dart';
import 'package:fiszki_app/models/collection.dart';
import 'package:fiszki_app/views/flash_card_details.dart';
import 'package:flutter/material.dart';

class FlashCards extends StatefulWidget {
  final Collection collection;
  const FlashCards({super.key, required this.collection});

  @override
  State<FlashCards> createState() => _FlashCardsState();
}

class _FlashCardsState extends State<FlashCards> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.collection.title} collection"),
      ),
      body: Center(
        child: FutureBuilder(
          future: getFlashCardsFromCollection(widget.collection),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return const Text("No flashcards found");
              } else {
                final List<FlashCard> flashCards = snapshot.data!;
                return ListView.builder(
                  itemCount: flashCards.length,
                  itemBuilder: (context, index) => Card(
                    child: InkWell(
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Text(flashCards[index].question,
                            style: Theme.of(context).textTheme.headlineSmall),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                FlashCardDetails(flashCard: flashCards[index]),
                          ),
                        );
                      },
                    ),
                  ),
                );
              }
            } else if (snapshot.hasError) {
              return Text("Unexpected error occured. ${snapshot.error}");
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
