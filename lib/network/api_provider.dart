import 'dart:convert';
import 'package:http/http.dart' show Client;
import 'package:sample_flutter_app/models/weather_response.dart';

class ApiProvider {
  Client client = Client();
   final _baseUrl = 'https://samples.openweathermap.org/data/2.5/weather?q=London,uk&appid=b6907d289e10d714a6e88b30761fae22';

  Future<WeatherResponse> fetchLondonWeather() async {
    final response = await client.get(Uri.parse("$_baseUrl"));
    print(response.body.toString());

    if (response.statusCode == 200) {
     // print('res[p success') ;
      return WeatherResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load weather');
    }
  }
}