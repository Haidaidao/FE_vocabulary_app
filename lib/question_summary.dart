import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionSummery extends StatelessWidget {
  const QuestionSummery(this.sumaryData, {super.key});

  final List<Map<String, Object>> sumaryData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: SingleChildScrollView(
        child: Column(
          children: sumaryData.map((data) {
            return Row(
              children: [
                Container(
                  width: 30, // Kích thước hình tròn
                  height: 30,
                  decoration: ShapeDecoration(
                    shape: CircleBorder(),
                    color: data['user_answer']==data['correct_answer']
                            ? Colors.blue
                            : Color.fromARGB(255, 194, 32, 32)
                  ),
                  child: Align(
                    alignment: Alignment.center,  
                    child: Text(((data['question_index'] as int) + 1).toString(),
                        style: GoogleFonts.lato(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            data['question'] as String,
                            style: GoogleFonts.lato(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          data['user_answer'] as String,
                          style: TextStyle(color: Color.fromARGB(255, 198, 96, 201)),
                        ),
                        Text(
                          data['correct_answer'] as String,
                          style: TextStyle(color: Colors.blue),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
