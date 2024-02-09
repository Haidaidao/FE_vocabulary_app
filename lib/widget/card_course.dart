import 'dart:ffi';
import 'package:adv_basics/model/user.dart';
import 'package:adv_basics/screen/controllscreen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import '../service/handleResponse.dart';

class CardCourse extends StatefulWidget {
  const CardCourse(
      {required this.id,
      required this.name,
      required this.deleteFunction,
      required this.updateFunction,
      required this.updateUser,
      required this.numWord,
      required this.color,
      super.key});

  final String name;
  final int numWord;
  final Color color;
  final String id;
  final Function deleteFunction;
  final Function updateFunction;
  final Function updateUser;

  @override
  State<CardCourse> createState() => _CardCourseState();
}

class _CardCourseState extends State<CardCourse> {
  final _formKeyName = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();

  void showForm(BuildContext context, String name, String id) {
    // Gán giá trị ban đầu cho các controller
    _name.text = name;

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: SingleChildScrollView(
                  child: Column(
                children: [
                  Form(
                      key: _formKeyName,
                      child: TextFormField(
                        controller: _name, // Sử dụng controller
                        decoration: InputDecoration(
                            labelText: 'Enter name of course',
                            labelStyle: TextStyle(
                                color: const Color.fromARGB(255, 12, 80, 163),
                                fontWeight: FontWeight.bold)),
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return "Please input";
                          return null;
                        },
                      )),
                ],
              )),
              actions: [
                TextButton(
                    onPressed: () {
                      // Lấy giá trị từ các controller
                      String name = _name.text;

                      Map<String, dynamic> course = {
                        'id': widget.id,
                        'name': name,
                      };
                      Navigator.of(context).pop();
                      widget.updateFunction!(course);
                    },
                    child: Text(
                      'Confirm',
                      style: TextStyle(
                          color: const Color.fromARGB(255, 12, 80, 163)),
                    )),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Colors.red),
                    )),
              ],
            ));
  }

  void updateUser(user) async {
    final response = await http.put(
      Uri.parse('http://192.168.1.10:3001/v1/api/users'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(user),
    );

    if (response.statusCode == 200) {
      print("Data user successfully");
      setState(() {});
    } else {
      // Xử lý lỗi
      throw Exception('Failed to course data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: () {
          User.setIdCourse(widget.id);
          User.setNameCourse(widget.name);
          Map<String, dynamic> user = {
            'id': User.getId(),
            'username': User.getUsername(),
            'idCourse': widget.id,
            'nameCourse': widget.name
          };
          updateUser(user);
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ControllScreen('start-screen')),
          );
        },
        child: Container(
          decoration: const BoxDecoration(color: Colors.white),
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: widget.color),
                    child: Center(
                      child: Text(
                        widget.name[0],
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(widget.numWord.toString())
                    ],
                  )
                ],
              ),
              Row(
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: const Color.fromARGB(255, 12, 80, 163),
                      ),
                      onPressed: () {
                        showForm(context, widget.name, widget.id);
                      }),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                              title: const Text('Delete course'),
                              content: Text(widget.name),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context, false);
                                    },
                                    child: const Text('Cancel',
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 12, 80, 163)))),
                                TextButton(
                                  onPressed: () {
                                    widget.deleteFunction(widget.id);
                                    Navigator.pop(context, false);
                                  },
                                  child: const Text('Delete',
                                      style: TextStyle(color: Colors.red)),
                                ),
                              ],
                            )),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
