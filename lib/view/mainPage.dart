import 'package:flutter/material.dart';
import 'package:newsupon/controller/bottomController.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Provider.of<BottomController>(context)
          .screens[Provider.of<BottomController>(context).selectedIndex],
      bottomNavigationBar: BottomNavigationBar(backgroundColor: Colors.black,
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.yellow,
          selectedIconTheme: const IconThemeData(size: 25),
          unselectedIconTheme: const IconThemeData(size: 25),
          showUnselectedLabels: false,
          showSelectedLabels: true,
          currentIndex: Provider.of<BottomController>(context).selectedIndex,
          onTap: Provider.of<BottomController>(context,listen: false).onTapItem,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.category), label: "Category"),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          ]),
    );
  }
}
