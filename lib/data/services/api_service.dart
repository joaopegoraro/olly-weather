import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:olly_weather/constants/weather_unit.dart';
import 'package:olly_weather/data/services/logging_service.dart';
import 'package:olly_weather/models/weather.dart';

abstract class ApiService {
  Future<List<Weather>?> getForecast(
    String latitude,
    String longitude, {
    WeatherUnit unit = WeatherUnit.metric,
  });
}

class ApiServiceImpl extends ApiService {
  ApiServiceImpl(this._logger);

  final LoggingService _logger;

  @override
  Future<List<Weather>?> getForecast(
    String latitude,
    String longitude, {
    WeatherUnit unit = WeatherUnit.imperial,
  }) async {
    return _getData(
      queryParameters: {
        "lat": latitude,
        "lon": longitude,
        "units": unit.value,
      },
      parseResponse: (response) {
        final Map<String, dynamic> forecast = jsonDecode(response.body);
        return forecast["list"]
            .map((weather) => Weather.fromMap(weather))
            .toList();
      },
    );
  }

  String get _url => "${dotenv.env['BASE_URL']}?APPID=${dotenv.env['API_KEY']}";

  Future<T?> _getData<T>({
    Map<String, dynamic>? queryParameters,
    required T Function(Response response) parseResponse,
  }) async {
    try {
      final queryString = _buildQueryString(queryParameters);
      final url = Uri.parse("$_url&$queryString");
      final response = await http.get(url);
      return response.statusCode == 200 ? parseResponse(response) : null;
    } catch (e, stackTrace) {
      if (kDebugMode) {
        _logger.e("Api error", error: e, stackTrace: stackTrace);
      }
      return null;
    }
  }

  String? _buildQueryString(Map<String, dynamic>? queryParameters) {
    return queryParameters?.entries.fold("", (queryString, element) {
      return "$queryString&${element.key}=${element.value}";
    });
  }
}

final apiServiceProvider = Provider<ApiService>((ref) {
  final logger = ref.watch(loggerProvider);
  return ApiServiceImpl(logger);
});
