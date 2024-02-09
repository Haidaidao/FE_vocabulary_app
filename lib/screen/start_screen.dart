import 'package:adv_basics/screen/choose_course.dart';
import 'package:adv_basics/screen/controllscreen.dart';
import 'package:adv_basics/screen/listvocabulary.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../model/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import '../model/user.dart';
import '../service/handleResponse.dart';

class StartScreen extends StatefulWidget {
  const StartScreen(this.StartQuiz, {super.key});

  final void Function(String screen) StartQuiz;

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameCourseController = TextEditingController();

  String namesCourse = " ";
  var lengthCurrentCourse = 0;

  void createCourse(course) async {
    final response = await http.post(
      Uri.parse('http://192.168.1.10:3001/v1/api/course'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(course),
    );

    if (response.statusCode == 200) {
      setState(() {
        final data = json.decode(response.body);
        namesCourse = data['data']['name'];
        User.setIdCourse(data['data']['_id']);
        User.setNameCourse(data['data']['name']);
      });
    } else {
      // Xử lý lỗi
      throw Exception('Failed to create data');
    }
  }

  void showForm(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: SingleChildScrollView(
                child: Form(
                    key: _formKey,
                    child: TextFormField(
                      controller: _nameCourseController,
                      decoration: InputDecoration(
                          labelText: 'Enter name of course',
                          labelStyle: TextStyle(
                              color: const Color.fromARGB(255, 12, 80, 163),
                              fontWeight: FontWeight.bold)),
                    )),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      String courseName = _nameCourseController.text;
                      Map<String, dynamic> courseAdd = {
                        'type': "EMPTY-COURSE",
                        'name': courseName,
                        'userInfor': User.getId()
                      };
                      createCourse(courseAdd);
                      _nameCourseController.text = "";
                      Navigator.of(context).pop(false);
                    },
                    child: Text(
                      'Confirm',
                      style: TextStyle(
                          color: const Color.fromARGB(255, 12, 80, 163)),
                    )),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Colors.red),
                    )),
              ],
            ));
  }

  void getCourse() async {
    var id = User.getId();
    try {
      final response = await http.post(
        Uri.parse('http://192.168.1.10:3001/v1/api/get_course'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({'id': id}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['error'] == 0) {
          print(data['data']);
          var dataTemp = data['data'];
          for (var i = 0; i < dataTemp.length; i++) {
            if (dataTemp[i]['_id'] == User.getIdCourse()) {
              print("============");
              lengthCurrentCourse = dataTemp[i]['listVocabulary'].length;
              print(lengthCurrentCourse);
            }
          }
          return data['data'];
        }
      }
      print("Error: ${response.statusCode}");
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      getCourse();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nameCourseController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 245, 249, 2),
        actions: [
          TextButton.icon(
            label: const Text('Add Course'),
            onPressed: () {
              showForm(context);
            },
            icon: Icon(Icons.add_circle),
            style: TextButton.styleFrom(
                foregroundColor: const Color.fromARGB(255, 12, 80, 163)),
          ),
          TextButton.icon(
            label: const Text('Courses'),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => new ChooseCourse(
                            lengthCurrentCourse: lengthCurrentCourse,
                          ))).then((value) {
                setState(() {});
              });
            },
            icon: Icon(Icons.arrow_drop_down_circle),
            style: TextButton.styleFrom(
                foregroundColor: const Color.fromARGB(255, 12, 80, 163)),
          ),
        ],
        leading: IconButton(
            color: const Color.fromARGB(255, 12, 80, 163),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          new ControllScreen('login-screen')));
            },
            icon: Icon(Icons.logout)),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 245, 249, 2),
            Color.fromARGB(255, 191, 172, 28)
          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Center(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/book_banner.png',
                  width: 300,
                  height: 300,
                  color: const Color.fromARGB(255, 12, 80, 163),
                ),
                const SizedBox(height: 30),
                Text(
                  "${User.getNameCourse()}",
                  style: GoogleFonts.lato(
                      color: Color.fromARGB(255, 12, 80, 163),
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 12, 80, 163),
                    ),
                    onPressed: () {
                      if (User.getNameCourse() != " ")
                        widget.StartQuiz('question-screen');
                    },
                    child: const Text('Start quiz'),
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 12, 80, 163),
                    ),
                    onPressed: () {
                      if (User.getNameCourse() != " ") {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ListVocabulary(
                                nameCourse: User.getNameCourse())));
                      }
                    },
                    child: const Text('List vocabulary'),
                  ),
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }
}
