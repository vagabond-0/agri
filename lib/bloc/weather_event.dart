part of 'weather_bloc.dart';

sealed class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}


class Fetchweather extends WeatherEvent {
  final Position position;

  const Fetchweather(this.position);
  @override
  List<Object> get props => [];
}