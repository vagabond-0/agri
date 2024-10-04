import 'package:agri/Component/CropSuggestion.dart';
import 'package:agri/Component/Hero.dart';
import 'package:agri/Component/TemperatureScreen.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 30,
                      color: Colors.green,
                    ),
                    Builder(
                      builder: (context) => PopupMenuButton<String>(
                        icon: const Icon(Icons.account_circle),
                        onSelected: (value) async {
                          if (value == 'Profile') {
                            Navigator.pushReplacementNamed(context, '/profile');
                          } else if (value == 'Logout') {
                            var box = await Hive.openBox('userBox');
                            await box.delete('username');
                            await box.close();
                            if (context.mounted) {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  '/', (Route<dynamic> route) => false);
                            }
                          }
                        },
                        itemBuilder: (BuildContext context) {
                          return {'Profile', 'Logout'}.map((String choice) {
                            return PopupMenuItem<String>(
                              value: choice,
                              child: Text(choice),
                            );
                          }).toList();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const CustomHero(),
              const Temperaturescreen(),
              const CropSuggestion(),
            ],
          ),
        ),
      ),
    );
  }
}
