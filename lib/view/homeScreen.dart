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
    fetchData();
    super.initState();
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
      appBar: AppBar(leading:Text(""),
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
      body: homeProvider.isLoading == true
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

// class HomeScreen extends StatelessWidget {
//   void fetchData(BuildContext context) async {
//     Provider.of<HomeController>(context, listen: false).fetchDataFromApi();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     fetchData(context); // Call fetchData in build method (consider whether it's needed here)
//
//     return Consumer<HomeController>(
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
