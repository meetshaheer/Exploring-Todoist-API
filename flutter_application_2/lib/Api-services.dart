import 'dart:convert';

import 'package:flutter/material.dart';
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

  TextEditingController addtitle = TextEditingController();
  TextEditingController adddesc = TextEditingController();
  TextEditingController updatetitle = TextEditingController();
  TextEditingController updateesc = TextEditingController();

  addtasks() async {
    var url = Uri.parse("$baseUrl/tasks");
    await http.post(
      url,
      headers: _headers(),
      body: jsonEncode(
        {
          'content': addtitle.text,
          'description': adddesc.text,
          'created_at': "2024:10:02",
          'due': {'date': "2024:11:11"}
        },
      ),
    );
    adddesc.clear();
    addtitle.clear();
  }

  updatetasks(String id) async {
    var url = Uri.parse("$baseUrl/tasks/$id");

    var response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $apiToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
        {
          'content': updatetitle.text,
          'description': updateesc.text,
        },
      ),
    );

    updatetitle.clear();
    updateesc.clear();
  }
}
