import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_project/models/variant.dart';

class Question {
  String id;
  String question;
  String answer;
  List<Variant> variants;

  Question({
    required this.id,
    required this.question,
    required this.answer,
    required this.variants,
  });

  factory Question.fromJson(QueryDocumentSnapshot query) {
    Map<String, dynamic> variantsMap = query["variants"];
    List<Variant> variantsList = variantsMap.entries
        .map((entry) => Variant(id: entry.key, variant: entry.value))
        .toList();

    return Question(
      id: query.id,
      question: query["question"],
      answer: query["answer"],
      variants: variantsList,
    );
  }
}
