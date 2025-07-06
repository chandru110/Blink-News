import 'package:blinknews/model/article_model.dart';
import 'package:blinknews/model/category_model.dart';
import 'package:blinknews/model/slider_model.dart';
import 'package:blinknews/pages/article_view.dart';
import 'package:blinknews/services/news.dart';
import 'package:blinknews/services/slider_data.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AllNews extends StatefulWidget {
  String news;
  AllNews({super.key, required this.news});

  @override
  State<AllNews> createState() => _AllNewsState();
}

class _AllNewsState extends State<AllNews> {
  List<Articlemodel> articles = [];
  List<SliderModel> slider_list = [];
  @override
  void initState() {
    getSlider();
    getNews();

    super.initState();
  }

  getNews() async {
    News newsclass = News();
    await newsclass.getNews();
    setState(() {
      articles = newsclass.news;
    });
    // articles = newsclass.news;

    print("Articles fetched: ${articles.length}");
  }

  getSlider() async {
    SliderService sliderclass = SliderService();
    await sliderclass.getSlider();
    setState(() {
      slider_list = sliderclass.slider;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Blink"),
            Text(
              "News",
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
          child: ListView.builder(
              // shrinkWrap: true,
              itemCount: widget.news == "breaking"
                  ? slider_list.length
                  : articles.length,
              itemBuilder: (context, index) {
                return Allcat(
                    url: widget.news == "breaking"
                        ? slider_list[index].url!
                        : articles[index].url!,
                    des: widget.news == "breaking"
                        ? slider_list[index].description!
                        : articles[index].description!,
                    image: widget.news == "breaking"
                        ? slider_list[index].urlToImage!
                        : articles[index].urlToImage!,
                    title: widget.news == "breaking"
                        ? slider_list[index].title!
                        : articles[index].title!);
              })),
    );
  }
}

class Allcat extends StatelessWidget {
  String image, des, title, url;
  Allcat(
      {super.key,
      required this.image,
      required this.des,
      required this.title,
      required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ArticleView(blogurl: url);
        }));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: image,
                width: MediaQuery.of(context).size.width,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 3,
            ),
            Text(
              title,
              maxLines: 2,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(
              height: 10,
            ),
            Text(des),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
