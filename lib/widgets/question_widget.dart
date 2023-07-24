import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_character_entities/html_character_entities.dart';
import 'package:quiz_app_flutter/controllers/home_controller.dart';
import 'package:quiz_app_flutter/models/answer.dart';
import 'package:quiz_app_flutter/models/questions.dart';
import 'package:quiz_app_flutter/screens/score_screen.dart';
import 'package:quiz_app_flutter/widgets/answer_widget.dart';

class QuestionWidget extends GetView<HomeController> {
  const QuestionWidget({
    super.key,
    required this.question,
  });
  final Questions question;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Center(
                  child: Text(HtmlCharacterEntities.decode(question.question),
                      style: const TextStyle(fontSize: 22, color: Colors.white))),
            ),
            const SizedBox(
              height: 5,
            ),
            ...(question.shuffleList ?? <Answer>[]).asMap().entries.map(
                  (kv) => Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: AnswerWidget(
                      answer: kv.value,
                      question: question,
                      idx: kv.key,
                    ),
                  ),
                ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 45),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      controller.seconds.value = 0;
                      Get.back();
                      Get.back();
                    },
                    child: const Text(
                      "HOME",
                      style: TextStyle(color: Colors.indigo),
                    ),
                  ),
                  GestureDetector(
                    onTap: controller.isAnswerAdded.value == true || question.solved == true
                        ? null
                        : () {
                            if (!controller.isAnswerAdded.value) {
                              var list = [];
                              for (int i = 0; i < 4; i++) {
                                if (!question.shuffleList![i].isCorrect) {
                                  list.add(question.shuffleList![i].text);
                                }
                              }
                              list.shuffle();
                              for (int i = 0; i < 2; i++) {
                                if (controller.jokerIncorrectList.contains(list[i])) {
                                  i = i;
                                } else {
                                  controller.jokerIncorrectList.add(list[i]);
                                }
                              }
                              print(controller.jokerIncorrectList.toString());
                            }
                          },
                    child: Image.asset(
                      "images/joker.png",
                      width: 60,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      controller.seconds.value = 0;
                      controller.addScore(controller.correctList.length);
                      Get.off(const ScoreScreen());
                    },
                    child: const Text(
                      "FINISH",
                      style: TextStyle(color: Colors.indigo),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class TimeUpModal extends GetView<HomeController> {
  const TimeUpModal({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: AlertDialog(
          backgroundColor: Colors.orange,
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Time is up",
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
              SizedBox(
                height: 20,
              ),
              Text("Check your score here", style: TextStyle(fontSize: 16, color: Colors.white)),
              SizedBox(
                height: 20,
              ),
              Icon(
                Icons.arrow_downward,
                color: Colors.white,
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
          actions: [
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    controller.addScore(controller.correctList.length);
                    Get.off(const ScoreScreen());
                  },
                  child: const Text("Score", style: TextStyle(color: Colors.orange))),
            ),
          ],
        ),
      ),
    );
  }
}
