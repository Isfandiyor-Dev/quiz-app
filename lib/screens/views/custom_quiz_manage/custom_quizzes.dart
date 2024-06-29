import 'package:firebase_project/controller/quiz_controller.dart';
import 'package:firebase_project/models/quiz.dart';
import 'package:firebase_project/screens/views/custom_quiz_manage/edit_quiz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomQuizzes extends StatelessWidget {
  const CustomQuizzes({super.key});

  @override
  Widget build(BuildContext context) {
    final quizController = Provider.of<QuizController>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryFixedDim,
      appBar: AppBar(
        title: const Text("Quzzes"),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder(
          stream: quizController.list,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text("Savolar mavjud emas"),
              );
            }

            final quizzes =
                snapshot.data!.docs.map((doc) => Quiz.fromJson(doc)).toList();
            return ListView.builder(
              itemCount: quizzes.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => EditQuiz(index: index),
                        ),
                      );
                    },
                    title: Text(
                      quizzes[index].title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    subtitle: Text(
                      "Questions: ${quizzes[index].questions.length}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              },
            );
          }),
    );
  }
}
