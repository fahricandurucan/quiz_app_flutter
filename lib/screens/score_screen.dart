import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app_flutter/controllers/home_controller.dart';

class ScoreScreen extends GetView<HomeController> {
  const ScoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "GAME",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.orange),
                ),
                Text(
                  "OVER",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ],
            ),
            Text(
              "Total:${controller.questionList.length} Question",
              style: const TextStyle(fontSize: 24, color: Colors.white),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                width: 300,
                height: 450,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    controller.correctList.length < 3
                        ? Image.asset(
                            "images/lose.png",
                            width: 80,
                          )
                        : Image.asset(
                            "images/congrats.png",
                            width: 80,
                          ),
                    controller.correctList.length < 3
                        ? const Text(
                            "Not Enough!",
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          )
                        : const Text(
                            "Congrats!",
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                    controller.isHighScore(controller.correctList.length)
                        ? Text(
                            "${(controller.correctList.length) * 20}% High Score",
                            style: const TextStyle(
                                fontSize: 28, fontWeight: FontWeight.bold, color: Colors.orange),
                          )
                        : Text(
                            "${(controller.correctList.length) * 20}% Score",
                            style: const TextStyle(
                                fontSize: 28, fontWeight: FontWeight.bold, color: Colors.orange),
                          ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 8, left: 24, right: 24),
                      child: Container(
                        width: double.infinity,
                        height: 80,
                        decoration: const BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.all(Radius.circular(15))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Text(
                                  "Correct Answer : ",
                                  style: TextStyle(fontSize: 16, color: Colors.white),
                                ),
                                Text(
                                  controller.correctList.length.toString(),
                                  style: const TextStyle(fontSize: 16, color: Colors.white),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Text("InCorrect Answer : ",
                                    style: TextStyle(fontSize: 16, color: Colors.white)),
                                Text(
                                  controller.inCorrectList.length.toString(),
                                  style: const TextStyle(fontSize: 16, color: Colors.white),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(Colors.orange),
                        ),
                        onPressed: () {
                          controller.isPreparedAnswers.value = false;
                          Get.back();
                          Get.back();
                        },
                        child: const Text(
                          "Back Home",
                          style: TextStyle(color: Colors.white),
                        ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
