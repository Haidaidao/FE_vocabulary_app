import 'dart:ffi';
import 'package:flutter/material.dart';

class CardVocabulary extends StatefulWidget {
  const CardVocabulary(
      {required this.nameWord,
      required this.meanWord,
      required this.color,
      super.key});

  final String nameWord;
  final String meanWord;
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
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: SingleChildScrollView(
                  child: Column(
                children: [
                  Form(
                      key: _formKeyWord,
                      child: TextFormField(
                        initialValue: word,
                        decoration: InputDecoration(
                            labelText: 'Enter word',
                            labelStyle: TextStyle(
                                color: const Color.fromARGB(255, 12, 80, 163),
                                fontWeight: FontWeight.bold)),
                        validator: (value) {
                          if (value == null) return "Please input";
                          return null;
                        },
                      )),
                  Form(
                      key: _formKeyWordMean,
                      child: TextFormField(
                        initialValue: mean,
                        decoration: InputDecoration(
                            labelText: 'Enter mean of word',
                            labelStyle: TextStyle(
                                color: const Color.fromARGB(255, 12, 80, 163),
                                fontWeight: FontWeight.bold)),
                        validator: (value) {
                          if (value == null) return "Please input";
                          return null;
                        },
                      )),
                ],
              )),
              actions: [
                TextButton(
                    onPressed: () {
                      // ignore: avoid_print
                      setState(() {
                        s = _word.text;
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
                      isCheck ? Icons.check_box : Icons.check_box_outline_blank,
                      color: const Color.fromARGB(255, 12, 80, 163),
                    ),
                    onPressed: () {
                      setState(() {
                        isCheck = !isCheck;
                        if (isCheck)
                          showSnackbar('Add difficult word');
                        else
                          showSnackbar('Remove difficult word');
                      });
                    }),
                IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: const Color.fromARGB(255, 12, 80, 163),
                    ),
                    onPressed: () {
                      showForm(context, 'a', 'b');
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
