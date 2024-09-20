import 'package:agri/Component/CropSuggestion.dart';
import 'package:agri/Component/Hero.dart';
import 'package:agri/Component/TemperatureScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.location_on,
                  size: 30,
                  color: Colors.green,
                ),
                Icon(
                  Icons.account_circle,
                  size: 30,
                  color: Colors.green,
                )
              ],
              
            ),
            
          ),
           CustomHero(),
           Temperaturescreen(),
           CropSuggestion()
        ],
      ),
    );
  }
}