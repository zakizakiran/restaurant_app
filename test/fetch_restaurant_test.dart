import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/api/restaurant_api_service.dart';

void main() {
  test(
      'fetchRestaurantList throws an exception if the http call completes with an error',
      () async {
    // Mocking HTTP response with an error status code
    http.Response mockErrorResponse = http.Response('Error', 404);

    // Mocking http.Client using MockClient from flutter_test package
    http.Client client = MockClient((request) async {
      return mockErrorResponse;
    });

    // Create an instance of the RestaurantApiService and set the mocked http client
    RestaurantApiService restaurantApiService = RestaurantApiService();
    restaurantApiService.httpClient = client;

    // Call the fetchRestaurantList method and expect an exception
    expect(() async => await restaurantApiService.fetchRestaurantList(),
        throwsException);
  });

  test(
      'fetchRestaurantList throws an exception if there is no internet connection',
      () async {
    // Mocking SocketException
    http.Client client = MockClient((request) {
      throw const SocketException('No internet connection');
    });

    // Create an instance of the RestaurantApiService and set the mocked http client
    RestaurantApiService restaurantApiService = RestaurantApiService();
    restaurantApiService.httpClient = client;

    // Call the fetchRestaurantList method and expect an exception
    expect(() async => await restaurantApiService.fetchRestaurantList(),
        throwsException);
  });
}

// MockClient class using http.Client from flutter_test package
class MockClient implements http.Client {
  final Function(http.Request) _onRequest;

  MockClient(this._onRequest);

  @override
  Future<http.Response> post(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) {
    return _onRequest(http.Request('POST', url)
      ..headers.addAll(headers ?? {})
      ..body = body.toString());
  }

  @override
  void close() {}

  @override
  Future<http.Response> delete(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) {
    throw UnimplementedError();
  }

  @override
  Future<http.Response> get(Uri url, {Map<String, String>? headers}) {
    return _onRequest(http.Request('GET', url)..headers.addAll(headers ?? {}));
  }

  @override
  Future<http.Response> head(Uri url, {Map<String, String>? headers}) {
    throw UnimplementedError();
  }

  @override
  Future<http.Response> patch(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) {
    throw UnimplementedError();
  }

  @override
  Future<http.Response> put(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) {
    throw UnimplementedError();
  }

  @override
  Future<String> read(Uri url, {Map<String, String>? headers}) {
    throw UnimplementedError();
  }

  @override
  Future<Uint8List> readBytes(Uri url, {Map<String, String>? headers}) {
    throw UnimplementedError();
  }

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    throw UnimplementedError();
  }
}
