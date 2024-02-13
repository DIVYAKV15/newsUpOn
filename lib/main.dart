import 'package:flutter/material.dart';
import 'package:newsupon/controller/bottomController.dart';
import 'package:newsupon/controller/category_controller.dart';
import 'package:newsupon/controller/home_controller.dart';
import 'package:newsupon/view/mainPage.dart';
import 'package:provider/provider.dart';

import 'controller/search_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BottomController()),
        ChangeNotifierProvider(create: (context) => CategoryController()),
        ChangeNotifierProvider(create: (context) => HomeController()),
        ChangeNotifierProvider(create: (context) => SearchScreenController()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MainPage(),
      ),
    );
  }
}
