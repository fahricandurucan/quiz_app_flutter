import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:quiz_app_flutter/controllers/home_controller.dart';
import 'package:quiz_app_flutter/screens/question_screen.dart';

class FavoriteScreen extends GetView<HomeController> {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.indigo,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: const Text(
          "Favorite Categories",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.indigo[100],
          borderRadius:
              const BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
        ),
        child: Obx(
          () => controller.likeList.isEmpty
              ? const Center(
                  child: Text(
                    "You have not selected a favorite category yet",
                    style: TextStyle(fontSize: 16),
                  ),
                )
              : ListView.builder(
                  itemCount: controller.likeList.length,
                  itemBuilder: (context, index) {
                    var category = controller.likeList[index];
                    return Padding(
                      padding: const EdgeInsets.only(top: 18, left: 8, right: 8),
                      child: GestureDetector(
                        onTap: () {
                          EasyLoading.show(
                              maskType: EasyLoadingMaskType.clear, status: "Preapering questions");
                          Future.delayed(const Duration(seconds: 2), () {
                            controller.getQuestions(category.id, 5);
                            Get.off(QuestionScreen(
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
                        child: Card(
                          color: Colors.indigo,
                          elevation: 10,
                          shadowColor: Colors.orange,
                          child: ListTile(
                            leading: const Icon(
                              Icons.favorite,
                              color: Colors.orange,
                            ),
                            title: Text(
                              category.name,
                              style: const TextStyle(color: Colors.white),
                            ),
                            trailing: GestureDetector(
                              onTap: () {
                                controller.deleteBox(category);
                                controller.likeListCategoryName.remove(category.name);
                                for (final x in controller.likeList) {
                                  print("***** ${x.id} - ${x.name}");
                                }
                              },
                              child: const Icon(
                                Icons.delete,
                                color: Colors.grey,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
