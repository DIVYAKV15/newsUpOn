import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:newsupon/controller/category_controller.dart';
import 'package:newsupon/view/widgets/news_card.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  void fetchData() {
    Provider.of<CategoryController>(context, listen: false).fetchData();
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<CategoryController>(context);
    return DefaultTabController(
      initialIndex: 0,
      length: provider.categoryList.length,
      child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text(
              "Categories",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w600),
            ),
            bottom: TabBar(
              isScrollable: true,
              labelStyle: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              unselectedLabelStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
              overlayColor: MaterialStatePropertyAll(Colors.yellow),
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorPadding: EdgeInsets.symmetric(horizontal: 5),
              indicator: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.circular(10)),
              tabs: List.generate(
                provider.categoryList.length,
                (index) => Tab(
                  text: provider.categoryList[index],
                ),
              ),
              onTap: (value) => provider.onTap(index: value),
            ),
          ),
          body: provider.isLoading == true
              ? Center(
                  child: Lottie.asset(
                      "asset/animations/Animation - 1706853567309.json",
                      fit: BoxFit.cover,
                      height: 150,
                      width: 150),
                )
              : Padding(
                  padding: EdgeInsets.all(10),
                  child: ListView.separated(
                      itemBuilder: (context, index) => NewsCard(
                          title: provider.newsModel.articles![index].title.toString() ??
                              "",
                          description: provider
                                  .newsModel.articles![index].description
                                  .toString() ??
                              "",
                          date: provider.newsModel.articles![index].publishedAt,
                          imageUrl: provider.newsModel.articles![index].urlToImage
                                  .toString() ??
                              "",
                          content: provider.newsModel.articles![index].content
                                  .toString() ??
                              "",
                          sourceName: provider.newsModel.articles![index].source.toString() ?? "",
                          url: provider.newsModel.articles![index].url.toString() ?? ""),
                      separatorBuilder: (context, index) => Divider(height: 20),
                      itemCount: provider.newsModel.articles?.length ?? 0),
                )),
    );
  }
}
// class CAtegoryScreen extends StatelessWidget {
//   void fetchData(BuildContext context) async {
//     Provider.of<CategoryController>(context, listen: false).fetchData();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     fetchData(context); // Call fetchData in build method (consider whether it's needed here)
//
//     return Consumer<CategoryController>(
//       builder: (context, provider, child) {
//         return DefaultTabController(
//           length: provider.categoryList.length,
//           initialIndex: 0,
//           child: Scaffold(
//             appBar: AppBar(
//               elevation: 0,
//               backgroundColor: Colors.white,
//               titleTextStyle: const TextStyle(
//                   color: Color(0xff6A3DE8),
//                   fontSize: 20,
//                   fontWeight: FontWeight.w600),
//               title: const Text("Categories"),
//               bottom: TabBar(
//                 labelStyle: const TextStyle(
//                     color: Color(0xff6A3DE8), fontWeight: FontWeight.w600),
//                 labelColor: Colors.white,
//                 unselectedLabelColor: const Color(0xff6A3DE8),
//                 indicatorPadding: const EdgeInsets.symmetric(horizontal: 5),
//                 unselectedLabelStyle: const TextStyle(
//                     color: Color(0xff6A3DE8),
//                     fontSize: 15,
//                     fontWeight: FontWeight.w500),
//                 overlayColor: const MaterialStatePropertyAll(Colors.grey),
//                 indicatorSize: TabBarIndicatorSize.tab,
//                 indicator: BoxDecoration(
//                     color: const Color(0xff6A3DE8),
//                     borderRadius: BorderRadius.circular(10)),
//                 isScrollable: true,
//                 tabs: List.generate(
//                   provider.categoryList.length,
//                       (index) => Tab(
//                     text: provider.categoryList[index],
//                   ),
//                 ),
//                 onTap: (value) {
//                   provider.onTap(index: value);
//                 },
//               ),
//             ),
//             body: provider.isLoading == true
//                 ? Center(
//                 child: LottieBuilder.asset(
//                   "assets/animations/Animation - 1702395258490 (2).json",
//                   fit: BoxFit.cover,
//                   height: 150,
//                   width: 150,
//                 ))
//                 : Padding(
//               padding: const EdgeInsets.all(10),
//               child: ListView.separated(
//                   itemBuilder: (context, index) => NewsCard(
//                     title: provider.newsModel.articles?[index].title
//                         .toString() ??
//                         "",
//                     description: provider
//                         .newsModel.articles?[index].description
//                         .toString() ??
//                         "",
//                     date: provider
//                         .newsModel.articles?[index].publishedAt,
//                     imageUrl: provider
//                         .newsModel.articles?[index].urlToImage
//                         .toString() ??
//                         "",
//                     contant: provider
//                         .newsModel.articles?[index].content
//                         .toString() ??
//                         "",
//                     sourceName: provider
//                         .newsModel.articles?[index].source?.name
//                         .toString() ??
//                         "",
//                     url: provider.newsModel.articles?[index].url
//                         .toString() ??
//                         "",
//                   ),
//                   separatorBuilder: (context, index) => const Divider(
//                     height: 20,
//                   ),
//                   itemCount: provider.newsModel.articles?.length ?? 0),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }