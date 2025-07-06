import 'package:blinknews/model/article_model.dart';
import 'package:blinknews/model/category_model.dart';
import 'package:blinknews/model/slider_model.dart';
import 'package:blinknews/pages/all_news.dart';
import 'package:blinknews/pages/article_view.dart';
import 'package:blinknews/pages/category_page.dart';
import 'package:blinknews/services/data.dart';
import 'package:blinknews/services/news.dart';
import 'package:blinknews/services/slider_data.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart' hide Slider;
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int active_index = 0;
  List<CategoryModel> category = [];
  List<SliderModel> slider_list = [];
  List<Articlemodel> articles = [];
  // bool _loading = true;
  @override
  void initState() {
    // TODO: implement initState
    category = getCategory();
    getSlider();
    getNews();
    print("Trending articles count: ${articles.length}");

    super.initState();
  }

  getNews() async {
    News newsclass = News();
    await newsclass.getNews();
    // articles = newsclass.news;
    setState(() {
      articles = newsclass.news;
    });
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
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 10, top: 8),
                height: 100,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: category.length,
                  itemBuilder: (context, index) {
                    return CategoryTile(
                      image: category[index].image,
                      categoryname: category[index].categoryname,
                    );
                  },
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsetsGeometry.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Breaking News!",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return AllNews(news: "breaking");
                        }));
                      },
                      child: Text(
                        "View All",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ),
              CarouselSlider.builder(
                itemCount: slider_list.length,
                itemBuilder: (context, index, realIndex) {
                  String? res = slider_list[index].urlToImage;
                  String? res1 = slider_list[index].title;
                  String? res2 = slider_list[index].url!;
                  return builImage(res!, res1!, index, res2);
                },
                options: CarouselOptions(
                    height: 280,
                    // viewportFraction: 1,
                    enlargeCenterPage: true,
                    enlargeStrategy: CenterPageEnlargeStrategy.height,
                    autoPlay: true,
                    onPageChanged: (index, reason) {
                      setState(() {
                        active_index = index;
                      });
                    }),
              ),
              buildIndicator(),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsetsGeometry.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Trending News!",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return AllNews(news: "trending");
                        }));
                      },
                      child: Text(
                        "View All",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 0,
              ),
              SizedBox(
                height: 5,
              ),
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                    return BlogTile(
                        url: articles[index].url!,
                        description: articles[index].description!,
                        imageurl: articles[index].urlToImage!,
                        title: articles[index].title!);
                  })
            ],
          ),
        ),
      ),
    );
  }

  Widget buildIndicator() {
    return Center(
      child: AnimatedSmoothIndicator(
        activeIndex: active_index,
        count: slider_list.length,
        effect: SlideEffect(
            dotWidth: 10, dotHeight: 10, activeDotColor: Colors.blue),
      ),
    );
  }

  Widget builImage(String image, String name, int index, String url) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ArticleView(blogurl: url);
        }));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CachedNetworkImage(
                imageUrl: image,
                height: 250,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              margin: EdgeInsets.only(top: 180),
              padding: EdgeInsets.only(left: 10),
              width: MediaQuery.of(context).size.width,
              height: 70,
              child: Text(
                name,
                maxLines: 2,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final image;
  final categoryname;
  const CategoryTile({super.key, this.image, this.categoryname});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return CategoryPage(name: categoryname);
        }));
      },
      child: Container(
        margin: EdgeInsets.only(right: 16),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                image,
                width: 140,
                height: 90,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: 140,
              height: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black26,
              ),
              child: Center(
                child: Text(
                  categoryname,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  String imageurl, title, description;
  String url;
  BlogTile(
      {super.key,
      required this.description,
      required this.imageurl,
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
        margin: EdgeInsets.only(bottom: 10),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Material(
            borderRadius: BorderRadius.circular(10),
            elevation: 6,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CachedNetworkImage(
                          imageUrl: imageurl,
                          height: 120,
                          width: 120,
                          fit: BoxFit.cover,
                        )),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Text(
                          title,
                          maxLines: 2,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.8,
                        child: Text(
                          description,
                          maxLines: 3,
                          style: TextStyle(
                            color: Colors.black26,
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
