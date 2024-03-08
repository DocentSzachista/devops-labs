import 'package:fiszki_app/models/answers.dart';
import 'package:fiszki_app/models/flash_card.dart';
import 'package:fiszki_app/models/collection.dart';

final List<Collection> collections = [
  Collection(id: "21321", isPublic: false, title: "Example"),
  Collection(
      id: "1231412", isPublic: true, title: "English", tags: ["Private life"]),
  Collection(
      id: "1241515", isPublic: false, title: "SO2", tags: ["PWR", "devops"])
];

final List<FlashCard> flashCards = [
  FlashCard("How much it is", [
    MarkedAnswer("3.5", true),
    MarkedAnswer("0", false),
    MarkedAnswer("2", false),
  ]),
  FlashCard("The end of the world is coming, what you gonna do",
      [InputAnswer("Nothing")]),
  FlashCard(
      "Sometimes you just cant take it anymore, Sometimes you just cant take it anymore, Sometimes you just cant take it anymore, huh?",
      [])
];

Future<List<Collection>> mockGetCollections() async =>
    await Future.delayed(const Duration(seconds: 1), () => collections);

Future<List<FlashCard>> mockGetFlashCards() async =>
    await Future.delayed(const Duration(seconds: 1), () => flashCards);
