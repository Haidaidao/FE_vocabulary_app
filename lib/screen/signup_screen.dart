import 'package:adv_basics/screen/controllscreen.dart';
import 'package:adv_basics/screen/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/user.dart';
import '../service/handleResponse.dart';
import '../service/url.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  void dispose() {
    // Đảm bảo dispose controller khi không còn cần thiết
    super.dispose();
    _username.dispose();
    _password.dispose();
    _email.dispose();
  }

  void showSnackbar(String show) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: Duration(seconds: 3),
      content: Text(show),
    ));
  }

  void navigateLogin() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const ControllScreen("login-screen")));
  }

  Future<void> register(String username, String email, String password) async {
    var url = Uri.parse('http://192.168.1.10:3001/v1/api/auth/register');
    Map<String, dynamic> request = {
      'username': username,
      'email': email,
      'password': password
    };
    try {
      var response = await http.post(
        url,
        body: request,
      );

      Map<String, dynamic> parsedJson = json.decode(response.body);
      if (response.statusCode == 200) {
        Respone.handleResponse(response.body);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const ControllScreen("start-screen")));
      } else {
        showSnackbar(parsedJson["msg"]);
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
              'SIGN UP',
              style: GoogleFonts.lato(
                  color: const Color.fromARGB(255, 12, 80, 163),
                  fontSize: 20,
                  fontWeight: FontWeight.w900),
            ),
            const SizedBox(
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
              keyboardType: TextInputType.emailAddress,
              controller: _email,
              decoration: const InputDecoration(
                  labelText: 'Email',
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
              obscureText: true,
              controller: _password,
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
                  "Do you have an account? ",
                  style: GoogleFonts.lato(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: navigateLogin,
                  child: Container(
                    child: Text(
                      "Login ",
                      style: GoogleFonts.lato(
                          color: Color.fromARGB(255, 12, 80, 163),
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
                  register(_username.text, _email.text, _password.text);
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
