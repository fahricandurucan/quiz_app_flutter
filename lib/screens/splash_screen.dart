import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:quiz_app_flutter/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: AnimatedSplashScreen(
        splash: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "images/icon.png",
                width: 80,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Quiz",
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  Text(
                    "App",
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.orange),
                  ),
                ],
              ),
            ],
          ),
        ),
        backgroundColor: Colors.indigo,
        splashIconSize: 250,
        duration: 3000,
        nextScreen: const FlutterEasyLoading(
          child: HomeScreen(),
        ),
      ),
    );
  }
}
