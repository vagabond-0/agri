import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CropSuggestion extends StatelessWidget {
  const CropSuggestion({super.key});

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
            child: ListView(
              scrollDirection: Axis.horizontal, // Horizontal scrolling
              children: [
                cropCard("Wheat", "25°C", Colors.orangeAccent),
                cropCard("Rice", "30°C", Colors.lightBlueAccent),
                cropCard("Corn", "28°C", Colors.greenAccent),
                cropCard("Barley", "24°C", Colors.pinkAccent),
                cropCard("Soybean", "27°C", Colors.purpleAccent),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Reusable function to create crop cards
  Widget cropCard(String cropName, String temperature, Color bgColor) {
    return Container(
      width: 120, // Fixed width for each crop card
      margin: const EdgeInsets.only(right: 16), // Space between cards
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: bgColor, // Background color based on crop
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
            cropName, // Crop name
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            temperature, // Temperature for the crop
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
