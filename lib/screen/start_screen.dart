import 'package:adv_basics/screen/choose_course.dart';
import 'package:adv_basics/screen/controllscreen.dart';
import 'package:adv_basics/screen/listvocabulary.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../model/user.dart';

class StartScreen extends StatefulWidget {
  const StartScreen(this.StartQuiz, {super.key});

  final void Function(String screen) StartQuiz;

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameCourseController = TextEditingController();

  String s = "Hiragana";

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
                      // ignore: avoid_print
                      setState(() {
                        s = _nameCourseController.text;
                      });
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => new ChooseCourse()));
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
                  "${s}",
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
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              const ListVocabulary(nameCourse: 'Hiragana')));
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
