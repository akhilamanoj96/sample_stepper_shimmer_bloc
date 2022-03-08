import 'package:rxdart/rxdart.dart';
import 'package:sample_flutter_app/models/weather_response.dart';
import 'package:sample_flutter_app/repository/repository.dart';


class WeatherBloc {
  Repository _repository = Repository();

  final _weatherFetcher = PublishSubject<WeatherResponse>();

  Observable<WeatherResponse> get weather => _weatherFetcher.stream;

  fetchLondonWeather() async {

    print('hhhhhhhhhh');
    WeatherResponse weatherResponse = await _repository.fetchLondonWeather();
    _weatherFetcher.sink.add(weatherResponse);
  }

  dispose() {
    _weatherFetcher.close();
  }
}

final weatherBloc = WeatherBloc();