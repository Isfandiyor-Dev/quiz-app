import 'package:firebase_project/controller/quiz_controller.dart';
import 'package:firebase_project/models/question.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class QuestionItem extends StatelessWidget {
  final Question quiz;
  final PageController pageController;
  bool isLast;
  QuestionItem({
    super.key,
    required this.quiz,
    required this.pageController,
    required this.isLast,
  });

  final List<String> variantsABC = ["A", "B", "C", "D", "E"];

  @override
  Widget build(BuildContext context) {
    final quizController = Provider.of<QuizController>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 400,
          child: Text(
            quiz.text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
        ),
        const SizedBox(height: 40),
        SizedBox(
          height: quiz.variants.length * 100,
          child: ListView.builder(
            itemCount: quiz.variants.length,
            itemBuilder: (context, index) {
              final variantId = quiz.variants[index].id;
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    quizController.onSelectedAnswers(
                      quiz.id,
                      variantId,
                      quiz.answer,
                    );
                  },
                  child: Ink(
                    height: 80,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color:
                          quizController.getSelectedAnswer(quiz.id) == variantId
                              ? Colors.indigo
                              : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Text(
                          "${variantsABC[index]})",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Text(
                          quiz.variants[index].variant,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[900],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 30),
        isLast
            ? ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (ctx) {
                      return AlertDialog(
                        title: Text("Your Result"),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "To'gri javoblar: ${quizController.result()["correctAnswers"]}"),
                            Text(
                                "Noto'gri javoblar: ${quizController.result()["wrongAnswers"]}"),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: const Text("Show Result"),
              )
            : const SizedBox(),
      ],
    );
  }
}
