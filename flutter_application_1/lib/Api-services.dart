import 'dart:convert';

import 'package:flutter_application_1/api.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  final String baseUrl = "https://api.todoist.com/rest/v2/projects";
  final String apiToken = "92597cf179f1f165cd93b7501d1114e956408ea5";

  Map<String, String> _headers() {
    return {
      'Authorization': 'Bearer $apiToken',
      'Content-Type': 'application/json',
    };
  }

  // Fetch all tasks.

  Future<List<taskApiModel>> gettasks() async {
    List<taskApiModel> responseData = [];
    var url = Uri.parse("$baseUrl/tasks");
    var response = await http.get(url);

    var responsebody = jsonDecode(response.body);

    for (var eachMap in responsebody) {
      responseData.add(eachMap);
    }
    return responseData;
  }
}
