import 'package:firebase_project/controller/quiz_controller.dart';
import 'package:firebase_project/models/question.dart';
import 'package:firebase_project/models/quiz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class EditQuiz extends StatelessWidget {
  int index;
  EditQuiz({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final QuizController quizController = Provider.of<QuizController>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryFixedDim,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryFixedDim,
        title: const Text("Quiz"),
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

            final quizzes = snapshot.data!.docs;
            Quiz question = Quiz.fromJson(quizzes[index]);
            return Padding(
              padding: const EdgeInsets.all(18.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          question.title,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            final textController =
                                TextEditingController(text: question.title);
                            String? errorText;
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: const Text("Edit Tittle Quiz"),
                                content: TextField(
                                  controller: textController,
                                  decoration: InputDecoration(
                                    label: const Text("New Title"),
                                    error: errorText != null
                                        ? Text(
                                            "$errorText",
                                            style: const TextStyle(
                                              color: Colors.redAccent,
                                            ),
                                          )
                                        : null,
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Cancel"),
                                  ),
                                  FilledButton(
                                    onPressed: () {
                                      if (textController.text
                                          .trim()
                                          .isNotEmpty) {
                                        quizController.editTittleQuiz(
                                            question.id, textController.text);
                                        Navigator.pop(context);

                                        errorText = null;
                                      } else {
                                        errorText = "Please enter a title";
                                      }
                                    },
                                    child: const Text("Save"),
                                  ),
                                ],
                              ),
                            );
                          },
                          icon: const Icon(Icons.edit),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Questions",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.70,
                      child: ListView.builder(
                        itemCount: question.questions.length,
                        itemBuilder: (cotnext, index) {
                          Question questionItem = question.questions[index];
                          return Container(
                            height: 100,
                            width: 300,
                            margin: const EdgeInsets.all(10),
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  questionItem.text,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "Variants: ${questionItem.variants.length}",
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
