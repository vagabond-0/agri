import 'package:agri/models/CropModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hive/hive.dart'; // Add Hive import

class UserCrop extends StatefulWidget {
  const UserCrop({super.key});

  @override
  _UserCropState createState() => _UserCropState();
}

class _UserCropState extends State<UserCrop> {
  List<Crop> crops = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCrops();
  }

  Future<void> fetchCrops() async {
    try {
      // Open the Hive box to get the stored userId
      var box = await Hive.openBox('userBox');
      String? userId = box.get('userId');

      if (userId != null) {
        final response = await http.post(
          Uri.parse('http://localhost:8080/Register/getUserCrop?userId=$userId'),
        );

        if (response.statusCode == 200) {
          List jsonResponse = json.decode(response.body);
          setState(() {
            crops = jsonResponse.map((crop) => Crop.fromJson(crop)).toList();
            isLoading = false;
          });
        } else {
          throw Exception('Failed to load crops');
        }
      } else {
        throw Exception('No userId found in Hive');
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching crops: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : buildCropList();
  }

  Widget buildCropList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Aligns the heading to the start
      children: [
        // Heading with icon
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'User Crops',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              const Icon(Icons.grass, size: 30, color: Colors.green), // Icon for crops
              
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 250, // Adjust height as necessary for horizontal scrolling
            child: ListView.builder(
              scrollDirection: Axis.horizontal, // Make it horizontal
              itemCount: crops.length,
              itemBuilder: (context, index) {
                final crop = crops[index];
                return cropCard(crop);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget cropCard(Crop crop) {
    return Container(
      width: 220, // Adjust width for horizontal layout
      margin: const EdgeInsets.only(right: 16), // Margin for spacing between cards
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
        children: [
          const Icon(
            Icons.grass,
            size: 40,
            color: Colors.white,
          ),
          const SizedBox(height: 8),
          Text(
            crop.cropName,
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Weather: ${crop.weatherStart}°C - ${crop.weatherEnd}°C",
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Humidity: ${crop.humidityStart}% - ${crop.humidityEnd}%",
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Harvest Time: ${crop.TimeRequiredForHarvest} days",
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Soil: ${crop.soilType} (pH: ${crop.soilPh})",
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Market Price: ₹${crop.marketPrice}",
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
