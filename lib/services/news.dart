import 'dart:convert';
import 'dart:io';
import 'package:blinknews/model/article_model.dart';
import 'package:http/http.dart' as http;

class News {
  List<Articlemodel> news = [];

  Future<void> getNews() async {
    final today = DateTime.now();
    final fromDate = today.subtract(Duration(days: 7));
    final formattedFromDate = fromDate.toIso8601String().split('T')[0];

    String url =
        "https://newsapi.org/v2/everything?q=tesla&from=$formattedFromDate&sortBy=publishedAt&apiKey=0060044824014a8492fb1dc17849bcfe";

    try {
      var response = await http.get(Uri.parse(url));
      // print("Status Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);

        if (jsondata['status'] == 'ok') {
          for (var element in jsondata['articles']) {
            final title = element["title"] ?? "";
            final imageUrl = element["urlToImage"];
            final description = element["description"];

            if (_isEnglish(title) && imageUrl != null && description != null) {
              bool imageOk = await _isImageValid(imageUrl);
              if (!imageOk) continue;

              news.add(Articlemodel(
                title: title,
                author: element["author"] ?? "Unknown",
                description: description,
                url: element["url"] ?? "",
                urlToImage: imageUrl,
                content: element["content"] ?? "",
              ));
              // print("Added: $title");
            }
          }
        } else {
          // print("API status not OK: ${jsondata['status']}");
        }
      } else {
        // print("Failed to load news. Status Code: ${response.statusCode}");
      }
    } catch (e) {
      // print("Error occurred while fetching news: $e");
    }
  }

  // Validate image URL by sending HEAD request
  Future<bool> _isImageValid(String url) async {
    try {
      final uri = Uri.parse(url);
      final request = await HttpClient().headUrl(uri);
      final response = await request.close();
      return response.statusCode == 200;
    } catch (e) {
      print("Image check failed for $url");
      return false;
    }
  }

  // Check if text is mostly English
  bool _isEnglish(String text) {
    return RegExp(r'^[\x00-\x7F]+$').hasMatch(text);
  }
}
