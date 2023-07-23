import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app_flutter/controllers/home_controller.dart';
import 'package:quiz_app_flutter/models/category.dart';
import 'package:quiz_app_flutter/screens/score_screen.dart';
import 'package:quiz_app_flutter/widgets/question_widget.dart';
import 'package:quiz_app_flutter/widgets/timer_widget.dart';

class QuestionScreen extends GetView<HomeController> {
  const QuestionScreen({super.key, required this.category});
  final Category category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.indigo,
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          automaticallyImplyLeading: false,
          title: Text(
            category.name,
            style: const TextStyle(color: Colors.white),
          ),
          actions: [
            Obx(
              () => Padding(
                  padding: const EdgeInsets.only(right: 24),
                  child: controller.seconds.value == 0
                      ? Image.asset(
                          "images/time.png",
                          width: 25,
                          color: Colors.white,
                        )
                      : Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              decoration: const BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                              ),
                            ),
                            Text(
                              controller.seconds.value.toString(),
                              style: const TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ],
                        )),
            )
          ],
        ),
        body: Obx(() => controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.orange,
                ),
              )
            : Column(
                children: [
                  const TimerWidget(),
                  Center(
                      child: Obx(
                    () => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              if (controller.seconds.value != 0) {
                                controller.pageController.previousPage(
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.linear);
                              }
                            },
                            icon: const Icon(
                              Icons.arrow_back,
                              size: 30,
                              color: Colors.orange,
                            ),
                          ),
                          Text(
                            "Question ${controller.pageIdx.value}/${controller.questionList.length}",
                            style: const TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          IconButton(
                            onPressed: () {
                              controller.isAnswerAdded.value = false;
                              if (controller.seconds.value != 0) {
                                controller.pageController.nextPage(
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.linear);
                              }
                            },
                            icon: const Icon(
                              Icons.arrow_forward,
                              size: 30,
                              color: Colors.orange,
                            ),
                          )
                        ],
                      ),
                    ),
                  )),
                  const SizedBox(
                    height: 5,
                  ),
                  Expanded(
                    child: PageView(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: controller.pageController,
                        onPageChanged: (value) {
                          controller.pageIdx.value = value + 1;
                          controller.selectedAnswer.value = -1;
                        },
                        children: controller.questionList
                            .map((question) => QuestionWidget(question: question))
                            .toList()),
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
                        IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
                        ElevatedButton(
                          onPressed: () {
                            controller.seconds.value = 0;
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
              )));
  }
}
