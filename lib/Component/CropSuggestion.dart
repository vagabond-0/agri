import 'dart:convert';
import 'package:agri/bloc/weather_bloc.dart';
import 'package:agri/models/CropModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:weather/weather.dart';

class CropSuggestion extends StatefulWidget {
  const CropSuggestion({super.key});

  @override
  _CropSuggestionState createState() => _CropSuggestionState();
}

class _CropSuggestionState extends State<CropSuggestion> {
  List<Crop> crops = [];
  bool isFetchingCrops = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        if (state is WeatherSuccess) {
          if (!isFetchingCrops) {
            fetchCrops(state.weather.temperature);
          }
          return buildCropSuggestion();
        } else if (state is WeatherLoading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return const Center(
            child: Text('Please provide location access for crop suggestions.'),
          );
        }
      },
    );
  }

  Future<void> fetchCrops(Temperature? temperature) async {
    setState(() {
      isFetchingCrops = true;
    });

    final response = await http.get(
      Uri.parse(
          'http://localhost:8080/crop/suggestionByWeatherAndMonth?weather=$temperature&month=${DateTime.now().toIso8601String().substring(0, 10)}'),
    );

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      setState(() {
        crops = jsonResponse.map((crop) => Crop.fromJson(crop)).toList();
        isFetchingCrops = false;
      });
    } else {
      setState(() {
        isFetchingCrops = false;
      });
      throw Exception('Failed to load crops');
    }
  }

  Widget buildCropSuggestion() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
              const Icon(
                Icons.grass, 
                size: 40,
                color: Colors.green,
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
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

  Widget cropCard(Crop crop) {
    return Container(
      width: 120,
      height: 200,
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.wb_sunny,
            size: 40,
            color: Colors.white,
          ),
          const SizedBox(height: 8),
          Text(
            crop.cropName,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "${crop.weatherStart}°C - ${crop.weatherEnd}°C",
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Time: ${crop.timeRequiredForHarvest} days",
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
