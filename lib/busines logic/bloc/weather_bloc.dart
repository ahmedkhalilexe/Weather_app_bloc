import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/data/weather_model.dart';
import 'package:weather_app/data/weather_repo.dart';
import 'package:weather_app/data/weather_service.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final weatherService = WeatherService();
  WeatherBloc() : super(WeatherInitial()) {
    on<WeatherEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<WeatherRequested>(_weatherReq);
  }

  Future _weatherReq(WeatherRequested event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());
    try {
      final WeatherModel req =
          await WeatherRepo(weatherService, "51.51", "14.14").getWeather();
      emit(WeatherLoaded(req));
    } catch (e) {
      emit(WeatherNotLoaded());
    }
  }
}
