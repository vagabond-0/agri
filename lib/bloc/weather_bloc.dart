import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial()) {
    on<Fetchweather>((event, emit)  async {
      emit(WeatherLoading());
      try{
        WeatherFactory wf = WeatherFactory("4472a9d8343ecbcdae4c438e8241eeac",language: Language.ENGLISH);
        Weather weather = await wf.currentWeatherByLocation(event.position.latitude,event.position.longitude);
        
        emit(WeatherSuccess(weather));
      }catch(e){
        emit(WeatherFailure());
      }
    });
  }
}
