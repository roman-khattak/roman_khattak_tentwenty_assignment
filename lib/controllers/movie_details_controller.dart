import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/movie_details_screen.dart';

class MovieDetailsController extends GetxController {

  final Rx<MovieDetailsScreen> movieDetails = MovieDetailsScreen().obs;

  Future<void> fetchMovieDetails(int movieId) async {
    final url = 'https://api.themoviedb.org/3/movie/$movieId?api_key=155bf92a0cb4adca560b4b5f213dacfa';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      print("printing statuscode = ${response.statusCode}");
      final movieDetailsData = movieDetailsScreenFromJson(response.body);
      movieDetails.value = movieDetailsData;


    } else {
      throw Exception('Failed to load movie details');
    }
  }
}
