import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AgroMonitoringPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F0E6), // Light natural color
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlockSemantics(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back_ios)),
                    Text('Wheat ',
                        style: GoogleFonts.abel(
                            color: const Color.fromARGB(255, 194, 146, 24),
                            fontSize: 35)),
                  ],
                ),
              ),
            ),
            // Top Image Section
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

            // Data Cards
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Temperature ',
                        style: GoogleFonts.abel(
                            color: const Color.fromARGB(255, 194, 146, 24),
                            fontSize: 20)),
                    Container(
                      child: Row(
                        children: [
                          const Text("34*", style: TextStyle(fontSize: 16)),
                          const SizedBox(
                            width: 10,
                          ),
                          const Icon(Icons.sunny)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Humidity ',
                        style: GoogleFonts.abel(
                            color: const Color.fromARGB(255, 194, 146, 24),
                            fontSize: 20)),
                    Container(
                      child: Row(
                        children: [
                          const Text("45%", style: TextStyle(fontSize: 16)),
                          SizedBox(
                            width: 10,
                          ),
                          const Icon(Icons.water_drop, size: 18)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Market Price ',
                        style: GoogleFonts.abel(
                            color: const Color.fromARGB(255, 194, 146, 24),
                            fontSize: 20)),
                    Container(
                      child: Row(
                        children: [
                          const Text("37", style: TextStyle(fontSize: 16)),
                          SizedBox(
                            width: 10,
                          ),
                          const Icon(Icons.currency_rupee, size: 18)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Moisture ',
                        style: GoogleFonts.abel(
                            color: const Color.fromARGB(255, 194, 146, 24),
                            fontSize: 20)),
                    Container(
                      child: Row(
                        children: [
                          const Text("45%", style: TextStyle(fontSize: 16)),
                          SizedBox(
                            width: 10,
                          ),
                          const Icon(Icons.water_drop, size: 18)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),

            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Soil Type ',
                        style: GoogleFonts.abel(
                            color: const Color.fromARGB(255, 194, 146, 24),
                            fontSize: 20)),
                    const Text("", style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ),

            // List of Crops
            // GridView.builder(
            //   shrinkWrap: true,
            //   physics: NeverScrollableScrollPhysics(),
            //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //     crossAxisCount: 2,
            //     crossAxisSpacing: 16.0,
            //     mainAxisSpacing: 16.0,
            //     childAspectRatio: 0.8,
            //   ),
            //   itemCount: 4, // Example crop count
            //   itemBuilder: (context, index) {
            //     return Container(
            //       padding: EdgeInsets.all(16.0),
            //       decoration: BoxDecoration(
            //         color: Colors.white,
            //         borderRadius: BorderRadius.circular(16.0),
            //         boxShadow: [
            //           BoxShadow(
            //             color: Colors.black12,
            //             blurRadius: 4,
            //             offset: Offset(2, 2),
            //           ),
            //         ],
            //       ),
            //       child: Column(
            //         children: [
            //           Image.asset('assets/crop_image.png', height: 60),
            //           SizedBox(height: 10),
            //           Text(
            //             "Wheat",
            //             style: TextStyle(
            //               fontWeight: FontWeight.bold,
            //               fontSize: 16,
            //             ),
            //           ),
            //           Text(
            //             "10 kg/ha",
            //             style: TextStyle(color: Colors.grey),
            //           ),
            //         ],
            //       ),
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
