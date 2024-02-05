import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:newsupon/model/newsModel.dart';
import 'package:http/http.dart' as http;

class CategoryController with ChangeNotifier {
  List<String> categoryList = [
    "Business",
    "Entertainment",
    "General",
    "health",
    "Science",
    "Sports",
    "Technology"
  ];
  String category = 'Business'; //by default we are selecting as business

  onTap({required int index}) {
    category = categoryList[index]
        .toLowerCase(); // to convert the category list into lower case we are using the variable
//as we are getting as small case from api
    fetchData();
    print(category);
    notifyListeners();
  }

  late NewsModel newsModel;
  bool isLoading = false;

  void fetchData() async {
    isLoading = true;
    final url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=7389d6a114fa4d3c97a1e142168adb32");
    //here parsing the catgory so we get information depend upon we are tabbing the category list
    var response = await http.get(url);
    print(response.statusCode);
    Map<String, dynamic> decodedData = {}; //tp parse the json decoded as map
    if (response.statusCode == 200) {
      decodedData = jsonDecode(response.body);
    } else {
      print("APi failed");
    }
    newsModel = NewsModel.fromJson(
        decodedData); //parsing to model class where in that method we get the data map
    isLoading = false;
    notifyListeners();
  }
}
