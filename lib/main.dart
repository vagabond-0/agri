import 'package:agri/Component/UsercropPage.dart';
import 'package:agri/Component/crop.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login.dart';
import 'Homescreen.dart';
import 'Register.dart';
import 'Profile.dart';
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

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Agro App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: isLoggedIn ? '/home' : '/',
        onGenerateRoute: (settings) {
          if (settings.name!.startsWith('/crop/')) {
            final cropId = settings.name!.split('/').last;
            return MaterialPageRoute(
              builder: (context) => AgroMonitoringPage(cropId: cropId),
            );
          }else{
            if(settings.name!.startsWith('/usercrop/')){
              final cropId = settings.name!.split('/').last;
            return MaterialPageRoute(
              builder: (context) => CropDetailPage(cropId: cropId),
            );
            }
          }
          return null;
        },
        routes: {
          '/': (context) => Login(),
          '/home': (context) => Homescreen(),
          '/register': (context) => Register(),
          '/profile': (context) => Profile(),
        },
      ),
    );
  }
}