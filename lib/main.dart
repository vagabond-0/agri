import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login.dart';
import 'Homescreen.dart';
import 'Register.dart';
import 'bloc/weather_bloc.dart'; 

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool isLoggedIn = await _initializeHive();
  runApp(MyApp(isLoggedIn: isLoggedIn));
}

Future<bool> _initializeHive() async {
  try {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    await Hive.openBox('userBox');
    
    var box = Hive.box('userBox');
    String? username = box.get('username');
    
    return username != null;
  } catch (e) {
    print("Error initializing Hive: $e");
    return false;
  }
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  MyApp({required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherBloc(), // Replace with your bloc
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Agro App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: isLoggedIn ? '/home' : '/',
        routes: {
          '/': (context) => Login(),
          '/home': (context) => Homescreen(),
          '/register': (context) => Register(),
        },
      ),
    );
  }
}
