import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_project/firebase_services/quiz_firebase_services.dart';
import 'package:flutter/foundation.dart';

class QuizController extends ChangeNotifier {
  final _quizFirebaseServices = QuizFirebaseServices();

  List<Map<String, dynamic>> selectedAnswers = [];

  void onSelectedAnswers(
    String quizId,
    String selectedAnsId,
    String correctAnswer,
  ) {
    bool isCreated = false;
    for (var item in selectedAnswers) {
      if (item["quizId"] == quizId) {
        item["selectedAnsId"] = selectedAnsId;
        isCreated = true;
      }
    }
    if (!isCreated) {
      selectedAnswers.add({
        "quizId": quizId,
        "selectedAnsId": selectedAnsId,
        "correctAnswer": correctAnswer,
      });
    }
    notifyListeners();
  }

  String? getSelectedAnswer(String quizId) {
    for (var item in selectedAnswers) {
      if (item["quizId"] == quizId) {
        return item["selectedAnsId"];
      }
    }
    notifyListeners();
    return null;
  }

  Stream<QuerySnapshot> get list {
    return _quizFirebaseServices.getQuizzes();
  }
}
