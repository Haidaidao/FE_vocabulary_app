import 'package:adv_basics/screen/controllscreen.dart';
import 'package:adv_basics/screen/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
              const TextField(
                decoration: InputDecoration(
                    labelText: 'Username',
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 2, color: Color.fromARGB(255, 12, 80, 163))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 2, color: Color.fromARGB(255, 12, 80, 163))),
                    filled: true,
                    hintStyle:
                        TextStyle(color: Color.fromARGB(255, 12, 80, 163)),
                    labelStyle:
                        TextStyle(color: Color.fromARGB(255, 12, 80, 163)),
                    contentPadding: EdgeInsets.all(8)),
                style: TextStyle(color: Color.fromARGB(255, 12, 80, 163)),
              ),
              SizedBox(
                height: 10,
              ),
              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                    labelText: 'Password',
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 2, color: Color.fromARGB(255, 12, 80, 163))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 2, color: Color.fromARGB(255, 12, 80, 163))),
                    filled: true,
                    hintStyle:
                        TextStyle(color: Color.fromARGB(255, 12, 80, 163)),
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
                          builder: (context) => const ControllScreen("signup-screen")));
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
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ControllScreen("start-screen")));
                  },
                  child: const Text('Confirm'),
                  style: FilledButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 12, 80, 163)),
                ),
              ),
              Text(
                'OR',
                style:
                    GoogleFonts.lato(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                    onPressed: () {
                      
                    },
                    icon: Icon(Icons.email),
                    label: Text("Login with email"),
                    style: FilledButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 12, 80, 163))),
              )
            ],
          ),
        ),
    );
  }
}
