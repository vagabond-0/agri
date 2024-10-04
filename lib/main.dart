import 'package:agri/Component/crop.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'login.dart';
import 'Homescreen.dart';
import 'Register.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    await Hive.openBox('userBox');

    var box = Hive.box('userBox');
    String? username = box.get('username');

    runApp(MyApp(isLoggedIn: username != null));
  } catch (e) {
    // Handle initialization errors
    runApp(MyApp(isLoggedIn: false)); // You can change this behavior
    print("Error initializing Hive: $e");
  }
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Agro App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: isLoggedIn ? '/home' : '/',
      routes: {
        '/': (context) => Login(),
        '/home': (context) => const Homescreen(),
        '/register': (context) => Register(),
      },
    );
  }
}
