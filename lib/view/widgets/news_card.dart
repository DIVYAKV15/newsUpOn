import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../controller/home_controller.dart';
import 'newsViewScreen.dart';

class NewsCard extends StatelessWidget {
  final String title;
  final String description;
  final DateTime? date;
  final String imageUrl;
  final String content;
  final String sourceName;
  final String url;

  const NewsCard(
      {super.key,
      required this.title,
      required this.description,
      required this.date,
      required this.imageUrl,
      required this.content,
      required this.sourceName,
      required this.url});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                  image: NetworkImage(
                    imageUrl,
                  ),
                  fit: BoxFit.cover),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewsViewScreen(
                      title: title,
                      description: description,
                      imageUrl: imageUrl,
                      date: date,
                      contant: content,
                      sourceName: sourceName,
                      url: url,
                    ),
                  ));
            },
            child: Column(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        "$sourceName | ${DateFormat('dd/MM/yyyy').format(date!).toString() ?? ""}",
                        style: const TextStyle(color: Colors.white)),
                    IconButton(
                        onPressed: () {
                          String newsToShare =
                              "$title \n \n $description \n \n $url";
                          Provider.of<HomeController>(context, listen: false)
                              .shareText(textShare: newsToShare);
                        },
                        icon: const Icon(
                          Icons.share,
                          color: Colors.white,
                        ))
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
