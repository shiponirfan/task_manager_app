import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:task_manager_app/data/models/network_response.dart';
import 'package:http/http.dart' as http;

class NetworkCaller {
  static Future<NetworkResponse> getRequest(String url) async {
    try {
      Uri uri = Uri.parse(url);
      final http.Response response = await http.get(
        uri,
        headers: {'Content-Type': 'application/json'},
      );
      final decodedData = jsonDecode(response.body);
      printResponse(url, response);
      if (response.statusCode == 200) {
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: decodedData,
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          responseData: decodedData,
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  static Future<NetworkResponse> postRequest(
      {required String url, Map<String, dynamic>? body}) async {
    try {
      Uri uri = Uri.parse(url);
      final http.Response response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );
      final decodedData = jsonDecode(response.body);
      printResponse(url, response);
      if (response.statusCode == 200) {
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: decodedData,
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          responseData: decodedData,
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  static printResponse(String url, http.Response response) {
    debugPrint(
        'Url: $url\nStatusCode: ${response.statusCode}\nBody: ${response.body}');
  }
}
