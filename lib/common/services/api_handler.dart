import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;


Future<dynamic> apiHandler(
    String url,
    String method, {
      Map<String, String>? headers,
      Map<String, String>? body,
      bool authorization = false,
    }) async {
  method = method.toUpperCase();
  http.Response response;

  String? token = await Hive.box('SETTINGS').get('token') ?? "";

  print("Token: $token");
  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };
  if (token!.isEmpty) {
    headers["Authorization"] = "Bearer $token";
  }

  if (method == 'GET') {
    response = await http.get(
      Uri.parse(url),
      headers: headers,
    );
  } else if (method == 'POST') {
    print("Post Body: $body");
    response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(body),
    );
    print("Response: ${response.body}");
  } else if (method == 'PUT') {
    response = await http.put(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(body),
    );
  } else if (method == 'PATCH') {
    response = await http.patch(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(body),
    );
  } else if (method == 'DELETE') {
    response = await http.delete(Uri.parse(url), headers: headers, body: body);
  } else {
    throw Exception('Invalid method');
  }

  var jsonResponse = jsonDecode(response.body);

  if (response.statusCode == 200 || response.statusCode == 201) {
    return jsonResponse;
  } else if (response.statusCode == 403|| response.statusCode == 401) {
    print("Response: ${jsonResponse}");
    print("Status Code: ${response.statusCode}");
  } else {
    print("Response: ${jsonResponse}");
    print("URL: $url");
    print("Status Code: ${response.statusCode}");
    final errorMessage = jsonResponse["message"] ??jsonResponse["error"]?? "An error occurred";

    throw Exception(errorMessage);
  }
}
