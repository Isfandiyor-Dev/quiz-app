import 'package:firebase_project/models/variant.dart';

class Question {
  String id;
  String text;
  String answer;
  List<Variant> variants;

  Question({
    required this.id,
    required this.text,
    required this.answer,
    required this.variants,
  });

  factory Question.fromMap(String id, Map<String, dynamic> data) {
    Map<String, dynamic> variantsMap = data['variants'] as Map<String, dynamic>;
    List<Variant> variantsList = variantsMap.entries
        .map((entry) => Variant(id: entry.key, variant: entry.value))
        .toList();

    return Question(
      id: id,
      text: data['question'],
      answer: data['answer'],
      variants: variantsList,
    );
  }
}
