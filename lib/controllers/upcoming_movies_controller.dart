import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/upcoming_movies_model.dart';

class UpcomingMoviesController extends GetxController {
  var upcomingMovies = <Result>[].obs;
  var filteredMovies = <Result>[].obs; // Add a new observable list for filtered movies

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUpcomingMovies();
  }

  Future<void> fetchUpcomingMovies() async {
    try {

      isLoading(true);

      final response = await http.get(
        Uri.parse("https://api.themoviedb.org/3/movie/upcoming?api_key=155bf92a0cb4adca560b4b5f213dacfa"),
      );

      if (response.statusCode == 200) {
        final upcomingMoviesData = upcomingMoviesFromJson(response.body);
        upcomingMovies.assignAll(upcomingMoviesData.results!);
        filteredMovies.assignAll(upcomingMovies); // Initialize filteredMovies with all movies
      } else {
        print("Error fetching data: ${response.statusCode}");
      }
    } on Exception catch (e) {
      print("Exception occurred: $e");
    } finally {
      isLoading(false);
    }
  }

  // Method to search movies based on the provided query
  void searchMovies(String query) {
    if (query.isEmpty) {
      // If the query is empty, reset the filteredMovies to show all movies
      print("The query is empty");
      filteredMovies.assignAll(upcomingMovies);
    } else {
      // Filter movies based on the query
      print("The query is not empty");
      filteredMovies.assignAll(upcomingMovies
          .where((movie) => movie.title?.toLowerCase().contains(query.toLowerCase()) ?? false)
          .toList());
      print("printing searched list");
      for (var result in filteredMovies) {
        print("Title: ${result.originalTitle}, Poster Path: ${result.posterPath}");
      }
    }
  }
}
