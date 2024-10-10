import 'dart:convert';

import 'package:flutter_application_1/api.dart';
import 'package:flutter_application_1/main.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  final String baseUrl = "https://api.todoist.com/rest/v2";
  final String apiToken = "92597cf179f1f165cd93b7501d1114e956408ea5";

  Map<String, String> _headers() {
    return {
      'Authorization': 'Bearer $apiToken',
      'Content-Type': 'application/json',
    };
  }

  // Fetch all tasks.
  // List<taskApiModel> responseData = [];
  static int lengthOfResponseData = 0;

  Future<List<dynamic>> gettasks() async {
    var url = Uri.parse("$baseUrl/tasks");
    var response = await http.get(url, headers: _headers());

    var responsebody = jsonDecode(response.body);
    // print(responsebody);
    // responseData.clear();
    // for (var eachMap in responsebody) {
    //   responseData.add(taskApiModel.fromJson(eachMap));
    // }
    lengthOfResponseData = responsebody.length;
    return responsebody;
  }

  deletetasks(String id) async {
    var url = Uri.parse("$baseUrl/tasks/$id");
    await http.delete(url, headers: _headers());
  }

  
}
