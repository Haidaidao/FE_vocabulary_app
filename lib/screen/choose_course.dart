import 'package:adv_basics/widget/card_course.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/user.dart';
import '../service/handleResponse.dart';

class ChooseCourse extends StatefulWidget {
  const ChooseCourse({super.key, required this.lengthCurrentCourse});
  final lengthCurrentCourse;
  @override
  State<ChooseCourse> createState() => _ChooseCourseState();
}

class _ChooseCourseState extends State<ChooseCourse> {
  Future<List<dynamic>> getCourse(id) async {
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
          return data['data'];
        }
      }
      print("Error: ${response.statusCode}");
    } catch (e) {
      print("Error: $e");
    }
    return []; // Trả về danh sách trống nếu có lỗi
  }

  void deleteCourse(id) async {
    final response = await http.delete(
      Uri.parse('http://192.168.1.10:3001/v1/api/course'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode({'id': id}),
    );

    if (response.statusCode == 200) {
      setState(() {});
    } else {
      // Xử lý lỗi
      throw Exception('Failed to delete data');
    }
  }

  void updateWord(course) async {
    final response = await http.put(
      Uri.parse('http://192.168.1.10:3001/v1/api/course'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(course),
    );

    if (response.statusCode == 200) {
      if (User.getIdCourse() == course['id'])
        User.setNameCourse(course['name']);

      print("Data course successfully");
      setState(() {});
    } else {
      // Xử lý lỗi
      throw Exception('Failed to course data');
    }
  }

  void updateUser(user) async {
    print("========");
    print(user);
    final response = await http.put(
      Uri.parse('http://192.168.1.10:3001/v1/api/users'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(user),
    );

    if (response.statusCode == 200) {
      print("Data user successfully");
      // setState(() {});
    } else {
      // Xử lý lỗi
      throw Exception('Failed to course data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your course',
          style: TextStyle(color: Colors.black),
        ),
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
              CardCourse(
                id: User.getIdCourse(),
                name: User.getNameCourse(),
                deleteFunction: deleteCourse,
                updateFunction: updateWord,
                updateUser: updateUser,
                numWord: widget.lengthCurrentCourse,
                color: Color.fromARGB(255, 12, 80, 163),
              ),
              const SizedBox(
                height: 10,
              ),
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
              Expanded(
                child: FutureBuilder<List<dynamic>>(
                  future: getCourse(User.getId()),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          var course = snapshot.data![index];
                          return CardCourse(
                            id: course["_id"],
                            name: course['name'],
                            deleteFunction: deleteCourse,
                            updateFunction: updateWord,
                            updateUser: updateUser,
                            numWord: course['listVocabulary'].length,
                            color: Color.fromARGB(255, 97, 9, 2),
                          );
                        },
                      );
                    }
                    return Center(child: Text('No data'));
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
