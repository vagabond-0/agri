import 'dart:convert';
import 'package:agri/Component/CropSuggestion.dart';
import 'package:agri/Component/Hero.dart';
import 'package:agri/Component/TemperatureScreen.dart';
import 'package:agri/Component/userscrop.dart';
import 'package:agri/bloc/weather_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';
import 'package:geolocator/geolocator.dart';

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
  Position? _currentPosition;
  bool _locationAccessed = false;

  @override
  void initState() {
    super.initState();
    _loadFarmerId();
    fetchCrops();
  }

  Future<void> _getCurrentLocation(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    // Check location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return;
    }

    // Get the current location
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      _currentPosition = position;
      _locationAccessed =
          true; // Update state to reflect that location is accessed
    });

    // Fetch weather data using the location
    context.read<WeatherBloc>().add(Fetchweather(position));
  }

  Future<void> _loadFarmerId() async {
    var box = await Hive.openBox('userBox');
    setState(() {
      farmerId = box.get('userId');
    });
  }

  Future<void> fetchCrops() async {
    try {
      final response =
          await http.get(Uri.parse('http://localhost:8080/crop/getcrop'));

      if (response.statusCode == 200) {
        setState(() {
          crops = jsonDecode(response.body);
        });
      } else {
        throw Exception('Failed to load crops');
      }
    } catch (e) {
      print('Error fetching crops: $e');
    }
  }

  Future<void> registerCrop(String cropId) async {
    try {
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
    } catch (e) {
      print('Error registering crop: $e');
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
                    selectedCropName = crops.firstWhere(
                        (crop) => crop['id'] == newValue)['cropName'];
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      // Add your onClick code here
                      _getCurrentLocation(context);
                    },
                    child: const Icon(
                      Icons.location_on,
                      size: 30,
                      color: Color.fromARGB(255, 116, 194, 118),
                    ),
                  ),
                  Builder(
                    builder: (context) => PopupMenuButton<String>(
                      icon: const Icon(
                        Icons.account_circle,
                        size: 30,
                        color: Color.fromARGB(255, 116, 194, 118),
                      ),
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
            _locationAccessed
                ? const TemperatureScreen()
                : const Text("Enable location to view temperature",
                    style: TextStyle(color: Colors.grey)),
            const CropSuggestion(),
            const UserCrop()
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ElevatedButton(
          onPressed: () {
            _showAddCropDialog();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 116, 194, 118),
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
