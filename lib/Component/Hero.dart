import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomHero extends StatelessWidget {
  const CustomHero({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch, 
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Welcome",
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 40,
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end, 
            children: [
              Text(
                "Amalendu Manoj",
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 28,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
