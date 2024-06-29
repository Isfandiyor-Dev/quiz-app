import 'package:cloud_firestore/cloud_firestore.dart';

class QuizFirebaseServices {
  final _quizzesCollection = FirebaseFirestore.instance.collection("quizzes");
  Stream<QuerySnapshot> getQuizzes() async* {
    yield* _quizzesCollection.snapshots();
  }

  void editTittle(String id, String title) {
    _quizzesCollection.doc(id).update({
      "title": title,
    });
  }
}
