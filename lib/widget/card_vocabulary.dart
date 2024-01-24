import 'dart:ffi';
import 'package:flutter/material.dart';

class CardVocabulary extends StatefulWidget {
  const CardVocabulary(
      {required this.nameWord,
      required this.meanWord,
      required this.id,
      required this.important,
      required this.complete,
      this.deleteFunction,
      this.updateFunction,
      this.createFunction,
      required this.color,
      super.key});

  final String nameWord;
  final String meanWord;
  final String id;
  final important;
  final complete;
  final Function? deleteFunction;
  final Function? updateFunction;
  final Function? createFunction;
  final Color color;

  @override
  State<CardVocabulary> createState() => _CardVocabularyState();
}

class _CardVocabularyState extends State<CardVocabulary> {
  bool isCheck = false;
  final _formKeyWord = GlobalKey<FormState>();
  final _formKeyWordMean = GlobalKey<FormState>();
  final TextEditingController _word = TextEditingController();
  final TextEditingController _meanWord = TextEditingController();
  String s = '';

  @override
  void dispose() {
    // Đảm bảo dispose controller khi không còn cần thiết
    _word.dispose();
    _meanWord.dispose();
    super.dispose();
  }

  void showSnackbar(String show) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: Duration(seconds: 3),
      content: Text(show),
    ));
  }

  void showForm(BuildContext context, String word, String mean) {
    // Gán giá trị ban đầu cho các controller
    _word.text = word;
    _meanWord.text = mean;

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: SingleChildScrollView(
                  child: Column(
                children: [
                  Form(
                      key: _formKeyWord,
                      child: TextFormField(
                        controller: _word, // Sử dụng controller
                        decoration: InputDecoration(
                            labelText: 'Enter word',
                            labelStyle: TextStyle(
                                color: const Color.fromARGB(255, 12, 80, 163),
                                fontWeight: FontWeight.bold)),
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return "Please input";
                          return null;
                        },
                      )),
                  Form(
                      key: _formKeyWordMean,
                      child: TextFormField(
                        controller: _meanWord, // Sử dụng controller
                        decoration: InputDecoration(
                            labelText: 'Enter mean of word',
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
                      String updatedWord = _word.text;
                      String updatedMeanWord = _meanWord.text;

                      Map<String, dynamic> word = {
                        'id': widget.id,
                        'name': updatedWord,
                        'mean': updatedMeanWord,
                        'important': widget.important,
                        'complete': widget.complete
                      };
                      Navigator.of(context).pop();
                      widget.updateFunction!(word);
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

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
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
                      widget.nameWord[0],
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
                      widget.nameWord,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.meanWord,
                    ),
                  ],
                )
              ],
            ),
            Row(
              children: [
                IconButton(
                    icon: Icon(
                      widget.important ? Icons.check_box : Icons.check_box_outline_blank,
                      color: const Color.fromARGB(255, 12, 80, 163),
                    ),
                    onPressed: () {
                      Map<String, dynamic> word = {
                          'id': widget.id,
                          'name': widget.nameWord,
                          'mean': widget.meanWord,
                          'important': !widget.important,
                          'complete': widget.complete
                        };
                      if (isCheck) {
                        widget.updateFunction!(word);
                        showSnackbar('Add difficult word');
                      } else {
                        widget.updateFunction!(word);
                        showSnackbar('Remove difficult word');
                      }
                     
                    }),
                IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: const Color.fromARGB(255, 12, 80, 163),
                    ),
                    onPressed: () {
                      showForm(context, widget.nameWord, widget.meanWord);
                    }),
                IconButton(
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onPressed: () => showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                            title: const Text('Delete'),
                            content: Text(widget.nameWord),
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
                                  widget.deleteFunction!(widget.id);
                                  Navigator.pop(context, false);
                                },
                                child: const Text('Delete',
                                    style: TextStyle(color: Colors.red)),
                              ),
                            ],
                          )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
