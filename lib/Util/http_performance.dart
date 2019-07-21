import 'dart:convert';

import 'package:firebase_performance/firebase_performance.dart';
import 'package:http/http.dart';

class MetricHttpClient extends BaseClient {
  MetricHttpClient(this._inner);
  final Client _inner;

  @override
  Future<StreamedResponse> send(BaseRequest request) async {
    final HttpMetric metric = FirebasePerformance.instance
        .newHttpMetric(request.url.toString(), HttpMethod.Get);

    await metric.start();

    StreamedResponse response;
    try {
      response = await _inner.send(request);
      metric
        ..responsePayloadSize = response.contentLength
        ..responseContentType = response.headers['Content-Type']
        ..requestPayloadSize = request.contentLength
        ..httpResponseCode = response.statusCode;
    } finally {
      await metric.stop();
    }

    return response;
  }

  @override
  Future<Response> post(url,
      {Map<String, String> headers, body, Encoding encoding}) async {
    print("post");
    final HttpMetric metric =
    FirebasePerformance.instance.newHttpMetric(url, HttpMethod.Post);
    await metric.start();

    Response response;
    try {
      response = await _inner.post(url, headers: headers, body: body);
      metric
        ..responsePayloadSize = response.contentLength
        ..responseContentType = response.headers['Content-Type']
        ..httpResponseCode = response.statusCode;
    } finally {
      await metric.stop();
      _inner.close();
    }

    return response;
  }


}
