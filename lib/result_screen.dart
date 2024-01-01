import 'package:adv_basics/data/question.dart';
import 'package:adv_basics/question_summary.dart';
import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen(
      {super.key, required this.chosenAnswer, required this.StartScreen});

  final void Function(String screen) StartScreen;
  final List<String> chosenAnswer;

  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];

    for (var i = 0; i < chosenAnswer.length; i++) {
      summary.add({
        'question_index': i,
        'question': questions[i].text,
        'correct_answer': questions[i].answers[0],
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

    return SizedBox(
        width: double.infinity, // lấy càng nhiều chiều rộng càng tốt
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  "You answered $numCorrectQustion out of $numTotalQuestion questions correctly!",
                  style: TextStyle(color: Colors.white),),
              SizedBox(
                height: 30,
              ),
              QuestionSummery(summaryData),
              SizedBox(
                height: 30,
              ),
              TextButton(
                  onPressed: () {
                    StartScreen('start-screen');
                  },
                  child: Text("Restart quiz!"))
            ],
          ),
        ));
  }
}
