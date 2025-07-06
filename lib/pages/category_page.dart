import 'package:blinknews/model/show_category.dart';
import 'package:blinknews/pages/article_view.dart';
import 'package:blinknews/services/category_news.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget {
  String name;
  CategoryPage({super.key, required this.name});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List<ShowCategory> cat = [];
  @override
  void initState() {
    getcat();

    super.initState();
  }

  getcat() async {
    CategoryNews catclass = CategoryNews();
    await catclass.getcategory(widget.name.toLowerCase());
    setState(() {
      cat = catclass.categories;
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
              Text(
                widget.name,
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: ListView.builder(
            // shrinkWrap: true,
            itemCount: cat.length,
            itemBuilder: (context, index) {
              return ShowCategories(
                  url: cat[index].url!,
                  des: cat[index].description!,
                  image: cat[index].urlToImage!,
                  title: cat[index].title!);
            }));
  }
}

class ShowCategories extends StatelessWidget {
  String image, des, title, url;
  ShowCategories(
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
