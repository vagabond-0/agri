import 'package:agri/bloc/weather_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TemperatureScreen extends StatelessWidget {
  const TemperatureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is WeatherSuccess) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.orangeAccent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.wb_sunny,
                              size: 50,
                              color: Colors.white,
                            ),
                            const SizedBox(height: 10),
                            // Display the temperature from the state
                            Text(
                              '${state.weather.temperature} °C', // Use temperature from WeatherLoaded state
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Box for Humidity
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.lightBlueAccent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.water_drop,
                              size: 50,
                              color: Colors.white,
                            ),
                            const SizedBox(height: 10),
                            // Display the humidity from the state
                            Text(
                              '${state.weather.humidity}%', // Use humidity from WeatherLoaded state
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          } else if (state is WeatherLoading) {
            // Show loading indicator when data is being loaded
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            // Display a placeholder when no data is available
            return const Center(
              child: Text(
                'No weather data available',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
