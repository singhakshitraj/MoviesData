class Endpoints {
  static String baseUrl = "https://api.themoviedb.org/3";
  static String apiKey = "?api_key=87c1db0e42e8162971af9bd5b6e4637e";
  static String baseTrending = 'https://api.themoviedb.org/3/trending/';
  static String baseImg = 'https://image.tmdb.org/t/p/w500';
  String completeImageUrl(String str) {
    return Endpoints.baseImg + str;
  }
}
