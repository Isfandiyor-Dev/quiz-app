import 'package:firebase_project/controller/quiz_controller.dart';
import 'package:firebase_project/models/question.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class QuestionItem extends StatefulWidget {
  Question quiz;
  QuestionItem({super.key, required this.quiz});

  @override
  State<QuestionItem> createState() => _QuestionItemState();
}

class _QuestionItemState extends State<QuestionItem> {
  final List<String> variantsABC = ["A", "B", "C", "D", "E"];

  @override
  Widget build(BuildContext context) {
    final quizController = Provider.of<QuizController>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 400,
          child: Text(
            widget.quiz.question,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
        ),
        const SizedBox(height: 40),
        SizedBox(
          height: 500,
          child: SingleChildScrollView(
            child: Column(
              children: List.generate(
                widget.quiz.variants.length,
                (index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        quizController.onSelectedAnswers(
                          widget.quiz.id,
                          widget.quiz.variants[index].id,
                          widget.quiz.answer,
                        );
                      },
                      child: Ink(
                        height: 80,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: quizController
                                      .getSelectedAnswer(widget.quiz.id) ==
                                  widget.quiz.variants[index].id
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
                              widget.quiz.variants[index].variant,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[800],
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
          ),
        ),
      ],
    );
  }
}
