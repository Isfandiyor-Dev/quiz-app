import 'package:firebase_project/controller/quiz_controller.dart';
import 'package:firebase_project/models/question.dart';
import 'package:firebase_project/models/quiz.dart';
import 'package:firebase_project/screens/widgets/question_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuizGame extends StatelessWidget {
  QuizGame({super.key});
  final pageController = PageController();

  Widget build(BuildContext context) {
    final quizzesController = context.watch<QuizController>();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryFixedDim,
      body: StreamBuilder(
        stream: quizzesController.list,
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
          return Stack(children: [
            PageView.builder(
              controller: pageController,
              scrollDirection: Axis.vertical,
              itemCount: quizzes[0].questions.length,
              itemBuilder: (context, index) {
                return QuestionItem(
                  quiz: quizzes[0].questions[index],
                  pageController: pageController,
                  isLast:
                      quizzes[0].questions.last == quizzes[0].questions[index],
                );
              },
            ),
            const Positioned(
              top: 80,
              left: 25,
              child: Icon(
                CupertinoIcons.smiley_fill,
                size: 60,
                color: Colors.white,
              ),
            ),
            Positioned(
              top: 80,
              right: 25,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  CupertinoIcons.clear,
                  size: 40,
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              bottom: 70,
              right: 25,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    icon: const Icon(
                      CupertinoIcons.chevron_up,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    icon: const Icon(
                      CupertinoIcons.chevron_down,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
          ]);
        },
      ),
    );
  }
}
