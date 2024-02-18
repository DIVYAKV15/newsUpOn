import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:newsupon/model/newsModel.dart';
import 'package:http/http.dart' as http;

class SearchScreenController with ChangeNotifier {
 NewsModel newsModel=NewsModel();
  bool isLoading = false;

  Future<void> searchData({required String searchText}) async {
    isLoading = true;
    notifyListeners();
    final url = Uri.parse("https://newsapi.org/v2/everything?q=business&apiKey=7389d6a114fa4d3c97a1e142168adb32");
    try {
      final response = await http.get(url,
        // headers: {
        //   'Content-Type': 'application/json',
        // },
      );
      print(response.statusCode);

      if (response.statusCode == 200) {
        final Map<String, dynamic> decodedData = jsonDecode(response.body);
        newsModel = NewsModel.fromJson(decodedData);
      } else {
        print("Api failed");
        // Handle the failure case as needed.
      }
    } catch (e) {
      print("Error: $e");
      // Handle the error case as needed.
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
