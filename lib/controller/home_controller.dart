// import 'dart:convert';
//
// import 'package:flutter/cupertino.dart';
// import 'package:newsupon/model/newsModel.dart';
// import 'package:http/http.dart' as http;
//
// class HomeController with ChangeNotifier {
//   //instead of creating  service file we are adding in controller itself
//   late NewsModel newsModel;
//   bool isLoading = false; //initially loading is false
//
// //var baseurl="https://newsapi.org"; can give like this by interpolating in main url
//   fetchDataFromApi() async {
//     isLoading = true; //when invoke fetch data ,loading will be true
//     notifyListeners(); //and changes will be notify
//     final url = Uri.parse(
//         "https://newsapi.org/v2/top-headlines?country=in&apiKey=7389d6a114fa4d3c97a1e142168adb32");
//     final response = await http.get(url);
//     print(response.statusCode);
//     Map<String, dynamic> decodedData = {}; //map for storing response
//     if (response.statusCode == 200) {
//       decodedData = jsonDecode(response
//           .body); //why decoding here as article in newsmodel is json array so have to convert that otherwise no need this convertion
//     } else {
//       print("Api Failed");
//     }
//     newsModel = NewsModel.fromJson(decodedData); //parsing that decoded json in newsmodel as map
//     isLoading = false;
//     notifyListeners();
//   }
// }
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:newsupon/model/newsModel.dart';
import 'package:http/http.dart' as http;
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeController with ChangeNotifier {
  late NewsModel newsModel;
  bool isLoading = false;

  //var baseUrl = "https://newsapi.org/";

  fetchDataFromApi() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=in&apiKey=7389d6a114fa4d3c97a1e142168adb32");
    final response = await http.get(url);
    print(response.statusCode);
    Map<String, dynamic> decodedData = {}; // map for storing response body
    if (response.statusCode == 200) {
      decodedData = jsonDecode(response.body);
    } else {
      print("Api failed");
    }
    newsModel = NewsModel.fromJson(decodedData);
    isLoading = false;
    notifyListeners();
  }

// Function to launch a URL
  Future<void> launchURL(String url) async {
    final Uri url1 = Uri.parse(url);
    try {
      if (!await launchUrl(url1, mode: LaunchMode.inAppWebView)) {
        await launchUrl(url1, mode: LaunchMode.inAppWebView);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print('Error launching URL: $e');
    }
    notifyListeners();
  }

  //to share news via amy media
  void shareText({String textShare = ""}) {
    try {
      Share.share(textShare);
    } catch (e) {
      print('Error sharing: $e');
    }
    notifyListeners();
  }
}
