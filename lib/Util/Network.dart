import 'dart:convert';

import 'package:hack_mobility/model/Suggestion.dart';
import 'package:http/http.dart';

import 'http_performance.dart';

import 'package:http/http.dart' as http;

class NetworkUtil {
  static getSuggestions(String text) async {
    String authority = "autocomplete.geocoder.api.here.com";
    String unencodedPath = "6.2/suggest.json";

    String app_id = "RFJVVdv5JkPTaXfrEaT0";
    String app_code = "V4HfvqIcDrQmSXnFSKDopg";
    String query = text;

    Map<String, String> parameters = Map();
    parameters['app_id'] = app_id;
    parameters['app_code'] = app_code;
    parameters['query'] = text;

    Uri uri = Uri.http(authority, unencodedPath, parameters);
    print(uri);

//    final MetricHttpClient metricHttpClient = MetricHttpClient(Client());
//    final Request request = Request("GET", uri);

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      Map<String, dynamic> data = jsonDecode(response.body);
      List<Suggestion> suggestions = List();
      for (int i = 0; i < data['suggestions']; i++) {
        Suggestion sug = Suggestion.fromJson(data['suggestions'][i]);
        suggestions.add(sug);
      }
      return suggestions;
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }
  static Future<http.Response> postAddressData(String origin, String destiny) async {
    Map headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    var mBody = json.encode({
      'data': {"PlaceName0": origin, "PlaceName1": destiny}
    });

    var mUrl = "http://40.114.67.101:8080/api/v1/route_stats/";
    final MetricHttpClient metricHttpClient = MetricHttpClient(Client());
    return metricHttpClient.post(mUrl, body: mBody, headers: new Map.from(headers));
  }

}
