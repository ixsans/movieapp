part of 'services.dart';

class MovieServices {
  static Future<List<Movie>> getMovies(int page, {http.Client client}) async {
    String url =
        "https://api.themoviedb.org/3/discover/movie?api_key=$apiKey&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=$page";

    client ??= http.Client();

    var response = await client.get(url);

    if (response.statusCode != 200) {
      return [];
    }

    var data = json.decode(response.body);
    List result = data['results'];

    return result.map((e) => Movie.fromJson(e)).toList();
  }

  static Future<MovieDetail> getMovieDetail(Movie movie,
      {int movieId, http.Client client}) async {
    String url =
        "https://api.themoviedb.org/3/movie/${movie != null ? movie.id : movieId}?api_key=$apiKey&language=en-US";
    client ??= http.Client();

    var response = await client.get(url);

    if (response.statusCode != 200) {
      return null;
    }
    var data = json.decode(response.body);

    // Genre
    List genres = (data as Map<String, dynamic>)['genres'];

    List genreNameList = genres
        .map((e) => (e as Map<String, dynamic>)['name'].toString())
        .toList();

    // Language
    var language = "";
    switch ((data as Map<String, dynamic>)['original_language'].toString()) {
      case 'en':
        language = "English";
        break;
      case 'ja':
        language = "Japanese";
        break;
      case 'id':
        language = "Indonesian";
        break;
      case 'ko':
        language = "Korean";
        break;
      default:
        language = "";
    }

    return movie != null
        ? MovieDetail(movie, genres: genreNameList, language: language)
        : MovieDetail(Movie.fromJson(data as Map<String, dynamic>),
            genres: genreNameList, language: language);
  }

  static Future<List<Credit>> getCredits(int movieId,
      {http.Client client}) async {
    String url =
        "https://api.themoviedb.org/3/movie/$movieId/credits?api_key=$apiKey";

    client ??= http.Client();

    var response = await client.get(url);

    if (response.statusCode != 200) {
      return null;
    }

    var data = json.decode(response.body);

    List casts = (data as Map<String, dynamic>)['cast'];

    return casts
        .map((e) => Credit(
              name: (e as Map<String, dynamic>)['name'].toString(),
              profilePath:
                  (e as Map<String, dynamic>)['profile_path'].toString(),
            ))
        .take(8)
        .toList();
  }
}
