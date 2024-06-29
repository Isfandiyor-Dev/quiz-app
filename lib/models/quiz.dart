import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_project/models/question.dart';

class Quiz {
  String id;
  String title;
  List<Question> questions;

  Quiz({
    required this.id,
    required this.questions,
    required this.title,
  });

  factory Quiz.fromJson(QueryDocumentSnapshot query) {
    Map<String, dynamic> quizData = query['quiz'] as Map<String, dynamic>;
    List<Question> questionsList = quizData.entries
        .map((entry) =>
            Question.fromMap(entry.key, entry.value as Map<String, dynamic>))
        .toList();

    return Quiz(
      id: query.id,
      questions: questionsList,
      title: query['title'],
    );
  }
}
