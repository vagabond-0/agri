import 'dart:convert';
import 'package:agri/Component/CropSuggestion.dart';
import 'package:agri/Component/Hero.dart';
import 'package:agri/Component/TemperatureScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  List<dynamic> crops = [];
  String? selectedCrop;
  String? farmerId; 
  DateTime registeredMonth = DateTime.now(); 

  @override
  void initState() {
    super.initState();
    _loadFarmerId(); 
    fetchCrops();
  }

  Future<void> _loadFarmerId() async {
    var box = await Hive.openBox('userBox'); 
    setState(() {
      farmerId = box.get('userId'); 
    });
  }

  Future<void> fetchCrops() async {
    final response = await http.get(Uri.parse('http://localhost:8080/crop/getcrop'));

    if (response.statusCode == 200) {
      setState(() {
        crops = jsonDecode(response.body);
      });
    } else {
      throw Exception('Failed to load crops');
    }
  }

  Future<void> registerCrop(String cropId) async {
    final response = await http.post(
      Uri.parse('http://localhost:8080/Register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'farmerId': farmerId, 
        'cropId': cropId,
        'registeredMonth': registeredMonth.toIso8601String().split("T")[0], 
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Crop registered successfully');
    } else {
      throw Exception('Failed to register crop');
    }
  }

  void _showAddCropDialog() {
  String? localSelectedCrop;
  String selectedCropName = "Select a Crop";

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text("Select a Crop"),
            content: DropdownButton<String>(
              isExpanded: true,
              value: localSelectedCrop,
              hint: Text(selectedCropName),
              onChanged: (String? newValue) {
                setState(() {
                  localSelectedCrop = newValue;
                  selectedCropName = crops.firstWhere((crop) => crop['id'] == newValue)['cropName'];
                  debugPrint("Selected Crop ID: $localSelectedCrop");
                });
              },
              items: crops.map<DropdownMenuItem<String>>((crop) {
                return DropdownMenuItem<String>(
                  value: crop['id'],
                  child: Text(crop['cropName']),
                );
              }).toList(),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                  if (localSelectedCrop != null) {
                    registerCrop(localSelectedCrop!);
                    debugPrint("Selected Crop ID: $localSelectedCrop");
                    Navigator.of(context).pop();
                  } else {
                    debugPrint("No crop selected");
                  }
                },
              ),
            ],
          );
        },
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
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
          const CustomHero(),
          const Temperaturescreen(),
          const CropSuggestion(),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ElevatedButton(
          onPressed: () {
            _showAddCropDialog(); 
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            padding: const EdgeInsets.symmetric(vertical: 15.0),
          ),
          child: const Text(
            'Add Crop',
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
