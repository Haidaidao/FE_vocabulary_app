// import 'package:adv_basics/data/question.dart';
import 'package:adv_basics/question_summary.dart';
import 'package:adv_basics/screen/controllscreen.dart';
import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen(
      {super.key,
      required this.chosenAnswer,
      required this.questions,
      required this.StartScreen});

  final void Function(String screen) StartScreen;
  final List<dynamic> questions;
  final List<String> chosenAnswer;

  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];
    print("------------");
    print(questions);
    print(chosenAnswer);
    for (var i = 0; i < chosenAnswer.length; i++) {
      
      summary.add({
        'question_index': i,
        'question': questions[i]['question'],
        'correct_answer': questions[i]['correct'],
        'user_answer': chosenAnswer[i]
      });
    }
    return summary;
  }

  @override
  Widget build(BuildContext context) {

    final summaryData = getSummaryData();
    final numTotalQuestion = questions.length;
    final numCorrectQustion = summaryData
        .where((data) => data['correct_answer'] == data['user_answer'])
        .length;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 245, 249, 2),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 245, 249, 2),
            Color.fromARGB(255, 191, 172, 28)
          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: SizedBox(
            width: double.infinity, // lấy càng nhiều chiều rộng càng tốt
            child: Container(
              margin: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "You answered $numCorrectQustion out of $numTotalQuestion questions correctly!",
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  QuestionSummery(summaryData),
                  SizedBox(
                    height: 30,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ControllScreen("start-screen")));
                      },
                      child: Text(
                        "Restart quiz!",
                      ))
                ],
              ),
            )),
      ),
    );
  }
}
