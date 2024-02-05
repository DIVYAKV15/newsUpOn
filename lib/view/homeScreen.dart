import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:newsupon/controller/home_controller.dart';
import 'package:newsupon/view/searchScreen.dart';
import 'package:newsupon/view/widgets/news_card.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    fetchData();
  }

  void fetchData() async {
    Provider.of<HomeController>(context, listen: false)
        .fetchDataFromApi(); //as we are fetching data from api so its asynchronous operation so if we want we can add async and await here
  }

  @override
  Widget build(BuildContext context) {
    HomeController homeProvider = Provider.of<HomeController>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("News UpOn 🗞️",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold)),
          ),
          actions: [
            IconButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SearchScreen())),
                icon: const Icon(
                  Icons.search,
                  size: 30,
                  color: Colors.white,
                )),
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: InkWell(
                child: Image(
                    image: AssetImage("asset/images/img.png"), height: 30),
              ),
            )
          ]),
      body: Provider.of<HomeController>(context).isLoading == true
          ? Center(
              child: LottieBuilder.asset(
                "asset/animations/Animation - 1706853567309.json",
                fit: BoxFit.cover,
                height: 150,
                width: 150,
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView.separated(
                  itemBuilder: (context, index) => NewsCard(
                      title: homeProvider.newsModel.articles?[index].title.toString() ??
                          "",
                      description: homeProvider
                              .newsModel.articles?[index].description
                              .toString() ??
                          "",
                      date: homeProvider.newsModel.articles?[index].publishedAt,
                      imageUrl: homeProvider.newsModel.articles?[index].urlToImage
                              .toString() ??
                          "",
                      content: homeProvider.newsModel.articles?[index].content
                              .toString() ??
                          "",
                      sourceName: homeProvider.newsModel.articles?[index].source.toString() ?? "",
                      url: homeProvider.newsModel.articles?[index].url.toString() ?? ""),
                  separatorBuilder: (context, index) => const Divider(height: 20),
                  itemCount: homeProvider.newsModel.articles?.length ?? 0),
            ),
    );
  }
}
