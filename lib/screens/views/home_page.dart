import 'package:firebase_project/controller/quiz_controller.dart';
import 'package:firebase_project/models/question.dart';
import 'package:firebase_project/screens/widgets/question_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final quizzesController = context.watch<QuizController>();
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
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

          final quizzes = snapshot.data!.docs;
          return Stack(
            children: [
              PageView(
                controller: _pageController,
                scrollDirection: Axis.vertical,
                children: List.generate(
                  quizzes.length,
                  (index) {
                    final quiz = Question.fromJson(quizzes[index]);
                    return QuestionItem(quiz: quiz);
                  },
                ),
                onPageChanged: (index) {},
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
                  onPressed: () {},
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
                        _pageController.previousPage(
                          duration: const Duration(seconds: 1),
                          curve: Curves.easeInOutCubicEmphasized,
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
                        _pageController.nextPage(
                          duration: const Duration(seconds: 1),
                          curve: Curves.easeInOutCubicEmphasized,
                        );
                      },
                      icon: const Icon(
                        CupertinoIcons.chevron_down,
                        color: Colors.white,
                        size: 30,
                      ),
                    )
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
