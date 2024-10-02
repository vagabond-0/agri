import 'package:agri/Homescreen.dart';
import 'package:flutter/material.dart';
import 'login.dart'; 

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Agro App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => Homescreen(),
        '/home': (context) =>const  Homescreen(), 
      },
    );
  }
}
