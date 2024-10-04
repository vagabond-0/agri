import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              if (context.mounted) {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/home', (Route<dynamic> route) => false);
              }
            },
            icon: Icon(Icons.arrow_back)),
        title: Center(
          child: Text(
            'Profile',
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 247, 255, 247),
      ),
      backgroundColor: const Color.fromARGB(255, 247, 255, 247),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(50),
          child: Column(
            children: [
              SizedBox(
                width: 120,
                height: 120,
                child: ClipRRect(
                  //enter image
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    'assets/images/background.jpg',
                  ),
                ),
              ),

              const SizedBox(height: 10),
              //enter name of farmer
              Text('NameOfFarmer',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontWeight: FontWeight.bold)),

              SizedBox(
                height: 20,
              ),

              Center(
                child: IntrinsicWidth(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(25, 16, 25, 16),
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          //PHONE NUMBER
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.phone, size: 18, color: Colors.green),
                            SizedBox(width: 8),
                            Text('+91 9876543210',
                                style: Theme.of(context).textTheme.bodyMedium),
                          ],
                        ),
                        const Divider(),
                        SizedBox(height: 10),
                        Row(
                          //LOCATION
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.location_pin,
                                size: 18, color: Colors.green),
                            SizedBox(width: 8),
                            Text('Karikode, Kollam',
                                style: Theme.of(context).textTheme.bodyMedium),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),

              // Farming Details
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Farming Details',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),

              Center(
                child: Container(
                  padding: EdgeInsets.all(16),
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.landscape),
                          SizedBox(width: 8),
                          Text('Farm Size: 20 acres',
                              style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.grass),
                          SizedBox(width: 8),
                          Text(
                            'Soil Type: Loamy',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.agriculture),
                          SizedBox(width: 8),
                          Text(
                            'Crops Grown: Wheat, Rice',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.pets),
                          SizedBox(width: 8),
                          Text(
                            'Livestock: 10 cows, 5 goats',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

//              const SizedBox(height: 20),
//              SizedBox(
//                width: 200,
//                child:  ElevatedButton(onPressed: (){},
//                style: ElevatedButton.styleFrom(
              ///                  backgroundColor: Colors.lightGreen , side: BorderSide.none, shape: const StadiumBorder()),
//              child: const Text('Edit Profile', style: TextStyle(color: Colors.white),)) ,
              //             ),
              const SizedBox(height: 30),
              const Divider(),
              const SizedBox(height: 10),

              //menu

              ExpansionTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.green.withOpacity(0.1),
                  ),
                  child: const Icon(Icons.settings, color: Colors.green),
                ),
                title: Text('Settings',
                    style: Theme.of(context).textTheme.bodyMedium),
                trailing:
                    Icon(Icons.arrow_drop_down, size: 24.0, color: Colors.grey),
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          title: Text('Edit Profile'),
                          onTap: () {},
                        ),
                        ListTile(
                          title: Text(
                            'Log Out',
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}



// color scheme monochromatic
// #4ac479 and #4ac479
