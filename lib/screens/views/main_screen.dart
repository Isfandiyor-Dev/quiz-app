import 'package:firebase_project/screens/views/custom_quiz_manage/custom_quizzes.dart';
import 'package:firebase_project/screens/views/quiz_game.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryFixedDim,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton(
              style: FilledButton.styleFrom(
                fixedSize: const Size(200, 70),
              ),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (ctx) => QuizGame()));
              },
              child: const Text(
                "Start Quiz",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 30),
            FilledButton(
              style: FilledButton.styleFrom(
                fixedSize: const Size(200, 70),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => const CustomQuizzes(),
                  ),
                );
              },
              child: const Text(
                "Custom Quizzes",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
