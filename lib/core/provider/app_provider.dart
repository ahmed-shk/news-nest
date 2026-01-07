import 'package:algoocean/model/news_response.dart';
import 'package:flutter/foundation.dart';

import '../../generated/assets.dart';
import '../../model/category_model.dart';
import '../config/app_config.dart';
import '../service/app_service.dart';

class AppProvider extends ChangeNotifier {
  final List<CategoryModel> _categoryList = [
    CategoryModel(
      title: "Business",
      keyword: "business",
      image: Assets.imagesBusiness,
    ),
    CategoryModel(
      title: "Entertainment",
      keyword: "entertainment",
      image: Assets.imagesEntertainment,
    ),
    CategoryModel(
      title: "Health",
      keyword: "health",
      image: Assets.imagesHealth,
    ),
    CategoryModel(
      title: "Science",
      keyword: "science",
      image: Assets.imagesScience,
    ),
    CategoryModel(
      title: "Sports",
      keyword: "sports",
      image: Assets.imagesSports,
    ),
    CategoryModel(
      title: "Technology",
      keyword: "technology",
      image: Assets.imagesTechnology,
    ),
  ];

  List<CategoryModel> get categoryList => _categoryList;

  String getGreeting() {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return "Good Morning";
    } else if (hour < 17) {
      return "Good Afternoon";
    } else {
      return "Good Evening";
    }
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  int _page = 1;
  final int _pageSize = 10;
  bool _hasMore = true;
  void resetPagination() {
    _page = 1;
    _hasMore = true;
    _newsResponse = null;
  }

  NewsResponse? _newsResponse;
  NewsResponse? get newsResponse => _newsResponse;
  Future<void> fetchNewsByCategory1(String category) async {
    if (_isLoading || !_hasMore) return;
    _setLoading(true);
    try {
      final url =
          "${ApiConfig.baseUrl}/everything"
          "?q=$category"
          "&page=$_page"
          "&pageSize=20"
          "&apiKey=${ApiConfig.apiKey}";
      final data = await ApiService.get(url);
      final fetchedNews = NewsResponse.fromJson(data);
      if (_newsResponse == null || _page == 1) {
        _newsResponse = fetchedNews;
      } else {
        _newsResponse!.articles?.addAll(fetchedNews.articles ?? []);
      }
      if (fetchedNews.articles!.length < _pageSize) {
        _hasMore = false;
      } else {
        _page++;
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching news: $e");
      }
    } finally {
      _setLoading(false);
    }
  }



  int _pageSearch = 1;
  final int _pageSizeSearch = 10;
  bool _hasMoreSearch = true;
  void resetSearchPagination() {
    _pageSearch = 1;
    _hasMoreSearch = true;
    _newsSearchResponse = null;
    notifyListeners();
  }
  NewsResponse? _newsSearchResponse;
  NewsResponse? get newsSearchResponse => _newsSearchResponse;
  Future<void> fetchSearch(String key) async {
    if (_isLoading || !_hasMoreSearch) return;
    _setLoading(true);
    try {
      final url =
          "${ApiConfig.baseUrl}/everything"
          "?q=$key"
          "&page=$_pageSearch"
          "&pageSize=20"
          "&apiKey=${ApiConfig.apiKey}";
      final data = await ApiService.get(url);
      final fetchedNews = NewsResponse.fromJson(data);
      if (_newsSearchResponse == null || _pageSearch == 1) {
        _newsSearchResponse = fetchedNews;
      } else {
        _newsSearchResponse!.articles?.addAll(fetchedNews.articles ?? []);
      }
      if (fetchedNews.articles!.length < _pageSizeSearch) {
        _hasMoreSearch = false;
      } else {
        _pageSearch++;
      }
    } catch (e) {
        print("Error fetching news: $e");
      
    } finally {
      _setLoading(false);
    }
  }


}
