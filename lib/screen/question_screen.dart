// ignore_for_file: avoid_print
import 'dart:math';
import 'package:adv_basics/data/question.dart';
import 'package:adv_basics/model/user.dart';
import 'package:adv_basics/widget/answer_button.dart';
// import 'package:adv_basics/data/question.dart';
import 'package:adv_basics/screen/start_screen.dart';
import 'package:flutter/material.dart';
import 'package:adv_basics/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key, required this.onSelectedAnswer});

  final void Function(
          String answer, List<dynamic> listQuestion, int lengthListAnswer)
      onSelectedAnswer;

  State<QuestionScreen> createState() {
    return _QuestionScreenState();
  }
}

class _QuestionScreenState extends State<QuestionScreen> {
  var currentQuestionIndex = 0;
  var questions = [];
  var questionsOrigin = [];
  void getCourse(id) async {
    print(id);
    try {
      final response = await http.post(
        Uri.parse('http://192.168.1.10:3001/v1/api/get_vocabulary_course_test'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({'id': id}),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['error'] == 0) {
          setState(() {
            questions = data['data'];

            for (var i = 0; i < questions.length; i++) {
              questions[i]['answers'].shuffle();
            }
          });
        }
        // print(questions);
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  void answerQuestion(String selectedAnswer, int lengthList) {
    widget.onSelectedAnswer(selectedAnswer, questions, lengthList);
    if (currentQuestionIndex != lengthList - 1)
      setState(() {
        currentQuestionIndex++;
        // if (currentQuestionIndex == lengthList) currentQuestionIndex = 0;
      });
  }

  @override
  void initState() {
    super.initState();
    // Gọi hàm khởi tạo bất đồng bộ
    initAsync();
  }

  Future<void> initAsync() async {
    // Bạn có thể sử dụng User.getIdCourse() trực tiếp nếu nó là bất đồng bộ
    var courseId = await User.getIdCourse();
    getCourse(courseId);
  }

  @override
  Widget build(BuildContext context) {
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
              questions[currentQuestionIndex]['question'],
              style: GoogleFonts.lato(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
              //style: TextStyle(color: Colors.white, fontSize: 15),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            ...questions[currentQuestionIndex]['answers'].map((answer) {
              return AnswerButton(answer, () {
                answerQuestion(answer, questions.length);
              });
            })
          ],
        ),
      ),
    );
  }
}
