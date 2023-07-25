import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:quiz_app_flutter/controllers/home_controller.dart';
import 'package:quiz_app_flutter/screens/favorite_screen.dart';
import 'package:quiz_app_flutter/screens/question_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Scaffold(
        backgroundColor: Colors.indigo[100],
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.indigo,
          title: const Text(
            "Categories",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: IconButton(
                  onPressed: () {
                    Get.to(
                      const FavoriteScreen(),
                    );
                  },
                  icon: const Icon(
                    Icons.favorite,
                    color: Colors.white,
                    size: 30,
                  )),
            ),
          ],
        ),
        body: Obx(
          () => controller.homeScreenLoading.value == true
              ? const Center(
                  child: CircularProgressIndicator(color: Colors.indigo),
                )
              : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: controller.categoryList.length,
                  itemBuilder: (context, index) {
                    var category = controller.categoryList[index];
                    return GestureDetector(
                      onTap: () {
                        EasyLoading.show(
                            maskType: EasyLoadingMaskType.clear, status: "Preapering questions");
                        Future.delayed(const Duration(seconds: 2), () {
                          controller.getQuestions(category.id, 5);
                          Get.to(QuestionScreen(
                            category: category,
                          ));
                          controller.questionList.clear();
                          controller.isLoading.value = true;
                          controller.pageIdx.value = 1;
                          controller.selectedAnswer.value = -1;
                          controller.correctList.clear();
                          controller.inCorrectList.clear();
                          controller.isAnswerAdded.value = false;
                          EasyLoading.dismiss();
                        });
                      },
                      child: Obx(
                        () => Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Card(
                              elevation: 10,
                              shadowColor: controller.likeListCategoryName.contains(category.name)
                                  ? Colors.orange
                                  : null,
                              margin:
                                  const EdgeInsets.only(top: 20, bottom: 12, left: 12, right: 12),
                              color: Colors.indigo,
                              child: Center(
                                  child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  category.name,
                                  style: const TextStyle(fontSize: 20, color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              )),
                            ).animate().shake(hz: 2, curve: Curves.easeIn),
                            Padding(
                              padding: const EdgeInsets.only(right: 20, top: 25),
                              child: GestureDetector(
                                onTap: () {
                                  print("id = ${category.id}");
                                  controller.likeListCategoryName.contains(category.name)
                                      ? controller.deleteBox(category)
                                      : controller.addBox(category);
                                  controller.lenghtBox();
                                },
                                child: AnimatedCrossFade(
                                  firstChild: firstWidget(),
                                  secondChild: secondWidget(),
                                  crossFadeState:
                                      controller.likeListCategoryName.contains(category.name)
                                          ? CrossFadeState.showFirst
                                          : CrossFadeState.showSecond,
                                  duration: const Duration(milliseconds: 600),
                                ),
                                // child: Container(
                                //   height: 40,
                                //   width: 40,
                                //   decoration: const BoxDecoration(
                                //       color: Colors.white,
                                //       borderRadius: BorderRadius.all(Radius.circular(20))),
                                //   child: controller.likeListCategoryName.contains(category.name)
                                //       ? const Icon(
                                //           Icons.favorite,
                                //           color: Colors.orange,
                                //         )
                                //       : const Icon(
                                //           Icons.favorite_border,
                                //           color: Colors.grey,
                                //         ),
                                // ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ));
  }

  Widget firstWidget() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.grey[400],
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: const Icon(
        Icons.favorite,
        color: Colors.orange,
      ),
    );
  }

  Widget secondWidget() {
    return Container(
      width: 40,
      height: 40,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: const Icon(
        Icons.favorite_border,
        color: Colors.grey,
      ),
    );
  }
}
