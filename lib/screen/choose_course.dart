import 'package:adv_basics/widget/card_course.dart';
import 'package:flutter/material.dart';

class ChooseCourse extends StatefulWidget {
  const ChooseCourse({super.key});

  @override
  State<ChooseCourse> createState() => _ChooseCourseState();
}

class _ChooseCourseState extends State<ChooseCourse> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your course', style: TextStyle(color: Colors.black),),
        backgroundColor: const Color.fromARGB(255, 239, 239, 225),
          leading: IconButton(
            onPressed: Navigator.of(context).pop,
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
      ),
      body: SafeArea(
        child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 239, 239, 225),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: const Text(
                      'Current course',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          fontSize: 20),
                    ),
                  ),
                  const CardCourse(name: 'Hiragana', numWord: 45, color: Color.fromARGB(255, 12, 80, 163),),
                  const SizedBox(height: 10,),
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: const Text(
                      'Other course',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          fontSize: 20),
                    ),
                  ),
                  const CardCourse(name: 'Hiragana', numWord: 45, color: Color.fromARGB(255, 97, 9, 2),),
                  const CardCourse(name: 'Hiragana', numWord: 45, color: Color.fromARGB(255, 97, 9, 2),),
                  const CardCourse(name: 'Hiragana', numWord: 45, color: Color.fromARGB(255, 97, 9, 2),),
                  const CardCourse(name: 'Hiragana', numWord: 45, color: Color.fromARGB(255, 97, 9, 2),),
                  const CardCourse(name: 'Hiragana', numWord: 45, color: Color.fromARGB(255, 97, 9, 2),),
                  const CardCourse(name: 'Hiragana', numWord: 45, color: Color.fromARGB(255, 97, 9, 2),),
                  const CardCourse(name: 'Hiragana', numWord: 45, color: Color.fromARGB(255, 97, 9, 2),),
                  const CardCourse(name: 'Hiragana', numWord: 45, color: Color.fromARGB(255, 97, 9, 2),),
                  const CardCourse(name: 'Hiragana', numWord: 45, color: Color.fromARGB(255, 97, 9, 2),),
                  const CardCourse(name: 'Hiragana', numWord: 45, color: Color.fromARGB(255, 97, 9, 2),),
                  const CardCourse(name: 'Hiragana', numWord: 45, color: Color.fromARGB(255, 97, 9, 2),),
                  const CardCourse(name: 'Hiragana', numWord: 45, color: Color.fromARGB(255, 97, 9, 2),),
                  const CardCourse(name: 'Hiragana', numWord: 45, color: Color.fromARGB(255, 97, 9, 2),),
                  
                ],
              ),
            ),
          ),
        ),
      
    );
  }
}
