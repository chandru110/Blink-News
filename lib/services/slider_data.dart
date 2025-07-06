import 'dart:convert';
import 'package:blinknews/model/slider_model.dart';
import 'package:http/http.dart' as http;

class SliderService {
  List<SliderModel> slider = [];

  // Maximum number of articles to fetch
  final int maxArticles = 5;

  Future<void> getSlider() async {
    String url =
        "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=0060044824014a8492fb1dc17849bcfe";

    try {
      final response = await http
          .get(Uri.parse(url))
          .timeout(Duration(seconds: 10)); // add timeout

      print("Status Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        if (jsonData['status'] == 'ok' && jsonData['articles'] is List) {
          for (var element in jsonData['articles']) {
            final title = element["title"] ?? "";
            final imageUrl = element["urlToImage"];
            final description = element["description"];

            if (_isEnglish(title) && imageUrl != null && description != null) {
              bool imageOk = await _isImageValid(imageUrl);
              if (!imageOk) continue;

              slider.add(SliderModel(
                title: title,
                author: element["author"] ?? "Unknown",
                description: description,
                url: element["url"] ?? "",
                urlToImage: imageUrl,
                content: element["content"] ?? "",
              ));

              print("Added: $title");

              // Stop when max articles reached
              // if (slider.length >= maxArticles) break;
            }
          }
        } else {
          print("API response status not OK or articles list missing.");
        }
      } else {
        print("Failed to load news. Status Code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error occurred while fetching news: $e");
    }
  }

  // Validate image URL using http.head
  Future<bool> _isImageValid(String url) async {
    try {
      final response = await http.head(Uri.parse(url));
      return response.statusCode == 200;
    } catch (e) {
      print("Image check failed for $url: $e");
      return false;
    }
  }

  // Improved English text checker (allows some non-ASCII)
  bool _isEnglish(String text) {
    final nonAscii = RegExp(r'[^\x00-\x7F]');
    final total = text.length;
    if (total == 0) return false;
    final nonAsciiCount = nonAscii.allMatches(text).length;
    return (nonAsciiCount / total) < 0.2;
  }
}
