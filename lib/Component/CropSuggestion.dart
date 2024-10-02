import 'dart:convert';
import 'package:agri/models/CropModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

class CropSuggestion extends StatefulWidget {
  const CropSuggestion({Key? key}) : super(key: key);

  @override
  _CropSuggestionState createState() => _CropSuggestionState();
}

class _CropSuggestionState extends State<CropSuggestion> {
  List<Crop> crops = [];

  @override
  void initState() {
    super.initState();
    fetchCrops();
  }

  Future<void> fetchCrops() async {
    final response = await http.get(
      Uri.parse('http://localhost:8080/crop/suggestionByWeatherAndMonth?weather=25&month=2024-08-15'),
    );

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      setState(() {
        crops = jsonResponse.map((crop) => Crop.fromJson(crop)).toList();
      });
    } else {
      throw Exception('Failed to load crops');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align text to start
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Suggestion From Today's Weather",
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              Icon(
                Icons.grass, // Crop icon
                size: 40,
                color: Colors.green,
              ),
            ],
          ),
          const SizedBox(height: 16), // Space between the row and the scrollable list

          // Horizontal scrollable list of crop suggestions
          SizedBox(
            height: 150, // Fixed height for the crop cards
            child: ListView.builder(
              scrollDirection: Axis.horizontal, // Horizontal scrolling
              itemCount: crops.length,
              itemBuilder: (context, index) {
                final crop = crops[index];
                return cropCard(crop);
              },
            ),
          ),
        ],
      ),
    );
  }

  // Reusable function to create crop cards
  Widget cropCard(Crop crop) {
    return Container(
      width: 120, // Fixed width for each crop card
      margin: const EdgeInsets.only(right: 16), // Space between cards
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent, // Set a default background color
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.wb_sunny, // Sun icon for temperature
            size: 40,
            color: Colors.white,
          ),
          const SizedBox(height: 8),
          Text(
            crop.cropName, // Crop name
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "${crop.weatherStart}°C - ${crop.weatherEnd}°C", // Weather range for the crop
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Time: ${crop.timeRequiredForHarvest} days", // Time to harvest
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
