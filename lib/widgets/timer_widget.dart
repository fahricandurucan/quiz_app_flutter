import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app_flutter/controllers/home_controller.dart';

class TimerWidget extends GetView<HomeController> {
  const TimerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => LinearProgressIndicator(
        minHeight: 6,
        value: controller.seconds.value / 60,
        valueColor: const AlwaysStoppedAnimation(Colors.orange),
      ),
    );
  }
}
