import 'package:adv_basics/widget/card_vocabulary.dart';
import 'package:flutter/material.dart';

class ListVocabulary extends StatefulWidget {
  const ListVocabulary({required this.nameCourse, super.key});
  final String nameCourse;

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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CardVocabulary(
                    nameWord: "ascdsv",
                    meanWord: "sdvsdgfverg",
                    color: Colors.green),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
