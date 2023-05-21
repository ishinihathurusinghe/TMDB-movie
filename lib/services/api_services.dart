import 'dart:convert';

import 'package:http/http.dart';
import 'package:tmdb_movie_app/models/movie_details_model.dart';
import 'package:tmdb_movie_app/models/movies_model.dart';

class ApiService {
  //API Key
  final apiKey = "api_key=b86d410c5ccd0b147f53f1b512c66523";
  //TMDB Popular movies endpoint
  final popularMovies =
      "https://api.themoviedb.org/3/movie/popular?";

  Future<List<Movie>> getMovies({required int page}) async {
    Response response = await get(Uri.parse("$popularMovies$apiKey&page=$page"));

    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);

      List<dynamic> data = body['results'];
      print(data);
      List<Movie> movies = data.map((movie) => Movie.fromJson(movie)).toList();
      return movies;
    } else {
      throw Exception(response.statusCode);
    }
  }

  Future<MovieDetailsModel> getDetails({required String id}) async {
    Response response =
        await get(Uri.parse("https://api.themoviedb.org/3/movie/$id?$apiKey"));
    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      return MovieDetailsModel.fromJson(json);
    } else {
      throw Exception(response.statusCode);
    }
  }
}
