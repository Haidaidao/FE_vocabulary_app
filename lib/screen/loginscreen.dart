import 'package:adv_basics/screen/controllscreen.dart';
import 'package:adv_basics/screen/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/user.dart';
import '../service/handleResponse.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  void dispose() {
    // Đảm bảo dispose controller khi không còn cần thiết
    super.dispose();
    _username.dispose();
    _password.dispose();
  }

  void showSnackbar(String show) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: Duration(seconds: 3),
      content: Text(show),
    ));
  }

  Future<void> login(String username, String password) async {
    var url = Uri.parse('http://192.168.1.10:3001/v1/api/auth/login');
    Map<String, dynamic> request = {'username': username, 'password': password};

    try {
      var response = await http.post(
        url,
        body: request,
      );

      if (response.statusCode == 200) {
        Respone.handleResponse(response.body);
        final data = json.decode(response.body);
        print(data);
        Respone.writeFile(data['data']['_id'], data['data']['username'],
            data['data']['email'], data['data']['nameCourse'], data['data']['idCourse']);
        Respone.readFile();
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const ControllScreen("start-screen")));
      } else {
        showSnackbar("Login Error");
      }
    } catch (e) {
      print("Error when login");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      width: double.infinity,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/book_banner.png',
              width: 200,
              height: 200,
              color: const Color.fromARGB(255, 12, 80, 163),
            ),
            Text(
              'LOGIN',
              style: GoogleFonts.lato(
                  color: Color.fromARGB(255, 12, 80, 163),
                  fontSize: 20,
                  fontWeight: FontWeight.w900),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: _username,
              decoration: const InputDecoration(
                  labelText: 'Username',
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 2, color: Color.fromARGB(255, 12, 80, 163))),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 2, color: Color.fromARGB(255, 12, 80, 163))),
                  filled: true,
                  hintStyle: TextStyle(color: Color.fromARGB(255, 12, 80, 163)),
                  labelStyle:
                      TextStyle(color: Color.fromARGB(255, 12, 80, 163)),
                  contentPadding: EdgeInsets.all(8)),
              style: TextStyle(color: Color.fromARGB(255, 12, 80, 163)),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: _password,
              obscureText: true,
              decoration: const InputDecoration(
                  labelText: 'Password',
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 2, color: Color.fromARGB(255, 12, 80, 163))),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 2, color: Color.fromARGB(255, 12, 80, 163))),
                  filled: true,
                  hintStyle: TextStyle(color: Color.fromARGB(255, 12, 80, 163)),
                  labelStyle:
                      TextStyle(color: Color.fromARGB(255, 12, 80, 163)),
                  contentPadding: EdgeInsets.all(8)),
              style: TextStyle(color: Color.fromARGB(255, 12, 80, 163)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Don't have an account? ",
                  style: GoogleFonts.lato(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            const ControllScreen("signup-screen")));
                  },
                  child: Container(
                    child: Text(
                      "Sign up",
                      style: GoogleFonts.lato(
                          color: const Color.fromARGB(255, 12, 80, 163),
                          fontSize: 15,
                          fontWeight: FontWeight.w900),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                )
              ],
            ),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  login(_username.text, _password.text);
                },
                child: const Text('Confirm'),
                style: FilledButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 12, 80, 163)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
