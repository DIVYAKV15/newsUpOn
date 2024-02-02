import 'dart:convert';

import 'package:newsupon/model/newsModel.dart';
import 'package:http/http.dart' as http;

class HttpService {
  //var baseurl="https://newsapi.org"; can give like this by interpolating in main url
  var url = Uri.parse(
      "https://newsapi.org/v2/top-headlines?country=in&apiKey=7389d6a114fa4d3c97a1e142168adb32");

  Future<NewsModel> fetchData() async {
    var response = await http.get(url);
    print(response.statusCode);
    Map<String, dynamic> decodedData = {}; //map for storing response
    if (response.statusCode == 200) {
      return decodedData =jsonDecode(response.body);

    }
    else
      {
        print("Api Failed");
        return decodedData =jsonDecode(response.body);
      }

  }
}
