import 'package:adv_basics/widget/card_vocabulary.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import '../service/handleResponse.dart';
import '../model/user.dart';

class ListVocabulary extends StatefulWidget {
  const ListVocabulary({required this.nameCourse, super.key});
  final String? nameCourse;

  @override
  State<ListVocabulary> createState() => _ListVocabularyState();
}

class _ListVocabularyState extends State<ListVocabulary> {
  final _formKeyWord = GlobalKey<FormState>();
  final _formKeyWordMean = GlobalKey<FormState>();
  final TextEditingController _word = TextEditingController();
  final TextEditingController _meanWord = TextEditingController();
  String s = '';

  void showForm(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: SingleChildScrollView(
                  child: Column(
                children: [
                  Form(
                      key: _formKeyWord,
                      child: TextFormField(
                        controller: _word,
                        decoration: InputDecoration(
                            labelText: 'Enter word',
                            labelStyle: TextStyle(
                                color: const Color.fromARGB(255, 12, 80, 163),
                                fontWeight: FontWeight.bold)),
                      )),
                  Form(
                      key: _formKeyWordMean,
                      child: TextFormField(
                        controller: _meanWord,
                        decoration: InputDecoration(
                            labelText: 'Enter mean of word',
                            labelStyle: TextStyle(
                                color: const Color.fromARGB(255, 12, 80, 163),
                                fontWeight: FontWeight.bold)),
                      )),
                ],
              )),
              actions: [
                TextButton(
                    onPressed: () {
                      // Lấy giá trị từ các controller
                      String Word = _word.text;
                      String MeanWord = _meanWord.text;

                      Map<String, dynamic> word = {
                        'name': Word,
                        'mean': MeanWord,
                        'important': 0,
                        'complete': 0
                      };
                      Navigator.of(context).pop();
                      createWord(word);
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

  Future<List<dynamic>> getVocabularyCourse(id) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.1.10:3001/v1/api/get_vocabulary_course'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({'id': id}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['error'] == 0) {
          return data['data'][0];
        }
      }
      print("Error: ${response.statusCode}");
    } catch (e) {
      print("Error: $e");
    }
    return []; // Trả về danh sách trống nếu có lỗi
  }

  void deleteWord(id) async {
    final response = await http.delete(
      Uri.parse('http://192.168.1.10:3001/v1/api/vocabulary'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode({'id': id}),
    );

    if (response.statusCode == 200) {
      print("Data deleted successfully");
      setState(() {});
    } else {
      // Xử lý lỗi
      throw Exception('Failed to delete data');
    }
  }

  void updateWord(word) async {
    final response = await http.put(
      Uri.parse('http://192.168.1.10:3001/v1/api/vocabulary'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(word),
    );

    if (response.statusCode == 200) {
      print("Data deleted successfully");
      setState(() {});
    } else {
      // Xử lý lỗi
      throw Exception('Failed to delete data');
    }
  }

  void createWord(word) async {
    final response = await http.post(
      Uri.parse('http://192.168.1.10:3001/v1/api/vocabulary'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(word),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
     
      print(responseData['data']);
      Map<String, dynamic> wordAdd = {
        'type': "ADD-WORD",
        'courseId': "65a8ce9ff9e3a73bf94bbdd4",
        'wordsArr': [responseData["data"]["_id"]]
      };

      final response2 = await http.post(
        Uri.parse('http://192.168.1.10:3001/v1/api/course'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(wordAdd),
      );

      if (response2.statusCode == 200) {
        print("Data create successfully");

        setState(() {});
      } else {
        // Xử lý lỗi
        throw Exception('Failed to create data');
      }
    } else {
      // Xử lý lỗi
      throw Exception('Failed to create data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Words of ${widget.nameCourse}',
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: Color.fromARGB(255, 239, 239, 225),
        leading: IconButton(
          onPressed: Navigator.of(context).pop,
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        actions: [
          TextButton.icon(
            label: const Text('Add word'),
            onPressed: () {
              showForm(context);
            },
            icon: Icon(Icons.add_circle),
            style: TextButton.styleFrom(
                foregroundColor: const Color.fromARGB(255, 12, 80, 163)),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 239, 239, 225),
          ),
          child: FutureBuilder<List<dynamic>>(
            future: getVocabularyCourse(User.getIdCourse()),
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
                    var word = snapshot.data![index];
                    return CardVocabulary(
                      nameWord: word['name'],
                      meanWord: word['mean'],
                      id: word['_id'],
                      complete: word['complete'],
                      important: word['important'],
                      deleteFunction: deleteWord,
                      updateFunction: updateWord,
                      color: Colors.green,
                    );
                  },
                );
              }
              return Center(child: Text('No data'));
            },
          ),
        ),
      ),
    );
  }
}
