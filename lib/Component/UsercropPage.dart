import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:agri/models/usercropModel.dart';

class CropDetailPage extends StatefulWidget {
  final String cropId;

  const CropDetailPage({Key? key, required this.cropId}) : super(key: key);

  @override
  _CropDetailPageState createState() => _CropDetailPageState();
}

class _CropDetailPageState extends State<CropDetailPage> {
  late Future<UserCrop> futureCrop;

  @override
  void initState() {
    super.initState();
    futureCrop = fetchCropDetails();
  }

  Future<UserCrop> fetchCropDetails() async {
    final response = await http.get(Uri.parse('http://localhost:8080/crop/${widget.cropId}'));

    if (response.statusCode == 200) {
      return UserCrop.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load crop details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F0E6),
      body: FutureBuilder<UserCrop>(
        future: futureCrop,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return _buildCropDetails(snapshot.data!);
          } else {
            return Center(child: Text('No data available'));
          }
        },
      ),
    );
  }

  Widget _buildCropDetails(UserCrop crop) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.arrow_back_ios),
                ),
                Text(
                  crop.cropName,
                  style: GoogleFonts.abel(
                    color: const Color.fromARGB(255, 194, 146, 24),
                    fontSize: 35,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              image: const DecorationImage(
                image: AssetImage('assets/images/wheat.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 20),
          _buildInfoCard('Temperature', '${crop.weatherStart}°C - ${crop.weatherEnd}°C', Icons.thermostat),
          _buildInfoCard('Humidity', '${crop.humidityStart}% - ${crop.humidityEnd}%', Icons.water_drop),
          _buildInfoCard('Market Price', '₹${crop.marketPrice}/kg', Icons.currency_rupee),
          _buildInfoCard('Days remaining to harvest:', '${crop.daysRemaining}', Icons.water),
          _buildInfoCard('Watering', crop.timeWater, Icons.landscape),
          _buildInfoCard('Harvest Time', '${crop.timeRequiredForHarvest} days', Icons.access_time),
          _buildInfoCard('Suitable Months', '${crop.suitableMonthStart} - ${crop.suitableMonthEnd}', Icons.calendar_today),
          // _buildInfoCard('Remaining Days Until Harvest', '${crop.}', Icons.hourglass_bottom),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title, String value, IconData icon) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: GoogleFonts.abel(
                color: const Color.fromARGB(255, 194, 146, 24),
                fontSize: 20,
              ),
            ),
            Row(
              children: [
                Text(value, style: TextStyle(fontSize: 16)),
                SizedBox(width: 10),
                Icon(icon, size: 18),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
