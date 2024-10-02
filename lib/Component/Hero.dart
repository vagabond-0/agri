import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';

class CustomHero extends StatefulWidget {
  const CustomHero({super.key});

  @override
  _CustomHeroState createState() => _CustomHeroState();
}

class _CustomHeroState extends State<CustomHero> {
  String firstName = "Loading...";
  String lastName = "";

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    var box = await Hive.openBox('userBox'); 
    String username = box.get('username'); 

    final url = 'http://localhost:8080/farmer/getuser?username=$username';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          firstName = data['FarmerFirstName'];
          lastName = data['FarmerLastName'];
        });
      } else {
        setState(() {
          firstName = "Error";
          lastName = "Failed to load data";
        });
      }
    } catch (e) {
      setState(() {
        firstName = "Error";
        lastName = e.toString();
      });
    }
  }

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
                "$firstName $lastName", // Displaying the fetched name
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
