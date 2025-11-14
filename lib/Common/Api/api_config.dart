
class ApiConfig {
  static const String baseUrl = 'https://your-backend.example.com/api';


  static const String searchHistoryGet = '/travel/search/history'; // GET
  static const String searchHistoryPost = '/travel/search';         // POST {query}
  static const String searchClickPost   = '/travel/click';          // POST {placeId,name}
  static const String placesSearchGet   = '/travel/places';         // GET ?q=
}
