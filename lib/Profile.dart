import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Profile extends StatefulWidget {
  final String imageAsset;
  final String fallbackImageAsset;

  const Profile({
    Key? key,
    this.imageAsset = 'assets/images/vagabond2.png',
    this.fallbackImageAsset = 'assets/images/vagabond2.png',
  }) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String firstName = '';
  String lastName = '';

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    var box = await Hive.openBox('userBox');
    String? username = box.get('username');

    if (username != null) {
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
    } else {
      setState(() {
        firstName = "Error";
        lastName = "Username not found";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 197, 233, 199),
      appBar: AppBar(
        // backgroundColor: const Color.fromARGB(255, 106, 232, 112),
        backgroundColor: Theme.of(context).colorScheme.surface,

        leading: IconButton(
          onPressed: () {
            if (context.mounted) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/home', (Route<dynamic> route) => false);
            }
          },
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back to Home',
        ),
        title: Text(
          'Profile',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildProfileImage(context),
                SizedBox(height: 16),
                _buildNameWidget(context),
                SizedBox(height: 24),
                _buildContactInfo(context),
                SizedBox(height: 24),
                _buildFarmingDetails(context),
                SizedBox(height: 24),
                _buildSettingsMenu(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileImage(BuildContext context) {
    return CircleAvatar(
      radius: 60,
      backgroundColor: Colors.grey[300],
      child: ClipOval(
        child: Image.asset(
          widget.imageAsset,
          width: 120,
          height: 120,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            print("Error loading image: $error");
            return Image.asset(
              widget.fallbackImageAsset,
              width: 120,
              height: 120,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                print("Error loading fallback image: $error");
                return const Icon(
                  Icons.person,
                  size: 60,
                  color: Color.fromARGB(255, 88, 168, 82),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildNameWidget(BuildContext context) {
    return Text(
      '$firstName $lastName',
      style: Theme.of(context)
          .textTheme
          .headlineSmall
          ?.copyWith(fontWeight: FontWeight.w600),
    );
  }

  Widget _buildContactInfo(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildInfoRow(context, Icons.phone, '+91 9876543210'),
            Divider(),
            _buildInfoRow(context, Icons.location_on, 'Karikode, Kollam'),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).primaryColor),
          SizedBox(width: 16),
          Expanded(
              child: Text(text, style: Theme.of(context).textTheme.bodyLarge)),
        ],
      ),
    );
  }

  Widget _buildFarmingDetails(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Farming Details',
                style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: 16),
            _buildInfoRow(context, Icons.landscape, 'Farm Size: 20 acres'),
            _buildInfoRow(context, Icons.grass, 'Soil Type: Loamy'),
            _buildInfoRow(
                context, Icons.agriculture, 'Crops Grown: Wheat, Rice'),
            _buildInfoRow(context, Icons.pets, 'Livestock: 10 cows, 5 goats'),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsMenu(BuildContext context) {
    return ExpansionTile(
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
        child: Icon(Icons.settings, color: Theme.of(context).primaryColor),
      ),
      title: Text('Settings', style: Theme.of(context).textTheme.titleMedium),
      children: [
        ListTile(
          title: Text('Edit Profile'),
          onTap: () {
            // TODO: Implement edit profile functionality
          },
        ),
        ListTile(
          title: Text('Log Out', style: TextStyle(color: Colors.red)),
          onTap: () async {
            var box = await Hive.openBox('userBox');
            await box.delete('username');
            await box.close();
            if (context.mounted) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/', (Route<dynamic> route) => false);
            }
          },
        ),
      ],
    );
  }
}
