import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:newsupon/controller/search_controller.dart';
import 'package:newsupon/view/widgets/news_card.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController textController = TextEditingController();
    SearchScreenController provider =
    Provider.of<SearchScreenController>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(
                height: 45,
                width: MediaQuery
                    .sizeOf(context)
                    .width * 2 / 3,
                child: SearchBar(
                  controller: textController,
                  leading: const Icon(Icons.search),
                  hintText: "Search",
                  onTap: () {
                    provider.searchData(
                        searchText: textController.text.toLowerCase());
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                ),
              ),
              Expanded(
                child: Provider
                    .of<SearchScreenController>(context)
                    .isLoading ==
                    true
                    ? Center(
                    child: LottieBuilder.asset(
                      "asset/animations/Animation - 1706853567309.json",
                      fit: BoxFit.cover,
                      height: 150,
                      width: 150,
                    ))
                    : ListView.separated(
                    itemBuilder: (context, index) =>
                        NewsCard(
                            title: provider.newsModel?.articles![index].title
                                .toString() ??
                                "",
                            description: provider
                                .newsModel?.articles![index].description
                                .toString() ??
                                "",
                            date: provider
                                .newsModel?.articles![index].publishedAt,
                            imageUrl: provider
                                .newsModel?.articles![index].urlToImage
                                .toString() ??
                                "",
                            content: provider.newsModel?.articles![index]
                                .content.toString() ?? "",
                            sourceName: provider.newsModel?.articles![index]
                                .source.toString() ?? "",
                            url: provider.newsModel?.articles![index].url
                                .toString() ?? ""),
                    separatorBuilder: (context, index) =>
                    const Divider(height: 20),
                    itemCount: provider.newsModel?.articles?.length ?? 0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
