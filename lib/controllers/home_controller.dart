import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quiz_app_flutter/models/answer.dart';
import 'package:quiz_app_flutter/models/category.dart';
import 'package:quiz_app_flutter/models/questions.dart';
import 'package:quiz_app_flutter/services/api.dart';
import 'package:quiz_app_flutter/widgets/question_widget.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  final categoryList = <Category>[].obs;
  final questionList = <Questions>[].obs;
  final selectedAnswerList = <String>[].obs;
  final isLoading = true.obs;
  final homeScreenLoading = true.obs;
  final pageIdx = 1.obs;
  final isCorrect = false.obs;
  final pageController = PageController();
  final selectedAnswer = (-1).obs;
  final seconds = 0.obs;
  var timer = Timer(const Duration(seconds: 0), () {});
  final choiceList = <String>["A", "B", "C", "D"].obs;
  final correctList = <String>[].obs;
  final inCorrectList = <String>[].obs;
  final isAnswerAdded = false.obs;
  final isPreparedAnswers = false.obs;

  final temp = 0.obs;
  final selectedList = <String>[].obs;

  final likeList = <Category>[].obs;
  final likeListCategoryName = <String>[].obs;
  final copy = false.obs;

  final Box<Category> categoryBox = Hive.box<Category>("category");
  final Box scoreBox = Hive.box("score");

  final isJokerSelected2 = false.obs;
  final jokerIncorrectList = <String>[].obs;

  final scoreList = <int>[].obs;

  void addScore(int score) {
    if (!scoreBox.values.toList().contains(score)) {
      scoreBox.add(score);
      scoreList.add(score);
    }
  }

  void deleteScores() {
    for (final key in scoreBox.keys) {
      scoreBox.delete(key);
    }
  }

  bool isHighScore(int score) {
    int max = score;
    if (max == 0) {
      return false;
    }
    if (scoreList.isEmpty) {
      return false;
    }
    for (final x in scoreList) {
      if (x > max) {
        return false;
      }
    }
    return true;
  }

  void lenghtBox() {
    print(categoryBox.length.toString());
  }

  void addBox(Category category) async {
    await categoryBox.put(category.id, category);
    likeListCategoryName.add(category.name);
    likeList.add(category);
  }

  void deleteBox(Category category) async {
    await categoryBox.delete(category.id);
    likeListCategoryName.remove(category.name);
    likeList.remove(category);
  }

  // void addFav(Category category) {
  //   if (likeList.contains(category)) {
  //     copy.value = true;
  //   } else {
  //     likeList.add(category);
  //     copy.value = false;
  //   }
  // }

  // void removeFav(Category category) {
  //   if (likeList.isNotEmpty) {
  //     likeList.remove(category);
  //   } else {
  //     copy.value = false;
  //   }
  // }

  void startTimer() {
    seconds.value = 60;

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds.value != 0) {
        seconds.value--;
      }
    });
  }

  void addSelectedAnswers(Answer answer) {
    if (isCorrect.value) {
      selectedAnswerList.add(answer.text);
    } else {}
    for (var x in selectedAnswerList) {
      print(x);
    }
  }

  Future<void> getCategories() async {
    final result = await Api.getCategories();
    if (result != null) {
      categoryList.value = result;
      homeScreenLoading.value = false;
    }
  }

  void easy() {
    EasyLoading.show(maskType: EasyLoadingMaskType.clear, status: "Preapering questions");
  }

  Future<void> getQuestions(int categoryId, int count) async {
    // EasyLoading.show(maskType: EasyLoadingMaskType.clear, status: "Preapering questions");
    timer.cancel();
    final result = await Api.getQuestions(categoryId, count);
    if (result != null) {
      for (final question in result) {
        List<Answer> ans =
            question.incorrectAnswers.map((e) => Answer(text: e, isCorrect: false)).toList();
        ans.add(Answer(text: question.correctAnswer, isCorrect: true));
        ans.shuffle();
        questionList.add(question.copyWith(answers: ans));
      }
      isLoading.value = false;
      startTimer();
    }
    print(questionList.length);
    // EasyLoading.dismiss();
  }

  @override
  void onInit() {
    getCategories();
    ever(seconds, (_) {
      if (seconds.value == 0) Get.dialog(const TimeUpModal(), barrierDismissible: false);
    });

    try {
      print("onInıt starting...");
      likeList.addAll(categoryBox.values);
      for (var x in categoryBox.values) {
        likeListCategoryName.add(x.name);
      }
      for (final x in likeList) {
        print("fahrican");
        print("***** ${x.id} - ${x.name}");
      }
    } catch (e) {
      print(e.toString());
    }

    // deleteScores();

    try {
      for (var x in scoreBox.values) {
        scoreList.add(x);
        for (final a in scoreList) {
          print("score = $a");
        }
      }
    } catch (e) {
      print(e);
    }

    super.onInit();
  }
}
