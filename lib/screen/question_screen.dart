import 'package:adv_basics/widget/answer_button.dart';
import 'package:adv_basics/data/question.dart';
import 'package:adv_basics/screen/start_screen.dart';
import 'package:flutter/material.dart';
import 'package:adv_basics/main.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key, required this.onSelectedAnswer});

  final void Function(String answer) onSelectedAnswer;

  State<QuestionScreen> createState() {
    return _QuestionScreenState();
  }
}

class _QuestionScreenState extends State<QuestionScreen> {
  var currentQuestionIndex = 0;

  void answerQuestion(String selectedAnswer) {
    widget.onSelectedAnswer(selectedAnswer);
    setState(() {
      currentQuestionIndex++;

      //if (currentQuestionIndex == questions.length) currentQuestionIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[currentQuestionIndex];
    // có  thể sử dụng center nếu thích
    return SizedBox(
      width: double.infinity, // lấy càng nhiều chiều rộng càng tốt
      child: Container(
        margin: EdgeInsets.all(50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              currentQuestion.text,
              style: GoogleFonts.lato(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
              //style: TextStyle(color: Colors.white, fontSize: 15),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            ...currentQuestion.ShuffledAnswer.map((answer) {
              return AnswerButton(answer, () {
                answerQuestion(answer);
              });
            })
          ],
        ),
      ),
    );
  }
}
