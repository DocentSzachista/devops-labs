import 'dart:convert';

import 'package:fiszki_app/models/flash_card.dart';
import 'package:fiszki_app/models/collection.dart';
import 'package:http/http.dart' as http;

const baseUrl =
    String.fromEnvironment('BACKEND_URL', defaultValue: "localhost:8000");

Future<List<Collection>> getFlashCardCollections() async {
  final response = await http.get(
    Uri.http(baseUrl, "/collections/", {"user_id": "1sadasd"}),
  );

  if (response.statusCode == 200) {
    List<dynamic> jsonObj = jsonDecode(response.body)['collections'];
    return jsonObj.map((json) => Collection.fromJson(json)).toList();
  } else {
    throw Exception("Failed to retrieve data");
  }
}

Future<List<FlashCard>> getFlashCardsFromCollection(
    Collection collection) async {
  final response = await http.get(
    Uri.http(baseUrl, "collections/${collection.id}/flashcard"),
  );

  if (response.statusCode == 200) {
    List<dynamic> jsonObj = jsonDecode(response.body)['flashCards'];
    return jsonObj.map((json) => FlashCard.fromJson(json)).toList();
  } else {
    throw Exception("Failed to retrieve data");
  }
}

Future<Map<String, dynamic>> CheckIfAPIIsAlive() async {
  final response = await http.get(
    Uri.http(baseUrl, "/isAlive"),
  );
  if (response.statusCode == 200) {
    Map<String, dynamic> jsonObj = jsonDecode(response.body);
    return jsonObj;
  } else {
    throw Exception("Failed to retrieve data");
  }
}

Future<bool> postNewFlashCard() async {
  final response = await http.post(
    Uri.http(baseUrl, "collections"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      "flashCards": [
        {
          "answers": [
            {"answer": "To be cool", "isCorrect": true},
            {"answer": "To be bad", "isCorrect": false},
            {"answer": "To be happy", "isCorrect": true}
          ],
          "question": "WHat is the reason that you are here"
        }
      ],
      "isPublic": true,
      "tags": ["device"],
      "title": "Device flashcard",
      "user_id": "-1"
    }),
  );
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}
