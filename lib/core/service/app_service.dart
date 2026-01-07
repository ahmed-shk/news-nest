import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const Duration _timeout = Duration(seconds: 30);

  static Map<String, String> get defaultHeaders => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  static Future<dynamic> get(
      String url, {
        Map<String, String>? headers,
      }) async {
    try {
      final response = await http
          .get(Uri.parse(url), headers: headers ?? defaultHeaders)
          .timeout(_timeout);

      return _handleResponse(response);
    } on SocketException {
      throw ApiException("No Internet connection");
    } on HttpException {
      throw ApiException("Couldn't find the resource");
    } on FormatException {
      throw ApiException("Bad response format");
    } catch (e) {
      throw ApiException("Unexpected error: $e");
    }
  }

  static Future<dynamic> post(
      String url, {
        Map<String, String>? headers,
        dynamic body,
      }) async {
    try {
      final response = await http
          .post(
        Uri.parse(url),
        headers: headers ?? defaultHeaders,
        body: jsonEncode(body),
      )
          .timeout(_timeout);

      return _handleResponse(response);
    } on SocketException {
      throw ApiException("No Internet connection");
    } on HttpException {
      throw ApiException("Couldn't find the resource");
    } on FormatException {
      throw ApiException("Bad response format");
    } catch (e) {
      throw ApiException("Unexpected error: $e");
    }
  }

  static dynamic _handleResponse(http.Response response) {
    if (kDebugMode) {
      print("URL: ${response.request?.url}");
      print("Status Code: ${response.statusCode}");
      print("Body: ${response.body}");
    }

    final statusCode = response.statusCode;

    if (statusCode >= 200 && statusCode < 300) {
      try {
        return jsonDecode(response.body);
      } catch (e) {
        throw ApiException("Failed to parse JSON: $e");
      }
    }

    switch (statusCode) {
      case 400:
        throw ApiException("Bad Request");
      case 401:
        throw ApiException("Unauthorized");
      case 403:
        throw ApiException("Forbidden");
      case 404:
        throw ApiException("Not Found");
      case 500:
        throw ApiException("Internal Server Error");
      default:
        throw ApiException("HTTP Error: $statusCode");
    }
  }
}

class ApiException implements Exception {
  final String message;
  ApiException(this.message);

  @override
  String toString() => message;
}
