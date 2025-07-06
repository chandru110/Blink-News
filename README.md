# 🗞️ BlinkNews - Flutter News App

**BlinkNews** is a sleek and modern Flutter application that displays live news fetched from [NewsAPI.org](https://newsapi.org). It offers a smooth user experience with categorized news, trending headlines, and full-article views in an in-app browser (WebView).

---

## 🚀 Features

- 🖼️ Beautiful **landing screen** with Get Started button  
- 📂 **Category-based news** (e.g., General, Entertainment, etc.)  
- 🔥 **Breaking news slider**  
- 📊 **Trending news cards**  
- 🌐 In-app **WebView** for reading full articles  
- 📡 Data fetched via REST API using [NewsAPI.org](https://newsapi.org)  

---

## 🏗️ Folder Structure

```bash
lib/
├── images/                  # UI images
├── model/                   # News model classes
├── pages/                   # Screens & UI components
│   ├── all_news.dart
│   ├── article_view.dart    # WebView page
│   ├── category_news.dart
│   ├── home.dart
│   └── landing_page.dart
├── services/                # API logic
│   ├── category_news.dart
│   ├── data.dart
│   ├── news.dart
│   └── slider_data.dart
└── main.dart                # App entry point
🔑 Getting Started
1. Clone the repository
bash
Copy
Edit
git clone https://github.com/chandru110/Blink-News.git
cd Blink-News
2. Get your NewsAPI Key
Go to https://newsapi.org

Sign up and copy your API key

3. Replace your API key

4. Run the app
bash
Copy
Edit
flutter pub get
flutter run
📌 Future Enhancements
 Add search functionality 🔍

 Dark mode 🌙

 Bookmark/save news items ⭐

 Push notifications for breaking news 🔔

👨‍💻 Developer
Chandru S
Flutter Developer | B.Tech CSE - Amrita Vishwa Vidyapeetham
📍 Chennai, India
