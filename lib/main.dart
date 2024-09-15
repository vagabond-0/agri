import 'package:flutter/material.dart';
import 'login.dart'; // Import your login screen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agro App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(), // Set LoginPage as the initial route
        '/home': (context) => HomePage(), // Define your home page route
      },
    );
  }
}
