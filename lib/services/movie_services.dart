part of 'services.dart';

class MovieServices {
  static Future<List<MovieModel>> getMovies(int page,
      {http.Client? client}) async {
    String url =
        "https://api.themoviedb.org/3/discover/movie?api_key=$apiKey&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=$page&with_watch_monetization_types=flatrate";
    client ??= http.Client();

    var response = await client.get(Uri.parse(url));

    if (response.statusCode != 200) {
      print("status : " + response.statusCode.toString());
      // return [];
    } else {
      print("status : " + response.statusCode.toString());
    }
    var data = jsonDecode(response.body);
    List result = data['results'];
    print(result);

    return result.map((e) => MovieModel.fromJson(e)).toList();
  }
}
