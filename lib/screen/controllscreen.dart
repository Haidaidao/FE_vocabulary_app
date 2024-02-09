import 'package:adv_basics/data/question.dart';
import 'package:adv_basics/question_summary.dart';
import 'package:adv_basics/screen/loginscreen.dart';
import 'package:adv_basics/screen/question_screen.dart';
import 'package:adv_basics/result_screen.dart';
import 'package:adv_basics/screen/signup_screen.dart';
import 'package:adv_basics/screen/start_screen.dart';
import 'package:flutter/material.dart';
import 'package:adv_basics/main.dart';

class ControllScreen extends StatefulWidget {
  const ControllScreen(this.nameScreen, {super.key});

  final String nameScreen;
  @override
  State<ControllScreen> createState() {
    return _ControllScreenState();
  }
}

class _ControllScreenState extends State<ControllScreen> {
  final List<String> selectedAnswer = [];
  var activeScreen;

  @override
  void initState() {
    super.initState();
    // Initialize activeScreen with the value of nameScreen from the widget
    activeScreen = widget.nameScreen;
  }

  void switchScreen(String screen) {
    setState(() {
      if (screen == 'start-screen') selectedAnswer.clear();

      activeScreen = screen;
    });
  }

  void chooseAnswer(
      String answer, List<dynamic> listQuestion, int lengthListAnswer) {
    selectedAnswer.add(answer);
    print(listQuestion);
    if (selectedAnswer.length == lengthListAnswer) {
      print(selectedAnswer);
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ResultScreen(
              chosenAnswer: selectedAnswer,
              questions: listQuestion,
              StartScreen: switchScreen)));
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenWidget = activeScreen == 'start-screen'
        ? StartScreen(switchScreen)
        : QuestionScreen(onSelectedAnswer: chooseAnswer);

    if (activeScreen == 'login-screen')
      screenWidget = LoginScreen();
    else if (activeScreen == 'signup-screen') screenWidget = SignupScreen();

    // TODO: implement build
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color.fromARGB(255, 245, 249, 2),
                    Color.fromARGB(255, 191, 172, 28)
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                ),
                child: screenWidget)));
  }
}
