import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_character_entities/html_character_entities.dart';
import 'package:quiz_app_flutter/controllers/home_controller.dart';
import 'package:quiz_app_flutter/models/questions.dart';

import '../models/answer.dart';

class AnswerWidget extends GetView<HomeController> {
  final Answer answer;
  final Questions question;
  final int idx;

  const AnswerWidget({
    super.key,
    required this.answer,
    required this.question,
    required this.idx,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 4, bottom: 4),
        child: GestureDetector(
          onTap: controller.isAnswerAdded.value == true ||
                  question.solved == true ||
                  controller.jokerIncorrectList.contains(answer.text)
              ? null
              : () {
                  answer.isSelected = true;
                  if (answer.isCorrect) {
                    controller.isAnswerAdded.value = true;
                    controller.correctList.add(answer.text);
                    controller.selectedList.add(answer.text);
                    question.solved = true;
                  } else {
                    controller.isAnswerAdded.value = true;
                    controller.inCorrectList.add(answer.text);
                    controller.selectedList.add(answer.text);
                    question.solved = true;
                  }
                },
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
                color: controller.correctList.contains(answer.text)
                    ? Colors.green
                    : controller.inCorrectList.contains(answer.text)
                        ? Colors.red
                        : Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                border: controller.jokerIncorrectList.contains(answer.text)
                    ? Border.all(color: Colors.red, width: 2)
                    : null),
            width: double.infinity,
            height: 60,
            child: Row(children: [
              Container(
                height: 50,
                width: 50,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: Text(
                  controller.choiceList[idx],
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                width: 40,
              ),
              Expanded(child: Text(HtmlCharacterEntities.decode(answer.text))),
            ]),
          ),
        ),
      ),
    );
  }
}
