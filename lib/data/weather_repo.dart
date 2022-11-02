import 'package:weather_app/data/weather_model.dart';
import 'package:weather_app/data/weather_service.dart';

class WeatherRepo {
  final WeatherService weatherService;
  final String longitude;
  final String latitude;

  WeatherRepo(this.weatherService, this.longitude, this.latitude);
  Future<WeatherModel> getWeather() async {
    final weather = await weatherService.getWeather(longitude, latitude);
    return WeatherModel.fromJson(weather);
  }
}
