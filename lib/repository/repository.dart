import 'package:sample_flutter_app/models/weather_response.dart';
import 'package:sample_flutter_app/network/api_provider.dart';

class Repository {
  ApiProvider appApiProvider = ApiProvider();

  Future<WeatherResponse> fetchLondonWeather() => appApiProvider.fetchLondonWeather();
}