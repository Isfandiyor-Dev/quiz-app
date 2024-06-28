import 'package:cloud_firestore/cloud_firestore.dart';

class QuizFirebaseServices {
  final _quizzesCollection = FirebaseFirestore.instance.collection("quizzes");
  Stream<QuerySnapshot> getQuizzes() async* {
    yield* _quizzesCollection.snapshots();
  }
}
