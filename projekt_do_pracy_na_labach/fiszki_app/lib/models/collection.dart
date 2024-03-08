import 'package:fiszki_app/models/flash_card.dart';

class Collection {
  bool isPublic;
  String title;
  String id;

  List<String>? tags;
  List<FlashCard>? flashCards;

  Collection(
      {required this.isPublic,
      required this.title,
      required this.id,
      this.tags});

  Collection.fromJson(Map<String, dynamic> json)
      : isPublic = json['isPublic'] as bool,
        id = json['_id'] as String,
        title = json['title'] as String,
        tags =
            json.containsKey("tags") ? List<String>.from(json['tags']) : null;
  // flashCards = json.containsKey("flashCards")
  //     ? List<FlashCard>.from(
  //         List<Map<String, dynamic>>.from(json['flashCards'])
  //             .map((json) => FlashCard.fromJson(json)))
  //     : null;

  Map<String, dynamic> toJson() =>
      {"id": id, "title": title, "isPublic": isPublic, "tags": tags};
}
